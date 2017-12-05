//
//  BaseVC.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class BaseVC: UIViewController, UIGestureRecognizerDelegate, VCProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.bg
        if self.navigationController != nil {
            if (self.navigationController?.isToolbarHidden)! {
                self.navigationController?.setToolbarHidden(false, animated: true)
            }
            //设置自定义返回button
            
        }
        didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置代理
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        //启用系统自带的滑动手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        willAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didDisappear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    public func didLoad() {}
    public func willAppear(_ animated:Bool) {}
    public func didAppear(_ animated:Bool) {}
    public func willDisappear(_ animated:Bool) {}
    public func didDisappear(_ animated:Bool) {}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
