//
//  NSAttributedString+LclExtension.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (LclExtension)


/**
  处理时间的字体 斜体效果！

 @param timeStr 时间
 @param fontSize 大小
 @param textColor 颜色
 */
+ (instancetype)lcl_attrbutedStringForTime:(NSString *)timeStr size:(NSInteger)fontSize color:(UIColor *)textColor;

/**
 使用图像和文本生成上下排列的属性文本
 /// @param image      图像
 /// @param imageWH    图像宽高
 /// @param title      标题文字
 /// @param fontSize   标题字体大小
 /// @param titleColor 标题颜色
 /// @param spacing    图像和标题间距
 */
+ (instancetype)lcl_imageTextWithImage:(UIImage *)image
                              imageWH:(CGFloat)imageWH
                                title:(NSString *)title
                             fontSize:(CGFloat)fontSize
                           titleColor:(UIColor *)titleColor
                              spacing:(CGFloat)spacing;
@end
