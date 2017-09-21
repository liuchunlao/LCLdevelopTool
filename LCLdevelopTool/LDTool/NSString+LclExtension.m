//
//  NSString+LclExtension.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "NSString+LclExtension.h"
#import "UIColor+LclExtension.h"
#import "NSAttributedString+LclExtension.h"
#import "GTMBase64.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

#define KEY_2 @"p2p_s2iv"

@implementation NSString (LclExtension)

#pragma mark - 加密相关
// MARK: - DES加密
+ (instancetype)lcl_DES:(NSString*)string encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key {

    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData = [GTMBase64 decodeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    NSString *initVec = KEY_2;
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySize3DES,
                       vinitVec, //"init Vec", //iv,
                       vplainText, //"Your Name", //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                               length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding]
        ;
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
    
}


// MARK: - MD5加密
+ (instancetype)lcl_MD5:(NSString *)string {

    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]] lowercaseString];
}

- (instancetype)lcl_MD5 {

    return [NSString lcl_MD5:self];
}


// MARK: - URL编码
+ (instancetype)lcl_URLEncodedString:(NSString *)string {
    
    NSString *encodedString = (NSString *)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                              nil,
                                                              (CFStringRef)string,
                                                              NULL,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              kCFStringEncodingUTF8));
    
    
    return encodedString;
}

- (instancetype)lcl_URLEncoded {

    return [NSString lcl_URLEncodedString:self];
}

// MARK: - URL解码
+ (instancetype)lcl_URLDecodeString:(NSString *)string {

    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(nil,
                                                                                                                     (__bridge CFStringRef)string,
                                                                                                                     CFSTR(""),                                                     kCFStringEncodingUTF8);
    return decodedString;
}

- (NSString *)lcl_URLDecode {
    
    return [NSString lcl_URLDecodeString:self];
}



#pragma mark - 开发工具类
// MARK: - 将时间分割成两部分  日  月/年  时间格式【xxxx-xx-xx】
- (NSArray<NSAttributedString *> *)lcl_timeArrForFullCreateTime {
    
    NSArray<NSString *> *arr = [self componentsSeparatedByString:@"-"];
    
    // 将月转换成英文！
    NSDictionary *dict = @{
                           @"01" : @"Jan",
                           @"02" : @"Feb",
                           @"03" : @"Mar",
                           @"04" : @"Apr",
                           @"05" : @"May",
                           @"06" : @"Jun",
                           @"07" : @"Jul",
                           @"08" : @"Aug",
                           @"09" : @"Sep",
                           @"10" : @"Oct",
                           @"11" : @"Nov",
                           @"12" : @"Dec"
                           };
    // 日
    NSString *firstStr = arr.lastObject;
    
    // 年 & 月
    NSString *month = dict[arr[1]];
    NSString *year = arr.firstObject;
    NSString *secondStr = [month stringByAppendingFormat:@"/%@", year];
    
    // 日
    NSAttributedString *attr1 = [NSAttributedString lcl_attrbutedStringForTime:firstStr size:33 color:[UIColor lcl_colorWithHex:0x000000]];
    
    NSAttributedString *attr2 = [NSAttributedString lcl_attrbutedStringForTime:secondStr size:13 color:[UIColor lcl_colorWithHex:0x999999]];
    
    return @[attr1, attr2];
}

// MARK: - 将电话号码按照 xxx-xxx-xxxx格式显示
+ (instancetype)lcl_stringForTelephone:(NSString *)telephone {
    
    NSUInteger length = telephone.length;
    
    NSInteger margin = 3;
    
    // 倍数
    NSInteger times = length / margin;
    // 余数
    NSInteger reminder = length % margin;
    
    // 如果余数 < 3; 横线减一
    if (reminder < margin) {
        times--;
    }
    NSLog(@"%zd", times);
    NSMutableArray *tempArrM = [NSMutableArray array];
    for (int i = 0; i < times; i++) {
        NSString *tempStr = [telephone substringWithRange:NSMakeRange(i * margin, margin)];
        
        [tempArrM addObject:tempStr];
    }
    NSString *lastStr = [telephone substringFromIndex:times * margin];
    [tempArrM addObject:lastStr];
    
    // 拼接横线！
    NSMutableString *strM = [NSMutableString string];
    [tempArrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [strM appendFormat:@"%@-", obj];
    }];
    // 去掉最后一根横线
    return [strM substringToIndex:(strM.length - 1)];
    
}

- (instancetype)lcl_stringForTelephone {
    
    return [NSString lcl_stringForTelephone:self];
}

// MARK: - 处理后台返回的时间 年 月 日 xxxx-xx-xx
+ (instancetype)lcl_stringFromTimeIntervalSince1970:(NSTimeInterval)interval
                                   dateFormatter:(NSString *)dateFormatter {
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = dateFormatter;
    
    return [fmt stringFromDate:date];
}

// MARK: - 计算字符串显示需要的大小
+ (CGSize)lcl_sizeForString:(NSString *)string size:(CGSize)size attributes:(NSDictionary *)attrs {
    
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:NULL].size;
}
@end
