//
//  NetworkProtocol.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/12/4.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

//public protocol NetworkProtocol: NSObjectProtocol {
//    func networkDidRequestStart(_ topid: Int, _ target: NetworkProtocol)
//    func networkDidRequestCompleted(_ topid: Int, _ target: NetworkProtocol)
//    func networkDidResponse(_ topid: Int, _ target: NetworkProtocol, _ data:Dictionary<String, Any>)
//    func networkDidFailed(_ topid: Int, _ target: NetworkProtocol, _ code: NetworkStatus)
//    func networkDidError(_ topid: Int?, _ target: NetworkProtocol?, _ error: Error)
//}
//extension NetworkProtocol {
//    func networkDidRequestStart(_ topid: Int, _ target: NetworkProtocol){}
//    func networkDidRequestCompleted(_ topid: Int, _ target: NetworkProtocol){}
//    func networkDidResponse(_ topid: Int, _ target: NetworkProtocol, _ data:Dictionary<String, Any>){}
//    func networkDidFailed(_ topid: Int, _ target: NetworkProtocol, _ code: NetworkStatus){}
//    func networkDidError(_ topid: Int?, _ target: NetworkProtocol?, _ error: Error){}
//}

public protocol NetworkProtocol: NSObjectProtocol {
    func networkDidRequestStart(_ action: BaseAction)
    func networkDidRequestCompleted(_ action: BaseAction)
    func networkDidResponse(_ action: BaseAction)
    func networkDidFailed(_ action: BaseAction, _ code: NetworkStatus)
    func networkDidError(_ action: BaseAction, _ error: Error)
}

extension NetworkProtocol {
    func networkDidRequestStart(_ action: BaseAction){logdebug(action.topid)}
    func networkDidRequestCompleted(_ action: BaseAction){logdebug(action.topid)}
    func networkDidResponse(_ action: BaseAction){logdebug(action.topid)}
    func networkDidFailed(_ action: BaseAction, _ code: NetworkStatus){logdebug(action.topid)}
    func networkDidError(_ action: BaseAction, _ error: Error){logdebug(action.topid)}
}
