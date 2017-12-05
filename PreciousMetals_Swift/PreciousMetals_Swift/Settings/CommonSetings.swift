//
//  CommonSetings.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation

/// 日志打印
///
/// - Parameters:
///   - items: 日志内容
///   - file: 文件名称
///   - function: 函数名
///   - line: 行数
public func logdebug(_ items:Any..., file: String = #file, _ function: String = #function, _ line: Int = #line) -> Void {
    #if DEBUG
        let list = file.components(separatedBy: "/")
        let fileName = list[list.count - 1]//.components(separatedBy: ".")[0]
        print("\(fileName) \(function) \(line) -> \(items)")
    #endif
}
