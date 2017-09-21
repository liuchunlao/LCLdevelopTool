//
//  UIView+LclExtension.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "UIView+LclExtension.h"

@implementation UIView (LclExtension)

// MARK: - 截图功能
- (UIImage *)lcl_snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

- (void)setLcl_x:(CGFloat)lcl_x
{
    CGRect frame = self.frame;
    frame.origin.x = lcl_x;
    self.frame = frame;
}

- (CGFloat)lcl_x
{
    return self.frame.origin.x;
}

- (void)setLcl_y:(CGFloat)lcl_y
{
    CGRect frame = self.frame;
    frame.origin.y = lcl_y;
    self.frame = frame;
}

- (CGFloat)lcl_y
{
    return self.frame.origin.y;
}

- (void)setLcl_width:(CGFloat)lcl_width
{
    CGRect frame = self.frame;
    frame.size.width = lcl_width;
    self.frame = frame;
}

- (CGFloat)lcl_width
{
    return self.frame.size.width;
}

- (void)setLcl_height:(CGFloat)lcl_height
{
    CGRect frame = self.frame;
    frame.size.height = lcl_height;
    self.frame = frame;
}

- (CGFloat)lcl_height
{
    return self.frame.size.height;
}

- (void)setLcl_size:(CGSize)lcl_size
{
    CGRect frame = self.frame;
    frame.size = lcl_size;
    self.frame = frame;
}

- (CGSize)lcl_size
{
    return self.frame.size;
}

- (void)setLcl_origin:(CGPoint)lcl_origin
{
    CGRect frame = self.frame;
    frame.origin = lcl_origin;
    self.frame = frame;
}

- (CGPoint)lcl_origin
{
    return self.frame.origin;
}

@end
