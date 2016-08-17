//
//  YMDHMSDataSource.m
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "YMDHMSDataSource.h"

@implementation YMDHMSDataSource
#pragma mark - 初始化日期时间
- (void)setupPickerDate {
    
    self.yearDate = [[NSMutableArray alloc]init];
    self.mouthDate = [[NSMutableArray alloc]init];
    self.dayDate = [[NSMutableArray alloc]init];
    self.hourDate = [[NSMutableArray alloc]init];
    self.minuteDate = [[NSMutableArray alloc]init];
    [self getCurrentDate];
    self.timePickerModel = [[DatePickerModel alloc]init];
    self.timePickerModel = self.currentTimePickerModel;
    
    //设置最小年份 和 最大 年份
    for (int i = 2016; i <= 2040; i ++) {
        [self.yearDate addObject:[NSString stringWithFormat:@"%.d",i]];
    }
    for (int i = 1; i <= 12; i ++) {
        [self.mouthDate addObject:[NSString stringWithFormat:@"%.d",i]];
    }
    
    int DayDateLen = [self getDayDateumber];
    
    for (int i = 1; i <= DayDateLen; i ++) {
        [self.dayDate addObject:[NSString stringWithFormat:@"%.d",i]];
    }
    for (int i = 1; i <= 24; i ++) {
        [self.hourDate addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    for (int i = 0; i <= 59; i ++) {
        [self.minuteDate addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    
    self.dataTitleArray = @[@"年",@"月",@"日",@"时",@"分",@"秒"];
    
    [self.dataArray addObject:self.yearDate];
    [self.dataArray addObject:self.mouthDate];
    [self.dataArray addObject:self.dayDate];
    [self.dataArray addObject:self.hourDate];
    [self.dataArray addObject:self.minuteDate];
    //    [self.dataArray addObject:self.yearDate];
    
//    [self.pickerView reloadAllComponents];
    
}

- (NSMutableArray * )dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
#pragma mark - 当前时间
- (void)getCurrentDate {
    NSDate *dateNow = [NSDate date];
    /*
     日历类[calendar]
     注意: 一定要用[NSCalendar currentCalendar]初始化,
     如果用[[NSCalendar alloc] init]初始化, 获取的时间会是随机式.
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    /*
     变量
     */
    NSInteger year;         //年
    NSInteger month;        //月
    NSInteger day;          //日
    NSInteger hour;         //时
    NSInteger minute;       //分
    NSInteger second;       //秒
    NSInteger nanosecond;   //10^-9秒
    
    
    /*
     使用[calendar]对象从[dateNow]中获取 [hour] [minute] [second] [nanosecond]
     注意: '&'是取地址符, 把变量的"地址"传过去,
     函数会把相应的值写入这个"地址", 我们的变量里面就存入相应的值了.
     */
    [calendar getHour:&hour minute:&minute second:&second nanosecond:&nanosecond fromDate:dateNow];
    
    [calendar getEra:nil year:&year month:&month day:&day fromDate:dateNow];
    
    
    NSLog(@"%.ld-%.ld-%.ld %.ld:%02ld:%02ld.%03ld", year, month, day, hour, minute, second, nanosecond/1000000);
    
    self.currentTimePickerModel = [[DatePickerModel alloc]init];
    self.currentTimePickerModel.yearDate = [NSString stringWithFormat:@"%.ld",year];
    self.currentTimePickerModel.mouthDate = [NSString stringWithFormat:@"%.ld",month];
    self.currentTimePickerModel.dayDate = [NSString stringWithFormat:@"%.ld",day];
    self.currentTimePickerModel.hourDate = [NSString stringWithFormat:@"%02ld",hour];
    self.currentTimePickerModel.minuteDate = [NSString stringWithFormat:@"%02ld",minute];
    
}

- (int)getDayDateumber {
    return [self updateDayDateYear:[self.currentTimePickerModel.yearDate intValue] chosenMonth:[self.currentTimePickerModel.mouthDate intValue]];
}

#pragma mark - 更新日期数据
- (int)updateDayDateYear:(int)chosenYear  chosenMonth:(int)chosenMonth{
    if ((chosenMonth == 1) || (chosenMonth == 3) || (chosenMonth == 5) ||(chosenMonth == 7)||(chosenMonth == 8)||(chosenMonth == 10)||(chosenMonth == 12))
    {
        return 31;
    }
    if ((chosenMonth == 4)||(chosenMonth == 6)||(chosenMonth == 9)||(chosenMonth == 11)) {
        return 30;
    }
    if ((chosenYear % 100 != 0)&(chosenYear % 4 == 0)) {
        return 29;
    }
    if ((chosenYear % 400 == 0)) {
        return 29;
    }
    return 28;
}


@end
