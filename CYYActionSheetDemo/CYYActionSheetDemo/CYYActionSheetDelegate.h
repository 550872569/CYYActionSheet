//
//  CYYActionSheetDelegate.h
//
//  Created by cyy
//  Copyright © 2017年 YY. cyy rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CYYActionSheetType) {
    CYYActionSheetTypeIndex_0 = 0,
    CYYActionSheetTypeIndex_1 = 1,
    CYYActionSheetTypeIndex_2 = 2,
    CYYActionSheetTypeIndex_3 = 3,
    CYYActionSheetTypeIndex_4 = 4,
    
    CYYActionSheetTypeIndex_Hidden = 11,
};

@protocol CYYActionSheetDelegate <NSObject>

- (void)actionSheet:(UIView *)sheet actionType:(CYYActionSheetType)type;

@end

@protocol CYYActionSheetProcotol <NSObject>

- (instancetype)initWithTitle:(NSString *)title buttonArray:(NSArray <NSString *>*)arrayButtonTitle delegateActionsheet:(id<CYYActionSheetDelegate>)delegate;

@optional
- (void)show;

@end

