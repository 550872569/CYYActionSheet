//
//  CYYActionSheet.m
//
//  Created by cyy
//  Copyright © 2017年 YY. cyy rights reserved.
//

#import "CYYActionSheet.h"
#import "Masonry.h"
#import "CYYActionSheetContentView.h"
#import "CYYActionSheetConst.h"

@interface CYYActionSheet ()<CYYActionSheetDelegate>

@property(nonatomic, strong) UIButton *buttonBg;
@property(nonatomic, strong) CYYActionSheetContentView *viewContent;
@property (nonatomic, weak) id<CYYActionSheetDelegate> delegate;
@property (nonatomic, strong) NSArray *arrayButtonTitle;
@property (nonatomic, copy) NSString *title;

@end

@implementation CYYActionSheet

- (void)actionSheet:(UIView *)sheet actionType:(CYYActionSheetType)type {
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:actionType:)]) {
        [self actionSheetHidden];
        [self.delegate actionSheet:self actionType:type];
    }
}
- (instancetype)initWithTitle:(NSString *)title buttonArray:(NSArray <NSString *>*)arrayButtonTitle delegateActionsheet:(id<CYYActionSheetDelegate>)delegate {
    if (self = [super init]) {
        _arrayButtonTitle = arrayButtonTitle.copy;
        _delegate = delegate;
        _title = title;
        self.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height));
        [self addSubview:self.buttonBg];
        self.buttonBg.frame = self.frame;
        self.viewContent.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kCYYActionSheetContentViewButtonHeight*_arrayButtonTitle.count+kCYYActionSheetContentViewTitleHeight);
    }
    return self;
}
- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [UIView animateWithDuration:ACTIONSHEET_ANIMATION_DUTATION animations:^{
        /** 遮罩背景色 */
        self.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.45];
        [self.viewContent setFrame:CGRectMake(0, (self.viewContent.frame.origin.y-(kCYYActionSheetContentViewButtonHeight*_arrayButtonTitle.count+kCYYActionSheetContentViewTitleHeight)), [UIScreen mainScreen].bounds.size.width, kCYYActionSheetContentViewButtonHeight*_arrayButtonTitle.count+kCYYActionSheetContentViewTitleHeight)];
    }];
}
- (void)actionSheetHidden {
    [UIView animateWithDuration:ACTIONSHEET_ANIMATION_DUTATION animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.viewContent.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kCYYActionSheetContentViewButtonHeight*_arrayButtonTitle.count+kCYYActionSheetContentViewTitleHeight);
    }];
    [self performSelector:@selector(_hidden) withObject:nil afterDelay:ACTIONSHEET_ANIMATION_DUTATION];
}

- (void)buttonSeleteCancelAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:actionType:)]) {
        [self actionSheetHidden];
        [self.delegate actionSheet:self actionType:CYYActionSheetTypeIndex_0];
    }
}

- (CYYActionSheetContentView *)viewContent {
    if (!_viewContent) {
        _viewContent = [[CYYActionSheetContentView alloc]initWithTitle:_title buttonArray:_arrayButtonTitle delegateActionsheet:self];
        [self addSubview:_viewContent];
    }
    return _viewContent;
}
- (UIButton *)buttonBg {
    if (!_buttonBg) {
        _buttonBg = [[UIButton alloc]init];
        [self addSubview:_buttonBg];
        _buttonBg.tag = 5;
        _buttonBg.backgroundColor = [UIColor clearColor];
        [_buttonBg addTarget:self action:@selector(buttonSeleteCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonBg;
}
- (void)_hidden {
    [self removeFromSuperview];
}

@end
