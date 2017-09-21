//
//  UIButton+LclExtension.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "UIButton+LclExtension.h"
#import "UIColor+LclExtension.h"

@implementation UIButton (LclExtension)

+ (UIButton *)lcl_colorButtonWithImgName:(NSString *)imgName rendColor:(UIColor *)rendColor{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.imageView.tintColor = rendColor;
    UIImage *img = [UIImage imageNamed:imgName];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [btn setImage:img forState:UIControlStateNormal];
    
    return btn;
}

+ (instancetype)lcl_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    
    [button sizeToFit];
    
    return button;
}

@end
