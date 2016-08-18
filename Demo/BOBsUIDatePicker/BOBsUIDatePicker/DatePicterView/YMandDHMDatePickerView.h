//
//  YMandDHMDatePickerView.h
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDHMDatePickerView.h"
@interface YMandDHMDatePickerView : YMDHMDatePickerView
@property (nonatomic,strong)NSMutableArray * weekDate;

#pragma mark - 初始化日期时间
- (void)setupPickerDate;
#pragma mark - 更新星期日期
- (void)updateWeekDate;
@end
