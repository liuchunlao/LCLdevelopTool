//
//  LCLMaskView.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/9/5.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCLMaskView : UIView


/**
 镂空的区域
 */
@property (nonatomic, assign) CGRect cropRect;

/**
 镂空边线的颜色
 */
@property (nonatomic, strong) UIColor *cropC;

/**
 镂空边线的宽度
 */
@property (nonatomic, assign) CGFloat cropW;

/**
 创建一个遮罩视图
 
 @param frame 遮罩视图的范围
 @param cropR 漏空的区域
 @param color 遮罩的颜色
 */
+ (instancetype)lcl_maskViewWithFrame:(CGRect)frame cropRect:(CGRect)cropR maskColor:(UIColor *)color;


@end
