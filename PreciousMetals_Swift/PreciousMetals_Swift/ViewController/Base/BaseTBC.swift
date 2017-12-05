//
//  BaseTBC.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class BaseTBC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        initTabbarList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTabbarList() {
        var viewControllers = [UIViewController]()
        let path = Bundle.main.path(forResource: "tabbar", ofType: "plist")
        let array:Array<Dictionary<String, AnyObject>> = NSArray(contentsOfFile: path!) as! Array
        for item in array {
            let name = item["itemName"] as! String;
            let tag = item["itemTag"]  as! Int;
            let storyboardName = item["storyboardName"] as! String;
            let rootVcName = item["rootVcName"] as! String;
            let imageName = item["itemImage"] as! String;
            let imageCheckedName = item["itemImageChecked"] as! String;
            
//            logdebug(name, tag, storyboardName, rootVcName, imageName, imageCheckedName)
            
            var vc: UIViewController
            if tag == 0 {
                vc = getVcFromStoryboard(storyboardName, rootVcName)
            }
            else {
                vc = UIViewController()
            }
            
            let image = UIImage(named: imageName)
            let selectedImage = UIImage(named: imageCheckedName)
            let tabbarItem:UITabBarItem = UITabBarItem(title: name, image: image, selectedImage: selectedImage)
            tabbarItem.tag = tag
            tabbarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:Color.makeColor(218, 171, 102)], for: UIControlState.selected)
            vc.tabBarItem = tabbarItem
            viewControllers.append(vc)
        }
        self.tabBar.tintColor = Color.makeColor(218, 171, 102)
        
        setViewControllers(viewControllers, animated: false)
    }
    
    override var selectedIndex: Int {
        get {
            return super.selectedIndex
        }
        set {
            modifySelectedIndex(newValue)
        }
    }
    
    func modifySelectedIndex(_ index: Int) -> Void {
        if index == 2 {
            
        }
        
        super.selectedIndex = index
    }
    
    /* UITabBarControllerDelegate */
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
