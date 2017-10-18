//
//  CYYActionSheetContentView.m
//
//  Created by cyy
//  Copyright © 2017年 YY. cyy rights reserved.
//

#import "CYYActionSheetContentView.h"
#import "Masonry.h"

#define kActionSheetButtonFont          17
#define OFFSET_LINE_HEIGHT                      0.5

@interface CYYActionSheetContentView ()

@property (nonatomic, weak) id<CYYActionSheetDelegate> delegate;
@property (nonatomic, strong) NSArray *arrayButtonTitle;
@property (nonatomic, copy) NSString *title;

@end

@implementation CYYActionSheetContentView

- (instancetype)initWithTitle:(NSString *)title buttonArray:(NSArray <NSString *>*)arrayButtonTitle delegateActionsheet:(id<CYYActionSheetDelegate>)delegate {
    if (self = [super init]) {
        _arrayButtonTitle = arrayButtonTitle.copy;
        _delegate = delegate;
        _title = title;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kCYYActionSheetContentViewButtonHeight*_arrayButtonTitle.count+kCYYActionSheetContentViewTitleHeight);
        [self initUI];
    }
    return self;
}
- (void)initUI {
    /** action sheet 背景色 */
    self.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    NSString *buttonTitle;
    UIColor *buttonBackgroundColor;
    UIColor *buttonTitleColor;
    CGFloat buttonCornerRadius = 5;
    UIColor *buttonBorderColor;
    for (NSInteger i = 0; i <_arrayButtonTitle.count+1; i ++) {
        if (i==CYYActionSheetTypeIndex_0) {
            buttonTitle = nil;
        } else {
            buttonTitle = _arrayButtonTitle[i-1];
        }
        buttonBackgroundColor = [UIColor clearColor];
        buttonTitleColor = [UIColor blackColor];
        buttonBorderColor = [UIColor clearColor];                
        UIButton *button = [self buttonWithTitle:buttonTitle titleFont:kActionSheetButtonFont titleColor:buttonTitleColor backgroundColor:buttonBackgroundColor cornerRadius:buttonCornerRadius tag:i borderColor:buttonBorderColor borderWidth:1];
        [button addTarget:self action:@selector(buttonSeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        UIImageView *imageViewLine = [[UIImageView alloc]init];
        imageViewLine.tag = i;
        imageViewLine.backgroundColor = [UIColor grayColor];// 分割线颜色
        [self addSubview:imageViewLine];
        if (button.tag==CYYActionSheetTypeIndex_0) {
            [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
    }
    UILabel *labelTitle = [[UILabel alloc]init];
    [labelTitle setTextColor:[UIColor colorWithRed:71 green:71 blue:71 alpha:1]];
    [labelTitle setTextAlignment:NSTextAlignmentLeft];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    [labelTitle setNumberOfLines:1];
    [labelTitle setTextColor:[UIColor blackColor]];
    [labelTitle setFont:[UIFont systemFontOfSize:15]];
    [labelTitle setText:_title];
    [self addSubview:labelTitle];
    UIButton *buttonHidden = [[UIButton alloc]init];
    [buttonHidden setImage:[UIImage imageNamed:@"actionsheet_image_hidden"] forState:UIControlStateNormal];
    [buttonHidden setImage:[UIImage imageNamed:@"actionsheet_image_hidden"] forState:UIControlStateHighlighted];
    [buttonHidden setImage:[UIImage imageNamed:@"actionsheet_image_hidden"] forState:UIControlStateSelected];
    buttonHidden.tag = _arrayButtonTitle.count+10;
    [buttonHidden addTarget:self action:@selector(buttonSeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonHidden];
}
- (UIButton *)buttonWithTitle:(NSString *)title
                    titleFont:(CGFloat)font
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                 cornerRadius:(CGFloat)cornerRadius
                          tag:(NSInteger)tag
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setBackgroundColor:backgroundColor];
    button.layer.cornerRadius = cornerRadius;
    button.tag = tag;
    button.layer.borderColor = borderColor.CGColor;
    button.layer.borderWidth = borderWidth;
    return button;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    CGRect frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), kCYYActionSheetContentViewButtonHeight*_arrayButtonTitle.count+kCYYActionSheetContentViewTitleHeight);
    CGFloat viewLinewidth = frame.size.width - 2*20;
    for (UIButton *button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            if (button.tag==CYYActionSheetTypeIndex_0) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self);
                    make.height.equalTo(@(kCYYActionSheetContentViewTitleHeight));
                    make.width.equalTo(self);
                    make.top.equalTo(self.mas_top);
                }];
            } else {
                if (button.tag != _arrayButtonTitle.count+10) {
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self);
                        make.height.equalTo(@(kCYYActionSheetContentViewButtonHeight));
                        make.width.equalTo(self);
            make.top.equalTo(self.mas_top).with.offset(((button.tag-1)*kCYYActionSheetContentViewButtonHeight+kCYYActionSheetContentViewTitleHeight));
                    }];
                } else {
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        [button mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.equalTo(@(kCYYActionSheetContentViewTitleHeight));
                            make.height.equalTo(@(kCYYActionSheetContentViewTitleHeight));
                            make.top.equalTo(self.mas_top);
                            make.right.equalTo(self.mas_right).with.offset(-20);
                        }];
                    }];
                }
            }
        }
        if ([button isKindOfClass:[UIImageView class]]) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.height.equalTo(@OFFSET_LINE_HEIGHT);
                make.width.equalTo(@(viewLinewidth));
                make.top.equalTo(self.mas_top).with.offset(kCYYActionSheetContentViewTitleHeight+button.tag*kCYYActionSheetContentViewButtonHeight);
            }];           
        }
        if ([button isKindOfClass:[UILabel class]]) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).with.offset(20);
                make.height.equalTo(@20);
                make.top.equalTo(self.mas_top).with.offset((kCYYActionSheetContentViewTitleHeight-20)*0.5);
            }];
        }
    }
}


- (void)buttonSeleteAction:(UIButton *)sender {
    if (sender.tag == CYYActionSheetTypeIndex_0) {
      //title
    } else if (sender.tag == _arrayButtonTitle.count+10) {
        //hidden
        if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:actionType:)]) {
            [self.delegate actionSheet:self actionType:CYYActionSheetTypeIndex_Hidden];
        }
    } else  {
        // chose button
        if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:actionType:)]) {
            [self.delegate actionSheet:self actionType:sender.tag];
        }
    }
}

@end
