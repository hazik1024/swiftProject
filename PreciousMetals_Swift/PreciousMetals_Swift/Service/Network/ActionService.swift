//
//  ActionService.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/12/4.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class ActionService: NSObject, SocketDelegate {
    public static let INSTANCE = ActionService()
    
    private override init() {}
    
    private let writeQueue:DispatchQueue = DispatchQueue(label: "com.ksjf.service.ActionService.writequeue")
    private let timoutService: TimeoutService = TimeoutService()
    private var targets = Dictionary<Int, Set<NSObject>>()
    private var socket:Socket?
    private var isFirstDisconnect:Bool = true
    private var heartBeatTimer:DispatchSourceTimer?
    private var heartBeatCounter:Int = 0
    private var receiveData:Data = Data()
    private var actionTimeout = true
    
    private var rebootSocket:Bool = true
    
    public static func start() {
        INSTANCE.start()
    }
    public static func close() {
        INSTANCE.close()
    }
    public static func restart() {
        INSTANCE.restart()
    }
    
    private func start() {
        if socket == nil {
            logdebug("ActionService start")
            heartBeatCounter = 0
            socket = Socket(self)
            socket?.start()
        }
        startHeartBeat()
    }
    private func close() {
        if socket != nil {
            logdebug("ActionService close")
            socket?.close()
            socket = nil
            receiveData.removeAll()
        }
    }
    private func restart() {
        logdebug("ActionService retart")
        close()
        clear()
        start()
    }
    
    private func clear() {
        for topid in targets.keys {
            let set = targets[topid]
            if set != nil && (set?.count)! > 0 {
                for tar in set! {
                    let action = tar as! BaseAction
                    action.target?.networkDidFailed(action, .Reset_Socket)
                }
            }
        }
        targets.removeAll()
        timoutService.removeAll()
    }
    
    private func timeoutHandler(_ topid: Int) -> Void {
        objc_sync_enter(self)
        let set = targets[topid]
        if set != nil && (set?.count)! > 0 {
            for tar in set! {
                let action = tar as! BaseAction
                action.target?.networkDidFailed(action, .ReadData_Timeout)
            }
        }
        targets.removeValue(forKey: topid)
        objc_sync_exit(self)
    }
    
    // MARK: Heartbeat Timer
    private func startHeartBeat() {
        if heartBeatTimer == nil {
            heartBeatTimer = DispatchSource.makeTimerSource(queue: .main)
            heartBeatTimer?.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(2), leeway: DispatchTimeInterval.seconds(10))
            heartBeatTimer?.setEventHandler(handler: {
                self.heartBeatCounter += 1
                if self.heartBeatCounter > 6 {
                    ActionService.request(HeartbeatAction(nil))
                }
            })
            heartBeatTimer?.resume()
        }
    }
    private func stopHeartBeat() {
        if heartBeatTimer != nil {
            heartBeatTimer?.cancel()
            heartBeatTimer = nil
        }
    }
    
    // MARK: Request
    public static func request(_ action:BaseAction) {
        INSTANCE.request(action)
    }
    
    public func request(_ action:BaseAction) {
        //检测App是否在前台
        let block = { () -> Bool in
            if UIApplication.shared.applicationState == UIApplicationState.background {
                return true
            }
            return false
        }
        if CommonUtil.executeInMainQueue(block) {
            logdebug("App已进入后台，忽略请求:\(action.topid)")
            return
        }
        //检测socket是否正常
        if !((socket?.isConnected())!) && action.target != nil  {
            action.target?.networkDidFailed(action, .Server_Disable)
        }
        //发送请求开始
        action.target?.networkDidRequestStart(action)
        
        let item = DispatchWorkItem(qos: DispatchQoS.default, flags: DispatchWorkItemFlags.barrier) {
            let data = action.packData()
            if data != nil && data!.count > 0 {
                var targets = self.targets[action.topid]
                if targets == nil {
                    targets = Set()
                }
                targets?.insert(action)
                self.targets[action.topid] = targets
                self.socket?.write(action.topid, data!)
            }
        }
        writeQueue.async(execute: item)
    }
    
    // MARK: SocketDelegate
    func socketDidConnected() {
        logdebug("socketDidConnected")
        DeviceInfo.INSTANCE.isNetworkOK = true
    }
    func socketDidClose(_ msg: String?) {
        DeviceInfo.INSTANCE.isNetworkOK = false
        receiveData.removeAll()
        if msg != nil {
            logdebug("socket未正常关闭:\(msg ?? "")")
            restart()
        }
        else {
            logdebug("socket正常关闭")
            close()
        }
    }
    func socketDidError(_ error: Error?) {
        logdebug("socketDidError:\(error.debugDescription)")
        if rebootSocket {
            rebootSocket = false
            restart()
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(3), execute: {
                self.restart()
            })
        }
    }
    func socketDidWrite(_ topid: Int) {
        self.heartBeatCounter = 0
        let set = self.targets[topid]
        if set != nil && (set?.count)! > 0 {
            DispatchQueue.main.async {
                for tar in set! {
                    let action = tar as! BaseAction
                    action.target?.networkDidRequestCompleted(action)
                }
            }
        }
    }
    func socketDidRead(_ data: Data) {
        receiveData.append(data)
        while receiveData.count > NetworkConstant.headLength + NetworkConstant.topIdLength {
            let head = receiveData.subdata(in: 0..<NetworkConstant.headLength)
            let totallen = NetworkSetting.INSTANCE.getTotalLength(head)
            if receiveData.count < totallen {
                return
            }
            if totallen < 1 || totallen > 16777216 {
                receiveData = receiveData.subdata(in: 1..<receiveData.count)
                socketDidRead(Data())
                continue
            }
            
            let topIdData = receiveData.subdata(in: NetworkConstant.headLength..<(NetworkConstant.headLength + NetworkConstant.topIdLength))
            var topid:Int? = Int(String(data: topIdData, encoding: String.Encoding.utf8) ?? "0")
            if topid == nil {
                topid = 0
            }
            var bodyData:Data = Data()
            if ActionSetting.INSTANCE.containAction(topid!) {
                bodyData = receiveData.subdata(in: (NetworkConstant.headLength + NetworkConstant.topIdLength)..<totallen)
            }
            else {
                bodyData = receiveData.subdata(in: NetworkConstant.headLength..<totallen)
            }
            receiveData = receiveData.subdata(in: totallen..<receiveData.count)
            
            let response = NetworkSetting.INSTANCE.unpack(bodyData)
            if response == nil {
                return
            }
            if topid! < 1 {
                topid = response?["topid"] as? Int
            }
            if topid == ActionConstant.HEART_BEAT {
                logdebug("heart beat:\(response?.description ?? "")")
                continue
            }
            
            if self.actionTimeout {
                self.timoutService.remove(topid!)
            }
            
            let set = self.targets[topid!]
            if set != nil && (set?.count)! > 0 {
                DispatchQueue.main.async {
                    for tar in set! {
                        let action = tar as! BaseAction
                        action.setResponse(response)
                        action.target?.networkDidResponse(action)
                    }
                    let item = DispatchWorkItem(block: {
                        self.targets.removeValue(forKey: topid!)
                    })
                    self.writeQueue.sync(execute: item)
                }
            }
        }
    }
}
