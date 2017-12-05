//
//  HomeVC.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/19.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class HomeVC: BaseTVC {
    let cellId = "cellId"
    var vm:HomeViewModel?
    public override func didLoad() {
        setNavigationItemTitle("首页")
        vm = HomeViewModel(self)
        
//        vm?.doTest()
//        vm?.getImage("http://g.hiphotos.baidu.com/image/pic/item/3801213fb80e7bec9276987d242eb9389a506bfa.jpg", { (image: UIImage?) in
//            if image != nil {
//                logdebug(image?.size.width, image?.size.height)
//            }
//        })
        let iv = UIImageView(frame: CGRect(x: 0, y: 100, width: 300, height: 200))
        
        iv.loadImage("http://g.hiphotos.baidu.com/image/pic/item/3801213fb80e7bec9276987d242eb9389a506bfa.jpg")
        self.view.addSubview(iv)
    }
    
    public override func didAppear(_ animated: Bool) {
        vm?.queryQuotationList()
    }
    
    // MARK: - UITableViewDelegate和UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        }
        return cell!
    }
    
}
