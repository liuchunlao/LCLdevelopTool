//
//  UIScreen+LclExtension.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "UIScreen+LclExtension.h"

@implementation UIScreen (LclExtension)

+ (CGFloat)lcl_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)lcl_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)lcl_scale {
    return [UIScreen mainScreen].scale;
}

@end
