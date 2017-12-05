//
//  Socket.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/15.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation

public protocol SocketDelegate : NSObjectProtocol {
    func socketDidConnected()
    func socketDidClose(_ msg:String?)
    func socketDidWrite(_ topid:Int)
    func socketDidRead(_ data:Data)
    func socketDidError(_ error:Error?)
}

public class Socket : NSObject, StreamDelegate {
    private var ip:String
    private var port:Int
    private var inputStream:InputStream? = nil
    private var outputStream:OutputStream? = nil
    private weak var delegate:SocketDelegate?
    
    private var writeDatas:Array<WriteDataPack> = Array()
    
    private var socketStatus:SocketStatus = SocketStatus.Disconnect
    private var notifyError:Bool = false
    
    public init(_ delegate:SocketDelegate) {
        self.ip = SocketConstant.ip
        self.port = SocketConstant.port
        self.delegate = delegate
        super.init()
    }
    
    public init(_ ip:String, _ port:Int, _ delegate:SocketDelegate) {
        self.ip = ip
        self.port = port
        self.delegate = delegate
        super.init()
    }
    
    func start() -> Void {
        if socketStatus != .Disconnect {
            return;
        }
        socketStatus = .Connecting
        
        Stream.getStreamsToHost(withName: ip, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        inputStream!.delegate = self
        outputStream!.delegate = self
        inputStream!.schedule(in: RunLoop.current, forMode: RunLoopMode.commonModes)
        outputStream!.schedule(in: RunLoop.current, forMode: RunLoopMode.commonModes)
        
        inputStream!.open()
        outputStream!.open()
    }
    
    func close() -> Void {
        socketStatus = .Disconnect
        if inputStream != nil {
            inputStream!.close()
            inputStream!.remove(from: RunLoop.current, forMode: RunLoopMode.commonModes)
            inputStream!.delegate = nil
            inputStream = nil
        }
        if outputStream != nil {
            outputStream!.close()
            outputStream!.remove(from: RunLoop.current, forMode: RunLoopMode.commonModes)
            outputStream!.delegate = nil
            outputStream = nil
        }
    }
    
    func restart() -> Void {
        close()
        start()
    }
    
    public func isConnected() -> Bool {
        return self.socketStatus == .Connected
    }
    
    
    public final func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case Stream.Event.openCompleted:
            if aStream == outputStream && outputStream?.streamStatus == .open && inputStream?.streamStatus == .open {
                socketStatus = .Connected
                delegate!.socketDidConnected()
//                logdebug("socketDidConnected");
            }
            break
        case Stream.Event.hasBytesAvailable:
            read()
            break
        case Stream.Event.hasSpaceAvailable:
            write()
            break
        case Stream.Event.errorOccurred:
//            logdebug("\(String(describing: inputStream?.streamStatus.rawValue)) -- \(String(describing: outputStream?.streamStatus.rawValue))")
            streamError(aStream)
            break
        case Stream.Event.endEncountered:
//            logdebug("\(String(describing: inputStream?.streamStatus.rawValue)) -- \(String(describing: outputStream?.streamStatus.rawValue))")
            streamClose()
            break
        default:
            break
        }
    }
    
    private func streamClose() {
        var errorMessage:String? = nil
        if (inputStream?.streamStatus != .atEnd || outputStream?.streamStatus != .atEnd) {
            errorMessage = "未全部关闭输入流和输出流";
        }
        delegate!.socketDidClose(errorMessage)
    }
    
    private func streamError(_ stream: Stream) {
        if notifyError {
            notifyError = false
            return;
        }
        notifyError = true
        delegate!.socketDidError(stream.streamError)
    }
    
    func write(_ topid:Int, _ data:Data) -> Void {
        let writeData = WriteDataPack(topid, data)
        writeDatas.append(writeData)
        write()
    }
    
    private func write() -> Void {
        if !outputStream!.hasSpaceAvailable {
            return
        }
        if writeDatas.count < 1 {
            return
        }
        let dataPack = writeDatas.first!
        writeDatas.removeFirst()
        var data = dataPack.data
        let topid = dataPack.topid
        
        data.withUnsafeBytes { (pointer:UnsafePointer<UInt8>) -> Void in
            let length = data.count
            let len = outputStream!.write(pointer, maxLength: length)
            if len < length  {
                data = data.subdata(in: (len..<length))
                dataPack.data = data
                writeDatas.insert(dataPack, at: 0)
            }
            else {
                delegate!.socketDidWrite(topid)
            }
        }
    }
    
    private func read() -> Void {
        var receivedData:Data = Data.init(count: SocketConstant.maxBufferLength)
        receivedData.withUnsafeMutableBytes({ (pointer:UnsafeMutablePointer<UInt8>) -> Void in
            let len = inputStream?.read(pointer, maxLength: SocketConstant.maxBufferLength)
            if len! < 1 || inputStream?.streamStatus == .notOpen || inputStream?.streamStatus == .atEnd || inputStream?.streamStatus == .closed || inputStream?.streamStatus == .error {
                return
            }
            if len! < SocketConstant.maxBufferLength {
                receivedData = receivedData.subdata(in: (0..<len!))
            }
            delegate!.socketDidRead(receivedData)
        })
    }
}

public class WriteDataPack : NSObject {
    public var topid = -1
    public var data = Data()
    
    init(_ topid: Int, _ data: Data) {
        self.topid = topid
        self.data = data
        super.init()
    }
}
