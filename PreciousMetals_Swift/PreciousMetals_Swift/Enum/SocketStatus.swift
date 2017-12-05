//
//  SocketStatus.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/12/4.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation

public enum SocketStatus : UInt {
    case Disconnect = 0,
         Connecting = 1,
         Connected  = 2
}

extension SocketStatus {
    var description: String {
        get {
            switch self {
            case .Disconnect:
                return "未连接"
            case .Connecting:
                return "连接中"
            case .Connected:
                return "已连接"
            }
        }
    }
}
