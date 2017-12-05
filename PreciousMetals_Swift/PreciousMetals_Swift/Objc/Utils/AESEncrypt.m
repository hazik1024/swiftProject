//
//  AESEncrypt.m
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/16.
//  Copyright © 2017年 ksjf. All rights reserved.
//

//密匙 key
#define kKey            @"ABCDEF0123456789"
//偏移量
#define kIv             @"1111111111111111"

#import "AESEncrypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation AESEncrypt
+ (NSString *)encrypt:(NSString *)string {
    return [self base64Encode:[self encryptToData:string]];
}

+ (NSString *)encryptWithData:(NSData *)data {
    return [self base64Encode:[self encryptToDataWithData:data]];
}

+ (NSString *)decrypt:(NSString *)string {
    return [[NSString alloc] initWithData:[self decryptToData:string] encoding:NSUTF8StringEncoding];
}

+ (NSData *)encryptToData:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self encryptToDataWithData:data];
}

+ (NSData *)encryptToDataWithData:(NSData *)data {
    NSMutableData *outData = [NSMutableData dataWithLength:data.length + kCCKeySizeAES128];
    
    NSData *vKey = [kKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *vIv = [kIv dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t outLen;
    CCCryptorStatus status = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, vKey.bytes, kCCKeySizeAES128, vIv.bytes, data.bytes, data.length, outData.mutableBytes, outData.length, &outLen);
    
    if (kCCSuccess == status) {
        if (outLen < outData.length) {
            outData.length = outLen;
        }
        return outData;
    }
    else {
        return nil;
    }
}

+ (NSData *)decryptToData:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSData *data = [self base64Decode:string];
    NSMutableData *outData = [NSMutableData dataWithLength:data.length + kCCKeySizeAES128];
    
    NSData *vKey = [kKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *vIv = [kIv dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t outLen;
    CCCryptorStatus status = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, vKey.bytes, kCCKeySizeAES128, vIv.bytes, data.bytes, data.length, outData.mutableBytes, outData.length, &outLen);
    
    if (kCCSuccess == status) {
        if (outLen < outData.length) {
            outData.length = outLen;
        }
        return outData;
    }
    else {
        return nil;
    }
}

+ (NSString *)hexStringWithBytes:(const void *)bytes length:(NSUInteger)length {
    NSMutableString *   result;
    NSParameterAssert(bytes != nil);
    result = [[NSMutableString alloc] initWithCapacity:length * 2];
    for (size_t i = 0; i < length; i++) {
        [result appendFormat:@"%02x", ((const uint8_t *) bytes)[i]];
    }
    return result;
}

+ (NSString *)hexStringWithData:(NSData *)data {
    if (data == nil) {
        return nil;
    }
    return [self hexStringWithBytes:data.bytes length:data.length];
}

+ (nullable NSData *)optionalDataWithHexString:(NSString *)hexString {
    if (hexString == nil) {
        return nil;
    }
    NSMutableData *result;
    NSUInteger cursor;
    NSUInteger limit;
    
    result = nil;
    cursor = 0;
    limit = hexString.length;
    if ((limit % 2) == 0) {
        result = [[NSMutableData alloc] init];
        
        while (cursor != limit) {
            unsigned int thisUInt;
            uint8_t thisByte;
            
            if (sscanf([hexString substringWithRange:NSMakeRange(cursor, 2)].UTF8String, "%x", &thisUInt) != 1 ) {
                result = nil;
                break;
            }
            thisByte = (uint8_t) thisUInt;
            [result appendBytes:&thisByte length:sizeof(thisByte)];
            cursor += 2;
        }
    }
    
    return result;
}

+ (NSData *)dataWithHexString:(NSString *)hexString {
    NSData *result;
    result = [self optionalDataWithHexString:hexString];
    return result;
}

+ (NSString *)base64Encode:(NSData *)data {
    NSString * output;
    output = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return output;
}

+ (NSData *)base64Decode:(NSString *)string {
    NSData * output;
    output = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return output;
}


+ (NSString *)md5:(NSString *)string{
    NSData *regionData = [string dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(regionData.bytes, (CC_LONG)regionData.length, result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}
@end
