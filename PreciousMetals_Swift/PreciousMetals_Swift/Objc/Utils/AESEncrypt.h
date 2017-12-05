//
//  AESEncrypt.h
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESEncrypt : NSObject
/**
 加密
 
 @param string 需要加密的字符串
 @return 十六进制字符串
 */
+ (NSString *)encrypt:(NSString *)string;
/**
 加密
 
 @param data 需要加密的NSData
 @return 十六进制字符串
 */
+ (NSString *)encryptWithData:(NSData *)data;
/**
 加密
 
 @param string 需要加密的字符串
 @return 十六进制字符串
 */
+ (NSData *)encryptToData:(NSString *)string;

/**
 解密
 
 @param string 需要解密的字符串
 @return 返回原始字符串
 */
+ (NSString *)decrypt:(NSString *)string;

/**
 解密
 
 @param string 需要解密的字符串
 @return 返回原始字符串
 */
+ (NSData *)decryptToData:(NSString *)string;

/**
 base64加密
 
 @param data 待加密data
 @return 字符串
 */
+ (NSString *)base64Encode:(NSData *)data;

/**
 base64解密
 
 @param string 待解密字符串
 @return 解密的字节流
 */
+ (NSData *)base64Decode:(NSString *)string;

+ (NSString *)md5:(NSString *)string;
@end
