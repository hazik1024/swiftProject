////
////  ActionServiceOld.swift
////  PreciousMetals_Swift
////
////  Created by hazik on 2017/6/15.
////  Copyright © 2017年 ksjf. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//public class ActionServiceOld: NSObject, SocketDelegate {
//    private static let INSTANCE = ActionServiceOld()
//
//    private override init() {}
//
//    private var targets = Dictionary<Int, NSHashTable<NSObject>>()
//    private var socket:Socket?
//    private var isFirstDisconnect:Bool = true
//    private var heartBeatTimer:DispatchSourceTimer?
//    private var heartBeatCounter:Int = 0
//    private var receiveData:Data = Data()
//
//    private let timoutService: TimeoutService = TimeoutService()
//    private var actionTimeout = true
//
//    private var rebootSocket:Bool = true
//
//    // MARK: - Service控制
//    public static func start() {
//        INSTANCE.start()
//    }
//    public static func close() {
//        INSTANCE.close()
//    }
//    public static func restart() {
//        INSTANCE.restart()
//    }
//
//    private func start() {
//        if socket == nil {
//            logdebug("ActionServiceOld start")
//            heartBeatCounter = 0
//            socket = Socket(self)
//            socket?.start()
//        }
//        startHeartBeat()
//    }
//    private func close() {
//        if socket != nil {
//            logdebug("ActionServiceOld close")
//            socket?.close()
//            socket = nil
//            receiveData.removeAll()
//        }
//    }
//    private func restart() {
//        logdebug("ActionServiceOld retart")
//        close()
//        clear()
//        start()
//    }
//
//    private func clear() {
//        for topid in targets.keys {
//            let set = targets[topid]
//            if set != nil && (set?.count)! > 0 {
//                for tar in set!.objectEnumerator() {
//                    let target = tar as! NetworkProtocol
//                    target.networkDidFailed(topid, target, .Reset_Socket)
//                }
//            }
//        }
//        targets.removeAll()
//        timoutService.removeAll()
//    }
//
//    private func timeoutHandler(_ topid: Int) -> Void {
//        objc_sync_enter(self)
//        let set = targets[topid]
//        if set != nil && (set?.count)! > 0 {
//            for tar in set!.objectEnumerator() {
//                let target = tar as! NetworkProtocol
//                target.networkDidFailed(topid, target, .ReadData_Timeout)
//            }
//        }
//        targets.removeValue(forKey: topid)
//        objc_sync_exit(self)
//    }
//
//    // MARK: 发起请求
//    public static func request(_ topid: Int, _ target: NetworkProtocol?, _ params: Dictionary<String, Any>) {
//        INSTANCE.request(topid, target, params)
//    }
//
//    private func request(_ topid: Int, _ target: NetworkProtocol?, _ params: Dictionary<String, Any>) {
//        if !Thread.current.isMainThread {
//            logdebug("not main thread:\(topid)")
//        }
//        if UIApplication.shared.applicationState == .background {
//            target!.networkDidFailed(topid, target!, .App_In_Background)
//            return
//        }
//        if !((socket?.isConnected())!) && target != nil  {
//            target!.networkDidFailed(topid, target!, .Server_Disable)
//        }
//
//        if target != nil {
//            target!.networkDidRequestStart(topid, target!)
//        }
//
//        var _params = params
//
//        if !ActionSetting.INSTANCE.unwantedSid(topid) {
//            if UserInfo.isLogin() {
//                _params["sid"] = UserInfo.sid()
//            }
//            else {
//                if target != nil {
//                    target!.networkDidFailed(topid, target!, .User_NotLogin_)
//                }
//            }
//        }
//
//        var paramsDic = [String:Any]()
//        paramsDic["topid"] = topid
//        paramsDic["extdata"] = ActionSetting.INSTANCE.getExtData(topid)
//
//        if ActionSetting.INSTANCE.needSecretAction(topid) {
//            do {
//                let paramsData = try JSONSerialization.data(withJSONObject: _params, options: JSONSerialization.WritingOptions.prettyPrinted)
//                let paramsStr = SecurityUtil.aesEncryptWithData(paramsData)
//                paramsDic["data"] = paramsStr
//            } catch {
//                if target != nil {
//                    target?.networkDidFailed(topid, target!, .Encrypt_Data_Fail)
//                }
//                return
//            }
//        }
//        else {
//            paramsDic["data"] = _params
//        }
//
//        let packedData = NetworkSetting.INSTANCE.pack(topid, paramsDic)
//
//        DispatchQueue.main.async {
//            if target != nil {
//                if self.targets[topid] == nil {
//                    self.targets[topid] = NSHashTable(options: NSPointerFunctions.Options.weakMemory)
//                }
//                let set = self.targets[topid]
//                set?.add(target as? NSObject)
//                self.targets[topid] = set
//            }
//
//            self.socket?.write(topid, packedData!)
//            if self.actionTimeout {
//                self.timoutService.add(topid, ActionSetting.INSTANCE.timeoutInterval(topid), self.timeoutHandler)
//            }
//        }
//    }
//
//    // MARK: - Heartbeat Timer
//    private func startHeartBeat() {
//        if heartBeatTimer == nil {
//            heartBeatTimer = DispatchSource.makeTimerSource(queue: .main)
//            heartBeatTimer?.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(2))
//            heartBeatTimer?.setEventHandler(handler: {
//                self.heartBeatCounter += 1
//                if self.heartBeatCounter > 4 {
//                    ActionServiceOld.request(ActionConstant.HEART_BEAT, nil, Dictionary())
//                }
//            })
//            heartBeatTimer?.resume()
//        }
//    }
//    private func stopHeartBeat() {
//        if heartBeatTimer != nil {
//            heartBeatTimer?.cancel()
//            heartBeatTimer = nil
//        }
//    }
//
//    // MARK: - SocketDelegate
//    public func socketDidConnected() {
//        logdebug("socketDidConnected")
//        DeviceInfo.INSTANCE.isNetworkOK = true
//    }
//    public func socketDidClose(_ msg: String?) {
//        DeviceInfo.INSTANCE.isNetworkOK = false
//        receiveData.removeAll()
//        if msg != nil {
//            logdebug("socket未正常关闭:\(msg ?? "")")
//            restart()
//        }
//        else {
//            logdebug("socket正常关闭")
//            close()
//        }
//    }
//    public func socketDidError(_ error: Error?) {
//        logdebug("socketDidError:\(error.debugDescription)")
//        if rebootSocket {
//            rebootSocket = false
//            restart()
//        }
//        else {
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(3), execute: {
//                self.restart()
//            })
//        }
//    }
//    public func socketDidWrite(_ topid: Int) {
////        logdebug("socketDidWrite:\(topid)")
//        self.heartBeatCounter = 0
//        let set = self.targets[topid]
//        if set != nil && (set?.count)! > 0 {
//            for tar in set!.objectEnumerator() {
//                let target = tar as! NetworkProtocol
//                target.networkDidRequestCompleted(topid, target)
//            }
//        }
//    }
//    public func socketDidRead(_ data: Data) {
//        receiveData.append(data)
//        while receiveData.count > NetworkConstant.headLength + NetworkConstant.topIdLength {
//            let head = receiveData.subdata(in: 0..<NetworkConstant.headLength)
//            let totallen = NetworkSetting.INSTANCE.getTotalLength(head)
//            if receiveData.count < totallen {
//                return
//            }
//            if totallen < 1 || totallen > 16777216 {
//                receiveData = receiveData.subdata(in: 1..<receiveData.count)
//                socketDidRead(Data())
//                continue
//            }
//
//            let topIdData = receiveData.subdata(in: NetworkConstant.headLength..<(NetworkConstant.headLength + NetworkConstant.topIdLength))
//            var topid:Int? = Int(String(data: topIdData, encoding: String.Encoding.utf8) ?? "0")
//            if topid == nil {
//                topid = 0
//            }
//            var bodyData:Data
//            if ActionSetting.INSTANCE.containAction(topid!) {
//                bodyData = receiveData.subdata(in: (NetworkConstant.headLength + NetworkConstant.topIdLength)..<totallen)
//            }
//            else {
//                bodyData = receiveData.subdata(in: NetworkConstant.headLength..<totallen)
//            }
//            receiveData = receiveData.subdata(in: totallen..<receiveData.count)
//
//            let response = NetworkSetting.INSTANCE.unpack(bodyData)
//            if response == nil {
//                return
//            }
//            if topid! < 1 {
//                topid = response?["topid"] as? Int
//            }
//            if topid == ActionConstant.HEART_BEAT {
//                logdebug("heart beat:\(response?.description ?? "")")
//                continue
//            }
//
//            if self.actionTimeout {
//                self.timoutService.remove(topid!)
//            }
//
//            DispatchQueue.main.async {
//                let set = self.targets[topid!]
//                if set != nil && (set?.count)! > 0 {
//                    for tar in set!.objectEnumerator() {
//                        let target = tar as! NetworkProtocol
//                        target.networkDidResponse(topid!, target, response!)
//                    }
//                    self.targets.removeValue(forKey: topid!)
//                }
//            }
//        }
//    }
//}

