//
//  LCLMaskView.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/9/5.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "LCLMaskView.h"

@interface LCLMaskView ()

/**
 显示的范围
 */
@property (nonatomic, assign) CGRect fullFrame;

/**
 遮罩颜色
 */
@property (nonatomic, strong) UIColor *maskColor;


@end

@implementation LCLMaskView

+ (instancetype)lcl_maskViewWithFrame:(CGRect)frame
                             cropRect:(CGRect)cropR
                            maskColor:(UIColor *)maskC {

    LCLMaskView *maskV = [[self alloc] initWithFrame:frame];
    maskV.cropRect = cropR;
    maskV.maskColor = maskC;
    maskV.backgroundColor = [UIColor clearColor];
    
    return maskV;
}

// MARK: - 调整边线颜色
- (void)setCropC:(UIColor *)cropC {

    _cropC = cropC;
    [self setNeedsDisplay];
}

// MARK: - 调整区域
- (void)setCropRect:(CGRect)cropRect {

    _cropRect = cropRect;
    [self setNeedsDisplay];
}

// MARK: - 调整边线宽度
- (void)setCropW:(CGFloat)cropW {

    _cropW = cropW;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {

    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    // 1. 绘制全部
    [_maskColor setFill];
    CGContextFillRect(cxt, rect);
    
    // 2. 清除不需要绘制的区域
    CGContextClearRect(cxt, _cropRect);
    
    // 3. 绘制边框颜色
    UIColor *borderC = _cropC ? _cropC : [UIColor colorWithWhite:0.95 alpha:1.0];
    [borderC setStroke];
    
    CGFloat borderW = _cropW > 0 ? _cropW : 1.0;
    
    CGContextStrokeRectWithWidth(cxt, _cropRect, borderW);
}

@end
