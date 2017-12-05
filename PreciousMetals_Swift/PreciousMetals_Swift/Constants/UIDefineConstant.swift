//
//  UIDefineConstant.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/21.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit
/// 全局字体大小定义
struct Font {
    static let f8 = UIFont.systemFont(ofSize: 8)
    static let f9 = UIFont.systemFont(ofSize: 9)
    static let f10 = UIFont.systemFont(ofSize: 10)
    static let f11 = UIFont.systemFont(ofSize: 11)
    static let f12 = UIFont.systemFont(ofSize: 12)
    static let f13 = UIFont.systemFont(ofSize: 13)
    static let f14 = UIFont.systemFont(ofSize: 14)
    static let f15 = UIFont.systemFont(ofSize: 15)
    static let f16 = UIFont.systemFont(ofSize: 16)
    static let f17 = UIFont.systemFont(ofSize: 17)
    static let f18 = UIFont.systemFont(ofSize: 18)
    static let f19 = UIFont.systemFont(ofSize: 19)
    static let f20 = UIFont.systemFont(ofSize: 20)
}

/// 全局颜色定义
struct Color {
    public static let c0 = UIColor.black
    public static let c1 = UIColor.white
    public static let up = UIColor.red
    public static let down = UIColor.green
    public static let bg = makeColor(238.0, 238.0, 238.0)
    public static let navigationBarBg = makeColor(35.0, 35.0, 35.0)
    
    static func makeColor(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat, _ alpha:CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha);
    }
}
