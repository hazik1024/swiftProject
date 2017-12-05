//
//  ImageCacheUtil.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/22.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

enum CacheKey: String {
    case userInfo = "key_userinfo"  //存储用户信息
}

public class LocalCacheUtil: NSObject {
    // MARK: - 用户信息缓存
    public static func getUserInfo() -> [String: Any]? {
        return UserDefault.object(forKey: CacheKey.userInfo.rawValue) as? [String: Any]
    }
    public static func saveUserInfo(_ info:[String: Any]) {
        UserDefault.set(info, forKey: CacheKey.userInfo.rawValue)
    }
    
    // MARK: - 图片缓存
    public static func getImage(_ name: String) -> UIImage? {
        return ImageCacheUtil.getImage(name)
    }
    
    public static func saveImage(_ name:String, _ image:UIImage, _ tmpCache:Bool = false) {
        ImageCacheUtil.saveImage(name, image, tmpCache)
    }
    
    public static func deleteImage(_ name:String) {
        ImageCacheUtil.deleteImage(name)
    }
    
    // MARK: - 字典缓存
    public static func getDictionary(_ name: String) -> Dictionary<String, Any>? {
        return DictionaryCacheUtil.getDictionary(name)
    }
    
    public static func saveDictionary(_ name: String, _ dictionary: Dictionary<String, Any>) {
        DictionaryCacheUtil.saveDictionary(name, dictionary)
    }
    
    public static func deleteDictionary(_ name:String) {
        DictionaryCacheUtil.deleteDictionary(name)
    }
}

public class ImageCacheUtil: NSObject {
//    private static var imageDict = Dictionary<String, UIImage>()
    private static var imageDict = NSCache<NSString, UIImage>()
    public static func getImage(_ name: String) -> UIImage? {
        let md5Name = SecurityUtil.md5(name)
        var image = imageDict.object(forKey: md5Name as NSString)
        if image == nil {
            image = FileUtil.findImage(md5Name)
            imageDict.setObject(image!, forKey: md5Name as NSString)
        }
        return image
    }
    
    public static func saveImage(_ name:String, _ image:UIImage, _ tmpCache:Bool = false) {
        let md5Name = SecurityUtil.md5(name)
        imageDict.setObject(image, forKey: md5Name as NSString)
        if !tmpCache {
            FileUtil.saveImage(image, md5Name)
        }
    }
    
    public static func deleteImage(_ name:String) {
        let md5Name = SecurityUtil.md5(name)
        imageDict.removeObject(forKey: md5Name as NSString)
        FileUtil.delete(md5Name, .image)
    }
}

public class DictionaryCacheUtil: NSObject {
    public static func getDictionary(_ name: String) -> Dictionary<String, Any>? {
        return FileUtil.findDictionary(name)
    }
    
    public static func saveDictionary(_ name: String, _ dictionary: Dictionary<String, Any>) {
        FileUtil.saveDictionary(dictionary, name)
    }
    
    public static func deleteDictionary(_ name:String) {
        FileUtil.delete(name, .dictionary)
    }
}
