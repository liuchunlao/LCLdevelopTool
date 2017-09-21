//
//  UIImage+LclExtension.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "UIImage+LclExtension.h"

@implementation UIImage (LclExtension)

   
// MARK: - 裁剪指定区域，生成新图片
+ (instancetype)lcl_clicpImage:(UIImage *)image inRect:(CGRect)rect {

    CGImageRef cgImg = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *img = [UIImage imageWithCGImage:cgImg];
    
    CGImageRelease(cgImg);
    
    return img;
}
    
// MARK: - 正方形图片
- (instancetype)lcl_squareImage {
    
    // 1 裁剪出正方形
    CGSize orgSize = self.size;
    
    CGFloat destW;
    CGFloat destX;
    CGFloat destY;
    
    if (orgSize.width > orgSize.height) {
        destW = orgSize.height;
        destY = 0;
        destX = (orgSize.width - orgSize.height) * 0.5;
        
    } else {
        destW = orgSize.width;
        destX = 0;
        destY = (orgSize.height - orgSize.width) * 0.5;
    }
    
    // 2 裁剪正方形图片
    CGRect destRect = CGRectMake(destX, destY, destW, destW);
    
    CGImageRef imgRef = CGImageCreateWithImageInRect(self.CGImage, destRect);
    UIImage *destImg = [[UIImage alloc] initWithCGImage:imgRef];
    
    CGImageRelease(imgRef);

    return destImg;
}

// MARK: - 根据颜色生成图片
+ (instancetype)lcl_imageWithColor:(UIColor *)color {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, 0.0);
    
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(cxt, color.CGColor);
    CGContextFillRect(cxt, CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    return image;
    
}

// MARK: - 加载原始图片，防止被渲染！
+ (instancetype)lcl_originalImageName:(NSString *)name {
    
    UIImage *img = [UIImage imageNamed:name];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// MARK: - 拉伸图片
+ (instancetype)lcl_stretchImageWithName:(NSString *)imgName {
    
    UIImage *img = [UIImage imageNamed:imgName];
    return [img stretchableImageWithLeftCapWidth:img.size.width * 0.5 topCapHeight:img.size.height * 0.5];
}


@end
