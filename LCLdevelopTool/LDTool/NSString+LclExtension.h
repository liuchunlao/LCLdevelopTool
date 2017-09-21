//
//  NSString+LclExtension.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (LclExtension)

#pragma mark - 加密工具类


/**
 DES 加密 解密

 @param string 要加密的字符串 或 要解密的字符串
 @param encryptOrDecrypt 加密 或解密
 @param key 加密 解密使用的key 保持一致！
 */
+ (instancetype)lcl_DES:(NSString*)string encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;

/**
 MD5加密
 @return md5加密后的字符串
 */
- (instancetype)lcl_MD5;
+ (instancetype)lcl_MD5:(NSString *)string;

/**
 将字符串进行url编码 - 注意防止域名被编码
 */
- (instancetype)lcl_URLEncoded;
+ (instancetype)lcl_URLEncodedString:(NSString *)string;

/**
 将字符串进行url解码
 */
- (NSString *)lcl_URLDecode;
+ (instancetype)lcl_URLDecodeString:(NSString *)string;

#pragma mark - 开发工具类
// MARK: - 将时间分割成两部分  日  月/年  时间格式【xxxx-xx-xx】
- (NSArray<NSAttributedString *> *)lcl_timeArrForFullCreateTime;

/**
 电话号码显示格式转换
 @param telephone 电话号码
 xxxxxxxxxx -> xxx-xxx-xxxx
 */
+ (instancetype)lcl_stringForTelephone:(NSString *)telephone;
- (instancetype)lcl_stringForTelephone;

/**
 返回字符串需要的宽高信息
 
 @param string 字符串内容
 @param size 大小，限制宽度或者高度
 @param attrs 属性信息 字体等
 */
+ (CGSize)lcl_sizeForString:(NSString *)string
                      size:(CGSize)size
                attributes:(NSDictionary *)attrs;
@end
