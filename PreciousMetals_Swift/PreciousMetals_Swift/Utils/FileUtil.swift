//
//  FileUtil.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/7/11.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class FileUtil: NSObject {
    private static let docPath = NSHomeDirectory() + "/Documents/"
    public enum FileType: String {
        case image = "image"
        case dictionary = "dictionary"
        case array = "array"
        case txt = "txt"
        case other = "other"
    }
    
    public static func createDirectory(_ directory: String, _ type: FileType = .image) -> Bool {
        do {
            try FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            logdebug(error)
            return false
        }
        return true
    }
    
    public static func isFileExist(_ name: String, _ type: FileType = .image) -> Bool {
        let path = FileUtil.docPath + type.rawValue + "/" + name
        return FileManager.default.fileExists(atPath: path)
    }
    
    public static func isDirectoryExist(_ directory: String, _ type: FileType = .image) -> Bool {
        var isDirectory: ObjCBool = true
        return FileManager.default.fileExists(atPath: directory, isDirectory: &isDirectory)
    }
    
    @discardableResult
    public static func saveImage(_ image:UIImage, _ name: String, _ type: FileType = .image) -> Bool {
        let directory = FileUtil.docPath + type.rawValue
        if !isDirectoryExist(directory) {
            logdebug("image not exist")
            if !createDirectory(directory) {
                logdebug("image not create")
                return false
            }
        }
        do {
            let path = directory + "/" + name
            let imgData = UIImagePNGRepresentation(image)
            try imgData?.write(to: URL(fileURLWithPath: path))
        } catch {
            logdebug(error)
            return false
        }
        return true
    }
    
    @discardableResult
    public static func saveText(_ text:String, _ type: FileType = .txt) -> Bool {
        return true
    }
    
    @discardableResult
    public static func saveArray(_ array:Array<Any>, _ type: FileType = .array) -> Bool {
        return true
    }
    
    @discardableResult
    public static func saveDictionary(_ dict:Dictionary<String, Any>, _ name: String, _ type: FileType = .dictionary) -> Bool {
        let directory = FileUtil.docPath + type.rawValue
        if !isDirectoryExist(directory) {
            logdebug("directory not exist")
            if !createDirectory(directory) {
                logdebug("directory not create")
                return false
            }
        }
        let path = directory + "/" + name + ".plist"
        let dic = dict as NSDictionary
        if dic.write(toFile: path, atomically: true) {
            return true
        }
        return false
    }
    
    @discardableResult
    public static func delete(_ name: String, _ type:FileType = .image) -> Bool {
        var path = FileUtil.docPath + type.rawValue + "/" + name
        if type == .dictionary || type == .array {
            path = path + ".plist"
        }
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            logdebug(error)
            return false
        }
        return true
    }
    
    @discardableResult
    public static func delete(_ type:FileType) -> Bool {
        let path = FileUtil.docPath + type.rawValue
        let fileArray = FileManager.default.subpaths(atPath: path)
        for fn in fileArray!{
            try! FileManager.default.removeItem(atPath: path + "/\(fn)")
        }
        return true
    }
    
    @discardableResult
    public static func deleteAll() -> Bool {
        let path = FileUtil.docPath
        let fileArray = FileManager.default.subpaths(atPath: path)
        for fn in fileArray!{
            try! FileManager.default.removeItem(atPath: path + "/\(fn)")
        }
        return true
    }
    
    public static func findImage(_ name: String, _ type:FileType = .image) -> UIImage? {
        let path = FileUtil.docPath + type.rawValue + "/" + name
        if !FileManager.default.fileExists(atPath: path) {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    public static func findDictionary(_ name: String, _ type: FileType = .dictionary) -> Dictionary<String, Any>? {
        let path = FileUtil.docPath + type.rawValue + "/" + name + ".plist"
        if !FileManager.default.fileExists(atPath: path) {
            return nil
        }
        return NSDictionary(contentsOfFile: path) as? Dictionary<String, Any>
    }
}
