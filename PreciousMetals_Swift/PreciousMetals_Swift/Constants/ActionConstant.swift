//
//  ActionDefine.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/15.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation

public struct ActionConstant {
    //心跳
    public static let HEART_BEAT                    = 100000
    //500账户登录
    public static let LOGIN                         = 100101
    //500账户登出
    public static let LOGOUT                        = 100102
    //500账户登录状态检查
    public static let CHECK_LOGIN_STATUS            = 100103
    //交易所登录状态检查
    public static let CHECK_EXCHANGE_LOGIN_STATUS   = 100106
    //联合登录地址获取
    public static let UNION_LOGIN_URL               = 100107
    //联合登录回调
    public static let UNION_LOGIN_BACKCALL          = 100108
    //版本控制
    public static let LOCAL_MACHINE_INFO            = 100240
    //重置用户密码-发送短信
    public static let RESETUSERPWD_SENDCODE         = 100207
    //重置用户密码-验证短信
    public static let RESETUSERPWD_CHECKCODE  = 100208
    //重置用户密码-提交密码
    public static let RESETUSERPWD_SUBMIT     = 100209
    /*----500账户注册----*/
    //检查用户名
    public static let CHECK_USER_NAME      = 100201
    //发送验证码
    public static let SEND_MOBILE_CODE     = 100202
    //检测验证码
    public static let CHECK_MOBILE_CODE    = 100203
    //提交登录密码
    public static let COMMIT_PASSWORD      = 100206
    //上传500金用户头像
    public static let UPLOAD_500GOLD_HEAD  = 100246
    
    /*----交易所-开户----*/
    //上传基本信息
    public static let OA_UPLOAD_INFO       = 100220
    //上传身份证照片
    public static let OA_UPLOAD_IDCARDIMAGE = 100221
    //重新上传身份证照片
    public static let OA_REUPLOAD_IDCARD   = 100222
    //发送短信验证码
    public static let OA_SEND_MOBILE_CODE  = 100230
    //校验短信验证码
    public static let OA_CHECK_MOBILE_CODE = 100231
    //提交交易密码和资金密码
    public static let OA_SUBMIT_PASSWORD   = 100232
    //检查交易所账户状态
    public static let OA_ACCOUNT_STATUS    = 100233
    //获取身份证信息
    public static let OA_ACCOUNT_FOUND_ID  = 100234
    //修改交易密码
    public static let TRADE_PSW_CHANGE     = 100235
    //修改资金密码
    public static let ACOUNT_PSW_CHANGE    = 100236
    //绑定交易所账号
    public static let BIND_TRADEACOUNT     = 100237
    //录入身份信息并上传身份证
    public static let UPLOAD_IDCARD_AND_INFO = 100247
    
    /*----交易所-交易----*/
    //交易所账户登录
    public static let TRADE_LOGIN			 = 100300
    //委托单下单
    public static let TRADE_ENTRUST_ORDER	 = 100301
    //委托单取消
    public static let TRADE_ENTRUST_CANCEL	 = 100302
    //资金查询
    public static let TRADE_FUND			 = 100303
    //转账-出入金
    public static let TRADE_TRANSFER		 = 100304
    //转账查询
    public static let TRADE_QUERY_TRANSFER	 = 100305
    //持仓单查询
    public static let TRADE_QUERY_POSITON	 = 100306
    //最大可买手数查询
    public static let TRADE_QUERY_MAX_HANDS	 = 100307
    //委托单/成交单查询
    public static let TRADE_QUERY_ORDER      = 100308
    //交易费用
    public static let TRADE_CHARGE_LIST      = 100600
    
    /*----行情----*/
    //行情列表
    public static let QUOTATION_LIST         = 100400
    //行情详情
    public static let QUOTATION_DETAIL       = 100401
    //分时图数据
    public static let QUOTATION_TIME         = 100402
    //K线图数据
    public static let QUOTATION_KLINE        = 100403
    
