//
//  SecurityUtil.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class SecurityUtil: NSObject {

    public static func aesEncrypt(_ string: String) -> String {
        return AESEncrypt.encrypt(string)
    }
    
    public static func aesEncryptWithData(_ data: Data) ->String {
        return AESEncrypt.encrypt(with: data)
    }
    
    public static func encryptToData(_ string: String) -> Data {
        return AESEncrypt.encrypt(toData: string)
    }
    
    public static func aesDecrypt(_ string: String) -> String {
        return AESEncrypt.decrypt(string)
    }
    
    public static func decryptToData(_ string: String) -> Data {
        return AESEncrypt.decrypt(toData: string)
    }
    
    public static func md5(_ string: String) -> String {
        return AESEncrypt.md5(string)
    }
}
