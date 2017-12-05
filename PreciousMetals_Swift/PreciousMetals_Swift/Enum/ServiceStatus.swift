//
//  ServiceCode.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/15.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation

public enum NetworkStatus: Int {
    case Request_Error               = -1,   //服务异常
    Request_Timeout                  = -2,   //请求服务端超时
    Request_Log_Other_Error          = -8,   //其他需打印错误
    Db_Error                         = -100, //DB错误
    Cache_Error                      = -200, //Memcached错误
    Seq_Error                        = -300, //序列号服务错误
    Param_Error                      = -400, //请求参数错误
    Server_Error                     = -500, //服务未知错误
    BankServer_Error                 = -501, //银行网关请求失败
    MobileServer_Error               = -502, //短信网关请求失败
    EmailServer_Error                = -503, //邮件网关请求失败
    GAServer_Error                   = -504, //公安网关请求失败
    ConnectServer_Fail               = -600, //连接服务器失败...
    SendData_Data_Error              = -601, //请求参数为空
    SetSendTimeout_Fail              = -602, //设置发送超时失败
    SendData_Fail                    = -603, //发送数据失败
    SetReadTimeout_Fail              = -604, //设置读取超时失败
    ReadHeadData_Fail                = -605, //读取头部数据失败
    ReadHeadOtherData_Fail           = -606, //读取头部剩余数据失败
    AnalysisHeadData_Fail            = -607, //解析头部数据失败
    ReadData_Fail                    = -608, //读取数据失败
    ReadOtherData_Fail               = -609, //读取剩余数据失败
    Reset_Socket                     = -610, //socket重置
    Analysis_Data_Fail               = -611, //解析接收到的数据失败
    Encrypt_Data_Fail                = -612, //加密数据失败
    Decrypt_Data_Fail                = -613, //解密数据失败
    ReadData_Timeout                 = -614, //等待响应超时
    App_In_Background                = -615, //app进入休眠状态
    Server_Mobile_Error              = -700, //服务端发送短信异常
    Server_Disable                   = -800, //网络异常
    Success                          = 0,    //成功
    User_NotLogin_                   = 50,  //请先登录
    User_NotLogin                    = 100,  //登录超时，请重新登录
    LoginPasswd_Error                = 101,  //手机号或密码错误
    PayPasswd_Error                  = 102,  //支付密码错误
    User_IsExist                     = 103,  //该手机号码已存在
    User_NotExist                    = 104,  //该手机号码未注册
    MobileCode_Error                 = 105,  //短信验证码错误，请重新输入
    MobileCode_Expire                = 106,  //短信校验码已过期，请重新获取
    MobileNum_Error                  = 107,  //请输入有效手机号码
    SN_Error                         = 108,  //请设置6-15位数字与字母组合密码
    IDCardNum_Error                  = 109,  //请输入有效身份证号码
    TrueName_Error                   = 110,  //姓名和身份证不一致
    PostCode_Error                   = 111,  //邮政编码输入错误
    BankCardNum_Error                = 112,  //请输入正确的储蓄卡号
    OpenSJS_OutTime                  = 113,  //操作超时，请再次提交
    OpenSJS_TradeSN_Error            = 114,  //请设置6-10位交易密码
    OpenSJS_MoneySN_Error            = 115,  //请设置6-10位资金密码
    OpenSJS_SN_Same_Error            = 116,  //交易密码与资金密码不能重复
    SJS_SN_Same_Error                = 117,  //新旧密码不能相同
    SJS_NotOutTime                   = 119,  //非出金时段
    SJS_NotInTime                    = 120,  //非入金时段
    OpenSJS_ACCTNO_Fail1             = 121,  //此账号与银行已存在签约关系
    SJS_Trade_SN_Error               = 122,  //上金所交易密码输入错误
    SJS_LOGIN_TIMEOUT                = 123,  //交易所登录超时
    SJS_LOGIN_ONLY_DEVICE            = 124,  //账号已在其它设备登录
    GOLD_NICKNAME_EXISTED            = 125,  //昵称已存在
    GOLD_NICKNAME_INVALID            = 126,  //昵称不符合要求
    GOLD_OLDPASS_ERROR               = 127,  //原密码输入错误
    SHJ_BIND_REPEAT                  = 130,  //用户已经绑定过深黄金账号
    SHJ_BIND_FAILD                   = 131,  //绑定深黄金账号失败（如已注销）
    SHJ_BIND_USER_ERROR              = 132,  //绑定深黄金账号错误：非500金会员
    GOLD_NICKNAME_SENSITIVE          = 134,  //昵称包含敏感信息
    GOLD_NEED_INVITE                 = 135,  //需要邀请码
    GOLD_NVALID_INVITE               = 136,  //无效的邀请码
    GOLD_NOT_ALLOW_TRADE             = 137,  //(T+2)不允许交易
    TRADE_NOT_ILLEGALITY             = 300,  //非法交易类型
    TRADE_ORDER_FAILD                = 301,  //订单创建失败
    TRADE_PRODCUT_ILLEGALITY         = 302,  //非法合约产品
    TRADE_ORDER_HANDLE               = 303,  //订单处理失败
    SJS_FundNotEnough                = 304,  //可用资金不足
    SJS_OderNotZero                  = 305,  //订单手数不能为0
    ORDER_ENTRUST_FAIL               = 306,  //成交单查询失败
    POSITION_QUERY_FAIL              = 307,  //持仓单查询失败
    ACOUNT_QUERY_FAIL                = 308,  //账户查询失败
    FUNDACOUNT_UPDATE_FAIL           = 309,  //更新资金流水订单状态失败
    TRADE_CONV_OUT                   = 310,  //平仓数目大于最大可平数目
    Trade_CloseTime                  = 311,  //非交易时间段响应的错误码
    UNIONLOGIN_TOKEN_ERROR           = 400,  //获取token失败
    UNIONLOGIN_USERINFO_ERROR        = 401,  //获取用户信息失败
    STUDIO_FORBIDDEN_SPEECH          = 500,  //文字直播-用户被禁言
    OpenSJS_BankCheck_Fail           = 8000, //银联验证不通过
    OpenSJS_SMS_Fail                 = 8001, //验证失败，请重新验证
    OpenSJS_ACCTNO_Fail              = 8002, //此账号与银行已存在签约关系
    OpenSJS_Invalid_Account          = 8003, //无效交易账号
    SJS_Invalid_Trade_PWD            = 8004, //原交易密码错误
    SJS_Invalid_Fund_PWD             = 8005, //原资金密码错误
    SJS_Trade_Not_Permit             = 8006, //该账户当天不能指定交易
    SJS_Account_Freeze               = 8007, //该账户已冻结
    SJS_Account_Not_Exist            = 8008, //该账户不存在
    OpenSJS_TRADESTATE_Fail          = 8100, //当前为非交易时间段
    OpenSJS_SYSSTATE_Fail            = 8101, //当前系统状态不允许该交易
    OpenSJS_TRADEPRICE_Fail          = 8102, //产品价格不在涨跌停范围内
    OpenSJS_TRADEDATE_Fail           = 8103, //交易日期不相符，不允许交易
    OpenSJS_TRADEPWD_Fail            = 8104, //交易编码或交易密码不正确
    OpenSJS_ShortFund                = 8105, //可用资金不足
    OpenSJS_ShortPosition            = 8106, //可用持仓不足
    OpenSJS_GETMONEY_Fail            = 8200 //可提资金不足
}