    /*----资讯------*/
    //资讯站点配置
    public static let INFO_WEBSITE_LIST      = 100504
    //开户支持银行列表
    public static let TRADE_BANK_LIST        = 100505
    //新闻列表查询
    //public static let INFO_NEWS_LIST         = 100506
    //新闻详情查询
    //public static let INFO_NEWS_DETAIL       = 100507
    //广告位查询
    public static let INFO_ADVERT_LIST       = 100508
    //意见反馈
    public static let INFO_SUGGEST           = 100509
    //公告列表(首页)
    public static let INFO_NOTICE_NEWS       = 100510
    //策略列表(资讯页)
    public static let INFO_STRATEGY          = 100512
    //快讯列表(资讯页)
    public static let INFO_NEWS              = 100514
    //日历列表(资讯页)
    public static let INFO_CALENDAR          = 100516
    //要闻列表(资讯页)
    public static let INFO_IMPORTANT         = 100517
    //首页全屏弹窗广告
    public static let BOOT_ALERT             = 100519
    
    /*--------*/
    //交易时间查询
    public static let TRADE_TIME_CHECK       = 500101
    public static let GLOBAL_SWITCH_LIST            = 500104
    public static let GLOBAL_SYSTEM_SWITCH          = 500110
    
    /*----我的------*/
    //修改昵称
    public static let MODIFY_NICKNAME        = 100242
    //修改密码
    public static let MODIFY_PASSWORD        = 100243
    //绑定手机-发送短信验证码
    public static let BIND_MOBILE_SEND       = 100244
    //绑定手机-验证短信验证码并提交密码
    public static let BIND_MOBILE_SUBMIT     = 100245
    
    /*-----推送系统------*/
    //推送开关列表
    public static let PUSH_SWITCH_LIST       = 420001
    //推送开关设置
    public static let PUSH_SET               = 420002
    //消息列表
    public static let PRIVATE_NEWS_DETAIL    = 420006
    //大类最新消息
    public static let PRIVATE_NEWS           = 420008
    //app上送设备注册信息
    public static let UPLOAD_DEVICE_USERINFO = 420010
    /*--------*/
    
    /////////////////////////////////////////////////////
    /////////////////////////////////////////////////////
    /*----联合登录----*/
    //联合登录
    public static let UNION_LOGIN            = 100105
    /*----文字直播----*/
    
//    public static let NOTIFY_STUDIO_KEY             = notifyStudioKey
//    public static let NOTIFY_STUDIO_DEL_MSG         = notifyStudioDelMsg
    //房间列表
    public static let ROOM_LIST              = 18501
    //进入房间
    public static let ENTER_ROOM             = 18503
    //在线人数
    public static let ONLINE_LIST            = 18505
    //分析师列表
    public static let ANALYSER_LIST          = 18507
    //发送消息
    public static let SEND_CHART_INFO        = 18509
    //禁用列表
    public static let FORBIDDEN              = 18511
    //
    public static let QUESTION_TO_ME         = 18513
    //我的回答
    public static let MY_ANSWER              = 18515
    //房间信息
    public static let ROOM_INFO              = 18517
    //管理房间
    public static let OPER_ROOM              = 18519
    //离开房间
    public static let LEAVE_ROOM             = 18521
    //历史消息
    public static let HISTORY_INFO           = 18523
    
    /*----大V系统----*/
    //牛人排行榜查询接口
    public static let VIP_GENIUS_LIST        = 204001
    //大V做单分时列表查询接口
    public static let VIP_CHART_LIST         = 204002
    //大V下单小白跟单最新动态查询接口
    public static let VIP_FOLLOW_DYNAMIC     = 204003
    //用户关注接口
    public static let VIP_ATTENTION          = 204004
    //用户取消关注接口
    public static let VIP_CANCEL_ATTENTION   = 204005
    //大V交易动态查询接口
    public static let VIP_TRADE_DYNAMIC      = 204006
    //牛人信息查询接口
    public static let VIP_PERSON_HOME        = 204007
    
    //直播推送心跳
    public static let STUDIO_HEART_BEAT     = 1000
    //直播推送消息
    public static let STUDIO_PUSH_MSG = 1001
    //直播推送鉴权
    public static let STUDIO_AUTH = 1002
    //断开连接
    public static let STUDIO_CLOSE_CONN = 1003
    //网络响应错误
    public static let STUDIO_NETWORK_ERROR = 1004
    //服务端删除消息
    public static let STUDIO_DELETE_MSG = 1005
    
    
    
    /////////////////////////////////////////////////////
    /////////////////////////////////////////////////////
    /*-------IDFA接口-------*/
    public static let IDFA_ACTIVATION        = 100703
}
