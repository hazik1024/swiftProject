//
//  CommonUtil.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/30.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class CommonUtil: NSObject {
    public static func executeInMainQueue<T>(_ block: () -> T) -> T {
        var check: T? = nil
        if Thread.current.isMainThread {
            check = block()
        }
        else {
            check = executeInQueue(DispatchQueue.main, block)
        }
        return check!
    }
    
    public static func executeInQueue<T>(_ queue:DispatchQueue, _ block: () -> T) -> T {
        var check: T? = nil
        DispatchQueue.main.sync {
            check = block()
        }
        return check!
    }
}
