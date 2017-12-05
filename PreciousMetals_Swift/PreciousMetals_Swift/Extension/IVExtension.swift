//
//  ImageExtension.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/22.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

extension UIImageView {
    public func loadImage(_ url: String) {
        loadImage(url, nil)
    }
    public func loadImage(_ url: String, _ placeholder: String?) {
        var image = LocalCacheUtil.getImage(url)
        if image != nil {
            self.image = image
            return
        }
        if placeholder != nil && (placeholder?.lengthOfBytes(using: String.Encoding.utf8))! > 0 {
            self.image = UIImage(named: placeholder!)
        }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: URL(string: url)!)
                image = UIImage(data: data)
                if image != nil {
                    DispatchQueue.main.sync {
                        self.image = UIImage(data: data)
                    }
                    LocalCacheUtil.saveImage(url, image!)
                }
            }
            catch {
                
            }
        }
    }
}
