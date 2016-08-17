//
//  BOBsUIDatePicker.h
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerTabbarView.h"
#import "YMDHMSDatePickerView.h"


@protocol BOBsUIDatePickerDelegate <NSObject>
- (void)pickerViewSureButtonClick:(DatePickerModel *)datePickerModel;
@end

@interface BOBsUIDatePicker : UIView
@property(nonatomic, weak) id<BOBsUIDatePickerDelegate> delegate;

+ (id)initWithFrame:(CGRect)frame DatePickType:(BOBDatePickerMode)datePickerType;
- (void)setupShow;
- (void)setupHidden;
- (void)setupMsgLabel:(NSString*)message;

@end
