//
//  BaseNC.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class BaseNC: UINavigationController {

    private let bgImage = ImageUtil.makeImage(CGSize(width: 1, height: 1), Color.navigationBarBg)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(bgImage, for: UIBarPosition.topAttached, barMetrics: UIBarMetrics.default)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        get {
            return self.topViewController
        }
    }
    
    override var childViewControllerForStatusBarHidden: UIViewController? {
        get {
            return self.topViewController
        }
    }
}
