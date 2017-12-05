//
//  BaseTVC.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

public class BaseTVC: UITableViewController, UIGestureRecognizerDelegate, VCProtocol {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.bg
        didLoad()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置代理
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        //启用系统自带的滑动手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        
        willAppear(animated)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didAppear(animated)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willDisappear(animated)
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didDisappear(animated)
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func didLoad() {}
    public func willAppear(_ animated:Bool) {}
    public func didAppear(_ animated:Bool) {}
    public func willDisappear(_ animated:Bool) {}
    public func didDisappear(_ animated:Bool) {}

    // MARK: - Table view data source

    override public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
