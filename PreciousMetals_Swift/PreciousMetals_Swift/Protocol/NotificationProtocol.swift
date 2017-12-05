//
//  NotificationProtocol.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/8/1.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

public protocol NotificationProtocol: NSObjectProtocol {
    func addNotificationObserver(_ name: String, object: Any?)
    func removeNotificationObserver(_ name: String, object: Any?)
    func postNotification(_ name: String, _ userInfo: [AnyHashable : Any]?, _ object: Any?)
    func receiveNotification(_ notify: Notification)
}

//extension NotificationProtocol {
//    func addNotificationObserver(_ name: String, object: Any?){}
//    func removeNotificationObserver(_ name: String, object: Any?){}
//    func postNotification(_ name: String, _ object: Any?, _ userInfo: [AnyHashable : Any]?){}
//    func receiveNotification(_ notify: Notification){}
//}
