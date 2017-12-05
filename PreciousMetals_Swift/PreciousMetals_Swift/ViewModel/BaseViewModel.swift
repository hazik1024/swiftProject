//
//  BaseViewModel.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/7/31.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

internal class BaseViewModel: NSObject, NotificationProtocol, NetworkProtocol {
    public override init() {
        super.init()
    }
    
    /*-- NetworkProtocol --*/
//    func networkDidRequestStart(_ topid: Int, _ target: NetworkProtocol) {
//        if target as! UIViewController == self {
//            requestDidStart(topid)
//        }
//    }
//    func networkDidRequestCompleted(_ topid: Int, _ target: NetworkProtocol) {
//        if target as! UIViewController == self {
//            requestDidCompleted(topid)
//        }
//    }
//    func networkDidResponse(_ topid: Int, _ target: NetworkProtocol, _ data: Dictionary<String, Any>) {
//        if target as! UIViewController == self {
//            let cc = data["code"] as! Int
//            let code = NetworkStatus(rawValue: cc)
//            if code == .Success {
//                responseDidSuccess(topid, data)
//            }
//            else {
//                responseDidFailed(topid, cc, data)
//            }
//        }
//    }
//    func networkDidFailed(_ topid: Int, _ target: NetworkProtocol, _ code: NetworkStatus) {
//        if target as! UIViewController == self {
//            responseDidFailed(topid, code.rawValue, ["":""])
//        }
//    }
//    func networkDidError(_ topid: Int?, _ target: NetworkProtocol?, _ error: Error) {
//        if target as! UIViewController == self {
//            responseDidError(topid ?? 0, error)
//        }
//    }
    
    //MARK: NetworkProtocol
    func networkDidRequestStart(_ action: BaseAction) {
        if action.target as! BaseViewModel == self {
            requestDidStart(action)
        }
    }
    func networkDidRequestCompleted(_ action: BaseAction) {
        if action.target as! BaseViewModel == self {
            requestDidCompleted(action)
        }
    }
    func networkDidResponse(_ action: BaseAction) {
        if action.target as! BaseViewModel != self {
            logdebug("不相等:\(action.target?.description ?? "") != \(self)")
        }
        responseDidSuccess(action)
    }
    func networkDidFailed(_ action: BaseAction, _ code: NetworkStatus) {
        if action.target as! BaseViewModel == self {
            responseDidFailed(action, code)
        }
    }
    func networkDidError(_ action: BaseAction, _ error: Error) {
        if action.target as! BaseViewModel == self {
            responseDidError(action, error)
        }
    }
    
//    // MARK: 响应请求重写一下方法(1)
//    func requestDidStart(_ topid:Int){logdebug(topid)}
//    func requestDidCompleted(_ topid:Int){logdebug(topid)}
//    func responseDidSuccess(_ topid:Int, _ data:Dictionary<String, Any>){logdebug(topid, data)}
//    func responseDidFailed(_ topid:Int, _ code:Int, _ data:Dictionary<String, Any>){logdebug(topid, code, data)}
//    func responseDidError(_ topid:Int, _ error:Error){logdebug(topid, error)}
    // MARK: 响应请求重写一下方法(2)
    func requestDidStart(_ action: BaseAction){}
    func requestDidCompleted(_ action: BaseAction){}
    func responseDidSuccess(_ action: BaseAction){}
    func responseDidFailed(_ action: BaseAction, _ code: NetworkStatus){}
    func responseDidError(_ action: BaseAction, _ error: Error){}
//    func requestDidStart(_ action: BaseAction){logdebug(action.topid)}
//    func requestDidCompleted(_ action: BaseAction){logdebug(action.topid)}
//    func responseDidSuccess(_ action: BaseAction){logdebug(action.topid, action.response?.code ?? .Success)}
//    func responseDidFailed(_ action: BaseAction, _ code: NetworkStatus){logdebug(action.topid, code)}
//    func responseDidError(_ action: BaseAction, _ error: Error){logdebug(action.topid, error)}
    
     //MARK: NotificationProtocol
    public func addNotificationObserver(_ name: String, object: Any? = nil) {
//        NotificationCenter.default.addObserver(self, selector: Selector(("receiveNotification")), name: NSNotification.Name(name), object: object)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification), name: NSNotification.Name(name), object: object)
    }
    
    public func removeNotificationObserver(_ name: String, object: Any? = nil) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(name), object: object)
    }
    
    public func postNotification(_ name: String, _ userInfo: [AnyHashable : Any]? = nil, _ object: Any? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(name), object: object, userInfo:userInfo)
    }
    
    @objc public func receiveNotification(_ notify: Notification){}
}
