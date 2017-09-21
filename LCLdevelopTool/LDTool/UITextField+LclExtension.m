//
//  UITextField+LclExtension.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/30.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "UITextField+LclExtension.h"

@implementation UITextField (LclExtension)

+ (instancetype)lcl_textFieldWithPlaceHolder:(NSString *)placeHolder fontSize:(CGFloat)fontSize color:(UIColor *)color imageName:(NSString *)imageName {
    
    UITextField *txtFld = [[self alloc] init];
    txtFld.placeholder = placeHolder;
    txtFld.textAlignment = NSTextAlignmentLeft;
    txtFld.textColor = color;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:placeHolder attributes:@{
                                                                                                                NSForegroundColorAttributeName : color,NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                      ];
    txtFld.attributedPlaceholder = str;
    
    
    txtFld.font = [UIFont systemFontOfSize:fontSize];
    
    if (imageName.length > 0) {
        
        txtFld.leftViewMode = UITextFieldViewModeAlways;
        UIImage *img = [UIImage imageNamed:imageName];
        //        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIImageView *imgV = [[UIImageView alloc] init];
        //        imgV.tintColor = [UIColor lcl_colorWithHex:0xffffff];
        imgV.image = img;
        
        txtFld.leftView = imgV;
    }
    
    txtFld.clearButtonMode = UITextFieldViewModeAlways;
    
    return txtFld;
}

@end
