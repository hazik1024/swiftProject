//
//  VIewControllerExtension.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit
// MARK: 扩展UIViewController - 补充方法
extension UIViewController {
    // MARK: 从storyboard获取ViewController
    func getVcFromStoryboard(_ sbName: String, _ vcId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: sbName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: vcId)
    }
    
    // MARK: 设置NavigationItem的title
    func setNavigationItemTitle(_ title: String) {
        setNavigationItemTitle(title, Color.c1)
    }
    func setNavigationItemTitle(_ title: String, _ color: UIColor) -> Void {
        var attr = self.navigationController?.navigationBar.titleTextAttributes
        if attr == nil || (attr?.count)! < 1 {
            attr = [NSAttributedStringKey:Any]()
            attr![NSAttributedStringKey.font] = Font.f18
        }
        attr![NSAttributedStringKey.foregroundColor] = color
        self.navigationController?.navigationBar.titleTextAttributes = attr
        
        self.navigationItem.title = title;
    }
}
