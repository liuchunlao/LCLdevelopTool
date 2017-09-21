//
//  UITextField+LclExtension.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LclExtension)

/**
 @param placeHolder 占位文字
 @param fontSize 字体大小
 @param color 字体颜色
 @param imageName 左侧要显示的图片名称
 */
+ (instancetype)lcl_textFieldWithPlaceHolder:(NSString *)placeHolder
                                   fontSize:(CGFloat)fontSize
                                      color:(UIColor *)color
                                  imageName:(NSString *)imageName;
@end
