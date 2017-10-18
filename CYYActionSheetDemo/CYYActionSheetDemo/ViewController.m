//
//  ViewController.m
//  CYYActionSheetDemo
//
//  Created by Yan on 2017/10/17.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "ViewController.h"
#import "CYYActionSheet.h"

@interface ViewController ()
<CYYActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)actionSheet:(UIView *)sheet actionType:(CYYActionSheetType)type {
    NSLog(@"type%ld",type);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *title = @"选择导航软件";
    NSArray *const arrayButtonTitle = @[@"使用系统自带地图导航",@"使用百度地图导航",@"使用高德地图导航",@"使用腾讯地图导航"];
    CYYActionSheet *actionSheet = [[CYYActionSheet alloc]initWithTitle:title buttonArray:arrayButtonTitle delegateActionsheet:self];
    [actionSheet show];
}

@end
