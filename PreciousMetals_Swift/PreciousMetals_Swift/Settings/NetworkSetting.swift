//
//  NetworkSetting.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/12/4.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class NetworkSetting: NSObject {
    public static let INSTANCE = NetworkSetting()
    private override init() {
        super.init()
    }
    public func pack(_ topid:Int, _ params: Dictionary<String, Any>) -> Data? {
        var packData:Data
        do {
            var data:Data?
            try data = JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            let dataLen = (data?.count)!
            if ActionSetting.INSTANCE.useNewDataFormats(topid) {
                var len:UInt32 = UInt32(NetworkConstant.headLength + NetworkConstant.topIdLength + dataLen).bigEndian
                let lenData:NSData = NSData(bytes: &len, length: NetworkConstant.headLength)
                packData = Data.init(bytes: lenData.bytes, count: NetworkConstant.headLength)
                let topIdData:Data = String(topid).data(using: String.Encoding.utf8)!
                packData.append(topIdData)
                packData.append(data!)
            }
            else {
                var len:UInt32 = UInt32(NetworkConstant.headLength + dataLen).bigEndian
                let lenData:NSData = NSData(bytes: &len, length: NetworkConstant.headLength)
                packData = Data.init(bytes: lenData.bytes, count: NetworkConstant.headLength)
                packData.append(data!)
            }
        } catch {
            return nil
        }
        return packData
    }
    
    public func unpack(_ data:Data) -> Dictionary<String, Any>? {
        var dict:Dictionary<String, Any>?
        do {
            try dict = JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
        }
        catch {
            dict = nil
        }
        return dict
    }
    
    public func getTotalLength(_ head:Data) -> Int {
        var len:Int = 0
        head.withUnsafeBytes { (pointer:UnsafePointer<UInt32>) -> Void in
            len = Int(pointer.pointee.bigEndian)
        }
        return len
    }

}
