//
//  ViewController.m
//  LCLdevelopTool
//
//  Created by liuchunlao on 2017/8/29.
//  Copyright © 2017年 liuchunlao. All rights reserved.
//

#import "ViewController.h"
#import "LCLDevelopTool.h"

@interface ViewController ()

@property (nonatomic, weak) LCLMaskView *maskV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LCLMaskView *v = [LCLMaskView lcl_maskViewWithFrame:CGRectMake(100, 100, 100, 100) cropRect:CGRectMake(25, 25, 50, 50) maskColor:[UIColor groupTableViewBackgroundColor]];
    
    [self.view addSubview:v];
    _maskV = v;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
    
}

@end
