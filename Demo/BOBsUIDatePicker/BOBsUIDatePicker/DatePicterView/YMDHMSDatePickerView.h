//
//  YMDHMSDatePickerView.h
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerModel.h"
#import "UIView+SizeXY.h"

typedef NS_ENUM(NSInteger, BOBDatePickerMode) {
    DatePickerModeTime,           // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
    DatePickerModeDate,           // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
    DatePickerModeDateAndTime,    // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
    DatePickerModeCountDownTimer, // Displays hour and minute (e.g. 1 | 53)
} __TVOS_PROHIBITED;

@protocol YMDHMSDatePickerViewDelegate <NSObject>

@end

@interface YMDHMSDatePickerView : UIView
+ (id)initWithFrame:(CGRect)frame DatePickType:(BOBDatePickerMode)datePickerType;
@property(nonatomic, weak) id<YMDHMSDatePickerViewDelegate> delegate;
@property (nonatomic,strong)DatePickerModel * timePickerModel;
@end
