//
//  YMDHMDatePickerView.h
//  NXBDatePicker
//
//  Created by 博彦科技-聂小波 on 16/7/29.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerModel.h"
#import "UIView+SizeXY.h"

@protocol YMDHMDatePickerViewDelegate <NSObject>

@end

@interface YMDHMDatePickerView : UIView
+ (id)initWithFrame:(CGRect)frame BGcolor:(UIColor *)BGcolor;
@property(nonatomic, weak) id<YMDHMDatePickerViewDelegate> delegate;

@property (nonatomic,strong)UIPickerView * pickerView;//自定义pickerview
@property (nonatomic,strong)NSMutableArray * dayDate;//
@property (nonatomic,strong)NSMutableArray * minuteDate;//
@property (nonatomic,strong)NSMutableArray * yearDate;//
@property (nonatomic,strong)NSMutableArray * mouthDate;//
@property (nonatomic,strong)NSMutableArray * hourDate;//
@property (nonatomic,strong)NSMutableArray * dataArray;//存放日期数据

@property (nonatomic,strong)DatePickerModel * currentTimePickerModel;
@property (nonatomic,strong)DatePickerModel * timePickerModel;


#pragma mark - 更新日期数据
- (int)updateDayDateYear:(int)chosenYear  chosenMonth:(int)chosenMonth;
#pragma mark - 当前时间
- (void)getCurrentDate;
#pragma mark - 滚动到特定时间位置
- (void)scrollToSelectDate;
- (int)getDayDateumber;


@end
