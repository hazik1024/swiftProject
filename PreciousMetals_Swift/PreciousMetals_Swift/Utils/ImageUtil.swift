//
//  ImageUtil.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/21.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class ImageUtil: NSObject {
    
    /// 纯色矩形
    ///
    /// - Parameters:
    ///   - size: 尺寸
    ///   - color: 填充色
    /// - Returns: UIImage
    public static func makeImage(_ size: CGSize = CGSize(width: 1.0, height: 1.0), _ color: UIColor = Color.bg) -> UIImage {
        return makeImage(size, 0, color, UIColor.black, 0)
    }
    
    /// 纯色圆角矩形
    ///
    /// - Parameters:
    ///   - size: 尺寸
    ///   - cornerRadious: 圆角尺寸
    ///   - color: 填充色
    /// - Returns: UIImage
    public static func makeImage(_ size: CGSize, _ cornerRadious: CGFloat = 4.0, _ color: UIColor = UIColor.black) -> UIImage {
        return makeImage(size, cornerRadious, color, UIColor.lightGray, 0)
    }
    
    /// 通用矩形
    ///
    /// - Parameters:
    ///   - size: 尺寸
    ///   - cornerRadious: 圆角尺寸
    ///   - color: 填充色
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽度
    /// - Returns: UIImage
    public static func makeImage(_ size: CGSize, _ cornerRadious: CGFloat = 0.0, _ color: UIColor = UIColor.black, _ borderColor: UIColor = UIColor.lightGray, _ borderWidth: CGFloat = 0.0) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width - borderWidth, height: size.height - borderWidth)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        UIGraphicsBeginImageContext(size)
        var context = UIGraphicsGetCurrentContext()
//        context?.setShouldAntialias(true)
        context?.setFillColor(color.cgColor)
        var mode = CGPathDrawingMode.fill
        if borderWidth > 0 {
            context?.setLineWidth(borderWidth)
            context?.setStrokeColor(borderColor.cgColor)
            mode = CGPathDrawingMode.fillStroke
        }
        context?.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadious))
        var tangent1 = CGPoint(x: rect.minX, y: rect.maxY)
        var tangent2 = CGPoint(x: rect.minX + cornerRadious, y: rect.maxY)
        context?.addArc(tangent1End: tangent1, tangent2End: tangent2, radius: cornerRadious)
        tangent1 = CGPoint(x: rect.maxX, y: rect.maxY)
        tangent2 = CGPoint(x: rect.maxX, y: rect.maxY - cornerRadious)
        context?.addArc(tangent1End: tangent1, tangent2End: tangent2, radius: cornerRadious)
        tangent1 = CGPoint(x: rect.maxX, y: rect.minY)
        tangent2 = CGPoint(x: rect.maxX - cornerRadious, y: rect.minY)
        context?.addArc(tangent1End: tangent1, tangent2End: tangent2, radius: cornerRadious)
        tangent1 = CGPoint(x: rect.minX, y: rect.minY)
        tangent2 = CGPoint(x: rect.minX, y: rect.minY + cornerRadious)
        context?.addArc(tangent1End: tangent1, tangent2End: tangent2, radius: cornerRadious)
        context?.closePath()
        context?.drawPath(using: mode)
        context?.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        context = nil
        
        return image!
    }
}
