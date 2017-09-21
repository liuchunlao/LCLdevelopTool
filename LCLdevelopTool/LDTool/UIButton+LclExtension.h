//
//  UIButton+LclExtension.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LclExtension)

/**
 创建文本按钮
 @param title         文本
 @param fontSize      字体大小
 @param normalColor   默认颜色
 @param selectedColor 选中颜色
 */
+ (instancetype)lcl_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

/**
 将按钮的图片渲染成需要的颜色
 
 @param imgName 图片名称
 @param rendColor 渲染的颜色值
 */
+ (UIButton *)lcl_colorButtonWithImgName:(NSString *)imgName rendColor:(UIColor *)rendColor;

@end
