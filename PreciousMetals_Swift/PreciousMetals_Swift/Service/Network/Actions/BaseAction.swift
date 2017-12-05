//
//  BaseAction.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/12/4.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

public class BaseAction: NSObject {
    public var target: NetworkProtocol?
    
    init(_ target: NetworkProtocol?) {
        self.target = target
        super.init()
    }
    
    public var sid : String {
        return UserInfo.sid()
    }
    
    open var topid : Int {
        return ActionConstant.HEART_BEAT
    }
    
    private var _response: BaseActionResponse?
    public var response: BaseActionResponse? {
        get {
            return self._response
        }
    }
    public func setResponse(_ response:  [String:Any]?) {
        self._response = BaseActionResponse(response)
    }
    
    public func packData() -> Data? {
        //初始化data部分
        let params = packDictionary()
        if params == nil {
            return nil
        }
        let packedData = NetworkSetting.INSTANCE.pack(topid, params!)
        return packedData;
    }
    
    public func packDictionary() -> Dictionary<String, Any>? {
        //初始化data部分
        var params = Dictionary<String, Any>()
        params["topid"] = self.topid
        params["extdata"] = getExtData()
        let dataDict = getData()
        if ActionSetting.INSTANCE.needSecretAction(topid) {
            do {
                let paramsData = try JSONSerialization.data(withJSONObject: dataDict, options: JSONSerialization.WritingOptions.prettyPrinted)
                let paramsStr = SecurityUtil.aesEncryptWithData(paramsData)
                params["data"] = paramsStr
            } catch {
                return nil
            }
        }
        else {
            params["data"] = dataDict
        }
        return params;
    }
    
    private func getData() -> Dictionary<String, Any> {
        var data = Dictionary<String, Any>()
        let mirror = Mirror(reflecting: self)
        for (k, v) in mirror.children {
            if k! == "target" || k! == "response" {
                continue
            }
            data[k!] = v
        }
        return data
    }
    
    private func getExtData() -> Dictionary<String, Any> {
        return ActionSetting.INSTANCE.getExtData(self.topid)
    }
}

public class BaseActionResponse : NSObject {
    public var topid: Int = 0
    public var code: NetworkStatus = .Success
    public var data = [String: Any]()
    public var extdata = [String: Any]()
    public var msg: String = ""
    
    init(_ response: [String:Any]?) {
        super.init()
        if response != nil {
            self.code = NetworkStatus(rawValue: (response!["code"] as! Int))!
            if response!["topid"] != nil {
                self.topid = response!["topid"] as! Int
            }
            self.data = response!["data"] as! [String: Any]
            self.extdata = response!["extdata"] as! [String: Any]
            self.msg = response!["msg"] as! String
        }
    }
}
