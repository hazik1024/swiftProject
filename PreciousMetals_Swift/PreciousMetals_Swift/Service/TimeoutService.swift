//
//  TimeoutService.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/26.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class TimeoutService: NSObject {
    private var timers: Dictionary<String, DispatchSourceTimer> = [String: DispatchSourceTimer]()
    
    func add(_ key: Int, _ interval: Int, _ completedHandler:@escaping (_ key: Int) -> Void) -> Void {
        var timer = timers[String(key)]
        if timer != nil {
            timer?.cancel()
        }
        else {
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            timer?.schedule(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(interval))
            timer?.setEventHandler(handler: {
                completedHandler(key)
            })
        }
        timer?.resume()
    }
    
    func remove(_ key: Int) -> Void {
        let keyStr = String(key)
        let timer = timers[keyStr]
        if timer != nil {
            timer?.cancel()
        }
        timers.removeValue(forKey: keyStr)
    }
    
    func removeAll() {
        for (_, timer) in timers {
            timer.cancel()
        }
        timers.removeAll()
    }
}
