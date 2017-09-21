//
//  UIColor+LclExtension.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LclExtension)

/**
 使用 16 进制数字创建颜色，例如 0xFF0000 创建红色
 @param hex 进制无符号32位整数
 */
+ (instancetype)lcl_colorWithHex:(uint32_t)hex;

/**
 生成随机颜色
 */
+ (instancetype)lcl_randomColor;

/**
 根据RGB值创建颜色
 */
+ (instancetype)lcl_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

@end