extension NetworkStatus {
    public func getStatus(_ value: Int) -> NetworkStatus {
        switch value {
        case 0:
            return .Success
        default:
            return .Success
        }
    }
    var description: String {
        get {
            var desc = ""
            switch self {
            case .Request_Error, .Request_Timeout, .Db_Error, .Cache_Error, .Seq_Error, .Param_Error, .Server_Error, .BankServer_Error, .MobileServer_Error, .EmailServer_Error, .GAServer_Error, .Server_Mobile_Error:
                desc = "请求失败，请稍后重试"
                break
            case .ConnectServer_Fail, .SendData_Data_Error, .SetSendTimeout_Fail, .SendData_Fail, .SetReadTimeout_Fail, .ReadHeadData_Fail, .ReadHeadOtherData_Fail, .AnalysisHeadData_Fail, .ReadData_Fail, .ReadOtherData_Fail, .Analysis_Data_Fail, .Encrypt_Data_Fail, .Decrypt_Data_Fail, .Server_Disable:
                desc = "网络繁忙"
                break
            case .ReadData_Timeout:
                desc = "服务器响应超时"
                break
            case .App_In_Background:
                desc = "APP已进入后台休眠状态"
                break
            case .Success:desc = ""
                desc = "成功";
                break;
            case .User_NotLogin_:
                desc = "请登录后再进行操作";
                break;
            case .User_NotLogin:
                desc = "登录超时，请重新登录";
                break;
            case .LoginPasswd_Error:
                desc = "手机号或密码错误";
                break;
            case .PayPasswd_Error:
                desc = "支付密码错误";
                break;
            case .User_IsExist:
                desc = "该手机号码已注册";
                break;
            case .User_NotExist:
                desc = "该手机号码未注册";
                break;
            case .MobileCode_Error:
                desc = "短信验证码错误，请重新输入";
                break;
            case .MobileCode_Expire:
                desc = "短信校验码已过期，请重新获取";
                break;
            case .MobileNum_Error:
                desc = "请输入有效手机号码";
                break;
            case .SN_Error:
                desc = "请设置6-15位数字与字母组合密码";
                break;
            case .IDCardNum_Error:
                desc = "请输入有效身份证号码";
                break;
            case .TrueName_Error:
                desc = "姓名和身份证不一致";
                break;
            case .PostCode_Error:
                desc = "邮政编码输入错误";
                break;
            case .BankCardNum_Error:
                desc = "请输入正确的储蓄卡号";
                break;
            case .OpenSJS_OutTime:
                desc = "操作超时，请再次提交";
                break;
            case .OpenSJS_TradeSN_Error:
                desc = "请设置6-10位交易密码";
                break;
            case .OpenSJS_MoneySN_Error:
                desc = "请设置6-10位资金密码";
                break;
            case .OpenSJS_SN_Same_Error:
                desc = "交易密码与资金密码不能重复";
                break;
            case .SJS_SN_Same_Error:
                desc = "新旧密码不能相同";
                break;
            case .SJS_NotOutTime:
                desc = "非出金时段";
                break;
            case .SJS_NotInTime:
                desc = "非入金时段";
                break;
            case .OpenSJS_ACCTNO_Fail1:
                desc = "该身份证已存在签约关系";
                break;
            case .SJS_Trade_SN_Error:
                desc = "上金所交易密码输入错误";
                break;
            case .SHJ_BIND_REPEAT:
                desc = "该交易账号已经绑定过其他用户";
                break;
            case .SHJ_BIND_FAILD:
                desc = "绑定失败";
                break;
            case .SHJ_BIND_USER_ERROR:
                desc = "非本机构客户号";
                break;
            case .SJS_LOGIN_TIMEOUT:
                desc = "账户登录超时，请重新登录";
                break;
            case .SJS_LOGIN_ONLY_DEVICE:
                desc = "您的交易账号已在其它设备登录，如果这不是您的操作，您的交易密码可能已泄露，如有需要请联系客服";
                break;
            case .GOLD_NICKNAME_EXISTED:
                desc = "昵称已存在";
                break;
            case .GOLD_NICKNAME_INVALID:
                desc = "昵称不符合要求";
                break;
            case .GOLD_NICKNAME_SENSITIVE:
                desc = "内容包含敏感词";
                break;
            case .GOLD_NEED_INVITE:
                desc = "请输入邀请码";
                break;
            case .GOLD_NVALID_INVITE:
                desc = "邀请码已失效";
                break;
            case .GOLD_NOT_ALLOW_TRADE:
                desc = "身份证信息审核中不允许交易";
                break;
            case .GOLD_OLDPASS_ERROR:
                desc = "原密码输入错误";
                break;
            case .TRADE_NOT_ILLEGALITY:
                desc = "非法交易类型";
                break;
            case .TRADE_ORDER_FAILD:
                desc = "订单创建失败";
                break;
            case .TRADE_PRODCUT_ILLEGALITY:
                desc = "非法合约产品";
                break;
            case .TRADE_ORDER_HANDLE:
                desc = "订单处理失败";
                break;
            case .ORDER_ENTRUST_FAIL:
                desc = "成交单查询失败";
                break;
            case .POSITION_QUERY_FAIL:
                desc = "持仓单查询失败";
                break;
            case .ACOUNT_QUERY_FAIL:
                desc = "账户查询失败";
                break;
            case .FUNDACOUNT_UPDATE_FAIL:
                desc = "更新资金流水订单状态失败";
                break;
            case .TRADE_CONV_OUT:
                desc = "平仓数目大于最大可平数目";
                break;
            case .SJS_FundNotEnough:
                desc = "可用资金不足";
                break;
            case .SJS_OderNotZero:
                desc = "订单手数不能为0";
                break;
            case .STUDIO_FORBIDDEN_SPEECH:
                desc = "您已被房间管理员禁言";
                break;
            case .OpenSJS_BankCheck_Fail:
                desc = "银联验证不通过";
                break;
            case .OpenSJS_SMS_Fail:
                desc = "验证失败，请重新验证";
                break;
            case .OpenSJS_ACCTNO_Fail:
                desc = "此账号与银行已存在签约关系";
                break;
            case .OpenSJS_Invalid_Account:
                desc = "无效交易账号";
                break;
            case .SJS_Invalid_Trade_PWD:
                desc = "原交易密码错误";
                break;
            case .SJS_Invalid_Fund_PWD:
                desc = "原资金密码错误";
                break;
            case .SJS_Trade_Not_Permit:
                desc = "该账户当天不能指定交易";
                break;
            case .SJS_Account_Freeze:
                desc = "该账户已冻结";
                break;
            case .SJS_Account_Not_Exist:
                desc = "该账户不存在";
                break;
            case .OpenSJS_TRADESTATE_Fail:
                desc = "当前为非交易时间段";
                break;
            case .OpenSJS_SYSSTATE_Fail:
                desc = "当前系统状态不允许该交易";
                break;
            case .OpenSJS_TRADEPRICE_Fail:
                desc = "产品价格不在涨跌停范围内";
                break;
            case .OpenSJS_TRADEDATE_Fail:
                desc = "交易日期不相符，不允许交易";
                break;
            case .OpenSJS_TRADEPWD_Fail:
                desc = "交易编码或交易密码不正确";
                break;
            case .OpenSJS_ShortFund:
                desc = "可用资金不足";
                break;
            case .OpenSJS_ShortPosition:
                desc = "可用持仓不足";
                break;
            case .OpenSJS_GETMONEY_Fail:
                desc = "可提资金不足";
                break;
            case .Request_Log_Other_Error:
                desc = "网络异常";
                break;
            case .Trade_CloseTime:
                desc = "非交易时间段";
                break;
            case .UNIONLOGIN_TOKEN_ERROR:
                desc = "联合登录验证失败";
                break;
            case .UNIONLOGIN_USERINFO_ERROR:
                desc = "联合登录验证失败";
                break;
            case .Reset_Socket:
                desc = "正在恢复连接";
                break;
            }
            return desc
        }
    }
}
