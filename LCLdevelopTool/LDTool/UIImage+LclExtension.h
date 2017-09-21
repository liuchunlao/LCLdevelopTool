//
//  UIImage+LclExtension.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LclExtension)

    

/**
 裁剪指定区域生成新图片
 @param image 原始图片
 @param rect 裁剪区域
 */
+ (instancetype)lcl_clicpImage:(UIImage *)image inRect:(CGRect)rect;
    
/**
 通过颜色生成图片
 */
+ (instancetype)lcl_imageWithColor:(UIColor *)color;

/**
 加载原始图片，避免被渲染
 */
+ (instancetype)lcl_originalImageName:(NSString *)name;

/**
 拉伸图片
 */
+ (instancetype)lcl_stretchImageWithName:(NSString *)imgName;


/**
 将图片裁剪出正方形效果
 */
- (instancetype)lcl_squareImage;

@end
