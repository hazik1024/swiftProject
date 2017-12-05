//
//  ActionSetting.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/12/4.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class ActionSetting : NSObject {
    public static let INSTANCE = ActionSetting()
    private var actions:Set<Int> = Set<Int>()
    private override init() {
        super.init()
        
        addActions()
    }
    
    private func addActions() {
        actions.insert(ActionConstant.HEART_BEAT)
        
        actions.insert(ActionConstant.LOGIN)
        actions.insert(ActionConstant.LOGOUT)
        actions.insert(ActionConstant.CHECK_LOGIN_STATUS)
        actions.insert(ActionConstant.CHECK_EXCHANGE_LOGIN_STATUS)
        actions.insert(ActionConstant.UNION_LOGIN_URL)
        actions.insert(ActionConstant.UNION_LOGIN_BACKCALL)
        actions.insert(ActionConstant.LOCAL_MACHINE_INFO)
        actions.insert(ActionConstant.RESETUSERPWD_SENDCODE)
        actions.insert(ActionConstant.RESETUSERPWD_CHECKCODE)
        actions.insert(ActionConstant.RESETUSERPWD_SUBMIT)
        
        actions.insert(ActionConstant.CHECK_USER_NAME)
        actions.insert(ActionConstant.SEND_MOBILE_CODE)
        actions.insert(ActionConstant.CHECK_MOBILE_CODE)
        actions.insert(ActionConstant.COMMIT_PASSWORD)
        actions.insert(ActionConstant.UPLOAD_500GOLD_HEAD)
        
        actions.insert(ActionConstant.OA_UPLOAD_INFO)
        actions.insert(ActionConstant.OA_UPLOAD_IDCARDIMAGE)
        actions.insert(ActionConstant.OA_REUPLOAD_IDCARD)
        actions.insert(ActionConstant.OA_SEND_MOBILE_CODE)
        actions.insert(ActionConstant.OA_CHECK_MOBILE_CODE)
        actions.insert(ActionConstant.OA_SUBMIT_PASSWORD)
        actions.insert(ActionConstant.OA_ACCOUNT_STATUS)
        actions.insert(ActionConstant.OA_ACCOUNT_FOUND_ID)
        actions.insert(ActionConstant.TRADE_PSW_CHANGE)
        actions.insert(ActionConstant.ACOUNT_PSW_CHANGE)
        actions.insert(ActionConstant.BIND_TRADEACOUNT)
        actions.insert(ActionConstant.UPLOAD_IDCARD_AND_INFO)
        
        actions.insert(ActionConstant.TRADE_LOGIN)
        actions.insert(ActionConstant.TRADE_ENTRUST_ORDER)
        actions.insert(ActionConstant.TRADE_ENTRUST_CANCEL)
        actions.insert(ActionConstant.TRADE_FUND)
        actions.insert(ActionConstant.TRADE_TRANSFER)
        actions.insert(ActionConstant.TRADE_QUERY_TRANSFER)
        actions.insert(ActionConstant.TRADE_QUERY_POSITON)
        actions.insert(ActionConstant.TRADE_QUERY_MAX_HANDS)
        actions.insert(ActionConstant.TRADE_QUERY_ORDER)
        actions.insert(ActionConstant.TRADE_CHARGE_LIST)
        actions.insert(ActionConstant.QUOTATION_LIST)
        actions.insert(ActionConstant.QUOTATION_DETAIL)
        actions.insert(ActionConstant.QUOTATION_TIME)
        actions.insert(ActionConstant.QUOTATION_KLINE)
        
        actions.insert(ActionConstant.INFO_WEBSITE_LIST)
        actions.insert(ActionConstant.TRADE_BANK_LIST)
        actions.insert(ActionConstant.INFO_ADVERT_LIST)
        actions.insert(ActionConstant.INFO_SUGGEST)
        actions.insert(ActionConstant.INFO_NOTICE_NEWS)
        actions.insert(ActionConstant.INFO_STRATEGY)
        actions.insert(ActionConstant.INFO_NEWS)
        actions.insert(ActionConstant.INFO_CALENDAR)
        actions.insert(ActionConstant.INFO_IMPORTANT)
        
        actions.insert(ActionConstant.TRADE_TIME_CHECK)
        actions.insert(ActionConstant.GLOBAL_SWITCH_LIST)
        
        actions.insert(ActionConstant.PUSH_SWITCH_LIST)
        actions.insert(ActionConstant.PUSH_SET)
        actions.insert(ActionConstant.PRIVATE_NEWS)
        actions.insert(ActionConstant.PRIVATE_NEWS_DETAIL)
        actions.insert(ActionConstant.MODIFY_NICKNAME)
        actions.insert(ActionConstant.MODIFY_PASSWORD)
        actions.insert(ActionConstant.BIND_MOBILE_SEND)
        actions.insert(ActionConstant.BIND_MOBILE_SUBMIT)
        
        actions.insert(ActionConstant.UNION_LOGIN)
        
        actions.insert(ActionConstant.ROOM_LIST)
        actions.insert(ActionConstant.ENTER_ROOM)
        actions.insert(ActionConstant.ONLINE_LIST)
        actions.insert(ActionConstant.ANALYSER_LIST)
        actions.insert(ActionConstant.SEND_CHART_INFO)
        actions.insert(ActionConstant.FORBIDDEN)
        actions.insert(ActionConstant.QUESTION_TO_ME)
        actions.insert(ActionConstant.MY_ANSWER)
        actions.insert(ActionConstant.ROOM_INFO)
        actions.insert(ActionConstant.OPER_ROOM)
        actions.insert(ActionConstant.LEAVE_ROOM)
        actions.insert(ActionConstant.HISTORY_INFO)
        
        actions.insert(ActionConstant.VIP_GENIUS_LIST)
        actions.insert(ActionConstant.VIP_CHART_LIST)
        actions.insert(ActionConstant.VIP_FOLLOW_DYNAMIC)
        actions.insert(ActionConstant.VIP_ATTENTION)
        actions.insert(ActionConstant.VIP_CANCEL_ATTENTION)
        actions.insert(ActionConstant.VIP_TRADE_DYNAMIC)
        actions.insert(ActionConstant.VIP_PERSON_HOME)
        
        actions.insert(ActionConstant.IDFA_ACTIVATION)
        actions.insert(ActionConstant.GLOBAL_SYSTEM_SWITCH)
        
        actions.insert(ActionConstant.UPLOAD_DEVICE_USERINFO)
        actions.insert(ActionConstant.PRIVATE_NEWS)
    }
    
    public func containAction(_ topid:Int) -> Bool {
        if actions.contains(topid) {
            return true
        }
        return false
    }
    
    /*** Settings ***/
    public func timeoutInterval(_ topid: Int) -> Int {
        return 5
    }
    public func unwantedSid(_ topid: Int) -> Bool {
        switch topid {
        case ActionConstant.HEART_BEAT:
            return true
        case ActionConstant.LOGIN:
            return true
        default:
            return false
        }
    }
    
    public func needSecretAction(_ topid: Int) -> Bool {
        var need = false
        switch topid {
        case ActionConstant.LOGIN:
            need = true
            break
        default:
            break
        }
        return need
    }
    
    public func getExtData(_ topid: Int) -> [String: Any] {
        var extData = [String: Any]()
        extData["termtype"] = DeviceInfo.INSTANCE.termType
        extData["appversion"] = DeviceInfo.INSTANCE.appVersion
        extData["sourcetype"] = DeviceInfo.INSTANCE.sourceType
        
        return extData
    }
    
    public func useNewDataFormats(_ topid: Int) -> Bool {
        var use = false
        switch topid {
        case ActionConstant.PRIVATE_NEWS:
            use = true
            break
        default:
            break
        }
        return use
    }

}
