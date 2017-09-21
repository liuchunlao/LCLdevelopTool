//
//  UIView+LclExtension.h
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LclExtension)

@property (nonatomic, assign) CGFloat lcl_x;
@property (nonatomic, assign) CGFloat lcl_y;
@property (nonatomic, assign) CGFloat lcl_width;
@property (nonatomic, assign) CGFloat lcl_height;
@property (assign, nonatomic) CGSize lcl_size;
@property (assign, nonatomic) CGPoint lcl_origin;

/// 返回屏幕截图
- (UIImage *)lcl_snapshotImage;

@end
