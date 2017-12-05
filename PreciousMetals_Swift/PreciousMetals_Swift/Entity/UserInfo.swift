//
//  UserInfo.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/15.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation

public enum ExchangeAccountStatus: Int {
    case Default        = 100
    case TransferFail   = 150
    case TransferSuc    = 200
    case ValidFail      = 250
    case ReuploadIdCard = 280
    case Completed      = 300
}

public class UserInfo: NSObject {
    private static let INSTANCE = UserInfo()
    private override init() {
        
    }
    
    private var _isLogin = false
    private var _sid = ""
    private var _nickName = ""
    private var _mobile = ""
    private var _headPic = ""
    private var _status:ExchangeAccountStatus = .Default
    private var _accountno = ""
    private var _cantradetime = ""
    private var _cantradeflag = 0
    private var _isLocal = 1
    private var _pushId = ""
    
    private static func loadInfo(_ info: [String:Any]) {
        if info["sid"] != nil {
            INSTANCE._sid = info["sid"] as! String
            INSTANCE._isLogin = true
        }
        if info["nickname"] != nil {
            INSTANCE._nickName = info["nickname"] as! String
        }
        if info["mobile"] != nil {
            INSTANCE._mobile = info["mobile"] as! String
        }
        if info["headpic"] != nil {
            INSTANCE._headPic = info["headpic"] as! String
        }
        if info["status"] != nil {
            INSTANCE._status = info["status"] as! ExchangeAccountStatus
        }
        if info["accountno"] != nil {
            INSTANCE._accountno = info["accountno"] as! String
        }
        if info["islocal"] != nil {
            INSTANCE._isLocal = info["islocal"] as! Int
        }
        if info["cantradetime"] != nil {
            INSTANCE._cantradetime = info["cantradetime"] as! String
        }
        if info["cantradeflag"] != nil {
            INSTANCE._cantradeflag = info["cantradeflag"] as! Int
        }
        if info["pushid"] != nil {
            INSTANCE._pushId = info["pushid"] as! String
        }
    }
    
    public static func loadInfo() {
        let info = LocalCacheUtil.getUserInfo()
        loadInfo(info!)
    }
    
    public static func saveInfo(_ info: [String:Any]) {
        LocalCacheUtil.saveUserInfo(info)
        loadInfo(info)
    }
    
    public static func sid() -> String {
        return INSTANCE._sid
    }
    
    public static func nickName() -> String {
        return INSTANCE._nickName
    }
    
    public static func isLogin() -> Bool {
        return INSTANCE._isLogin
    }
}
