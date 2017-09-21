//
//  NSAttributedString+LclExtension.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "NSAttributedString+LclExtension.h"

@implementation NSAttributedString (LclExtension)

// MARK: - 处理时间的字体 斜体效果！
+ (instancetype)lcl_attrbutedStringForTime:(NSString *)timeStr size:(NSInteger)fontSize color:(UIColor *)textColor {
    
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:timeStr];
    [attrM addAttributes:@{
                           NSFontAttributeName :  [UIFont fontWithName:@"Baskerville-Italic" size:fontSize],
                           NSForegroundColorAttributeName : textColor
                           
                           } range:NSMakeRange(0, timeStr.length)];
    
    return attrM.copy;
}

+ (instancetype)lcl_imageTextWithImage:(UIImage *)image imageWH:(CGFloat)imageWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    
    // 文本字典
    NSDictionary *titleDict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                NSForegroundColorAttributeName: titleColor};
    NSDictionary *spacingDict = @{NSFontAttributeName: [UIFont systemFontOfSize:spacing]};
    
    // 图片文本
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, imageWH, imageWH);
    NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 换行文本
    NSAttributedString *lineText = [[NSAttributedString alloc] initWithString:@"\n\n" attributes:spacingDict];
    
    // 按钮文字
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:title attributes:titleDict];
    
    // 合并文字
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithAttributedString:imageText];
    [attM appendAttributedString:lineText];
    [attM appendAttributedString:text];
    
    return attM.copy;
}


@end
