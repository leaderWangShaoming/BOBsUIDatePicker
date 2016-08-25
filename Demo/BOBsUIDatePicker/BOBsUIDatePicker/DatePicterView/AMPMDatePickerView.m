//
//  AMPMDatePickerView.m
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "AMPMDatePickerView.h"
@interface AMPMDatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>


@end
@implementation AMPMDatePickerView
+ (id)initWithFrame:(CGRect)frame BGcolor:(UIColor *)BGcolor{
    AMPMDatePickerView *datePicterView=[[AMPMDatePickerView alloc]initWithFrame:frame];
    
    datePicterView.backgroundColor = BGcolor;
    //    datePicterView.hidden = YES;
    
    //获取需要展示的数据
    [datePicterView loadDataWithDateType];
    
    // 初始化pickerView
    datePicterView.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(15, 0, datePicterView.bounds.size.width -15, frame.size.height)];
    [datePicterView addSubview:datePicterView.pickerView];
    
    //指定数据源和委托
    datePicterView.pickerView.delegate = datePicterView;
    datePicterView.pickerView.dataSource = datePicterView;
    
    [datePicterView scrollToSelectDate];
    
    return datePicterView;
}

#pragma mark- 加载数据
- (void)loadDataWithDateType{
    [self setupPickerDate];
}

#pragma mark - 初始化日期时间
- (void)setupPickerDate {
    
    self.yearDate = [[NSMutableArray alloc]init];
    self.mouthDate = [[NSMutableArray alloc]init];
    self.dayDate = [[NSMutableArray alloc]init];
    self.hourDate = [[NSMutableArray alloc]init];
    self.minuteDate = [[NSMutableArray alloc]init];
    self.amPmDateArray = [[NSMutableArray alloc]initWithArray:@[@"AM", @"PM"]];
    self.mouthDayDateArray = [[NSMutableArray alloc]init];
    
    [self getCurrentDate];
    self.timePickerModel = [[DatePickerModel alloc]init];
    self.timePickerModel = self.currentTimePickerModel;
    
    //设置最小年份 和 最大 年份
    for (int i = [self.currentTimePickerModel.yearDate intValue]; i <= 2040; i ++) {
        [self.yearDate addObject:[NSString stringWithFormat:@"%.d",i]];
    }
    for (int i = 1; i <= 12; i ++) {
        [self.mouthDate addObject:[NSString stringWithFormat:@"%.d",i]];
    }
    
    int DayDateLen = [self getDayDateumber];
    
    for (int i = 1; i <= DayDateLen; i ++) {
        [self.dayDate addObject:[NSString stringWithFormat:@"%.d",i]];
    }
    for (int i = 1; i <= 12; i ++) {
        [self.hourDate addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    for (int i = 0; i <= 59; i ++) {
        [self.minuteDate addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    
    for (int i = 1; i <= self.mouthDate.count; i ++) {
        int dayDateLen = [self updateDayDateYear:[self.currentTimePickerModel.yearDate intValue] chosenMonth:[self.mouthDate[i-1] intValue]];
        for (int k = 1; k <= dayDateLen; k ++) {
            [self.mouthDayDateArray addObject:[NSString stringWithFormat:@"%@月%d日",self.mouthDate[i-1],k]];
        }
        
    }
    self.timePickerModel.mouthDayDate = self.mouthDayDateArray[[self currentMouthDayDateIndex]];
    //更新星期日期
    [self updateWeekDate];
    [self.pickerView reloadAllComponents];
}

#pragma mark - 滚动到特定时间位置
- (void)scrollToSelectDate {

    [self.pickerView selectRow:[self selectmouthDayDateIndex] inComponent:0 animated:YES];
    [self.pickerView selectRow:[self selectAMPMDateIndex:self.timePickerModel.amPmDate] inComponent:1 animated:YES];
    [self.pickerView selectRow:[self.timePickerModel.hourDate integerValue] - 1 + self.hourDate.count * DupliCountSelect inComponent:2 animated:YES];
    [self.pickerView selectRow:[self.timePickerModel.minuteDate integerValue] - 0 + self.minuteDate.count * DupliCountSelect inComponent:3 animated:YES];
}

- (int)currentMouthDayDateIndex {

    int mouthDayIndex = 0;
    for (int i = 1; i <= self.mouthDate.count; i ++) {
        int dayDateLen = [self updateDayDateYear:[self.currentTimePickerModel.yearDate intValue] chosenMonth:[self.mouthDate[i-1] intValue]];
        if (i < [self.timePickerModel.mouthDate intValue]) {
            mouthDayIndex += dayDateLen;
        } else if (i == [self.timePickerModel.mouthDate intValue]) {
            
            mouthDayIndex += [self.timePickerModel.dayDate intValue];
        }
    }
    return mouthDayIndex;
}

- (int)selectmouthDayDateIndex {
    for (int i = 0; i < self.mouthDayDateArray.count; i ++) {
        if ([self.timePickerModel.mouthDayDate isEqualToString:self.mouthDayDateArray[i]]) {
            return i;
        }
    }
    return 0;
}

- (int)selectAMPMDateIndex:(NSString*)AMPMDate {
    if ([AMPMDate isEqualToString:@"AM"]) {
        return 0;
    }
    return 1;
}
#pragma mark - 指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;//第一个展示字母、第二个展示数字
}

#pragma mark - 指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger result = 0;
    switch (component) {
        
        case 0:
            result = self.mouthDayDateArray.count;
            break;
        case 1:
            result = 1;
            break;
        case 2:
            result = self.amPmDateArray.count;
            break;
        case 3:
            result = self.hourDate.count * DupliCount;//根据数组的元素个数返回几行数据
            break;
        case 4:
            result = self.minuteDate.count * DupliCount;//根据数组的元素个数返回几行数据
            break;
        default:
            break;
    }
    return result;
}

#pragma mark UIPickerView Delegate Method 代理方法
#pragma mark - UIPickerView Delegate Methods
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view{
    
    
    
    UILabel *dateLabel = (UILabel *)view;
    dateLabel = [[UILabel alloc] init];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    
    NSString * title = nil;
    switch (component) {
        
        case 0:
            title = [NSString stringWithFormat:@"%@",self.mouthDayDateArray[row]];
            break;
        case 1:
            title = [NSString stringWithFormat:@"%@",self.timePickerModel.weekDate];
            break;
        case 2:
            title = self.amPmDateArray[row];
            break;
        case 3:
            title = [NSString stringWithFormat:@"%@时",self.hourDate[row % self.hourDate.count]];
            break;
        case 4:
            title = [NSString stringWithFormat:@"%@分",self.minuteDate[row % self.minuteDate.count]];
            break;
        default:
            break;
    }
    
    [dateLabel setText:title];
    dateLabel.font = [UIFont systemFontOfSize:16];
    return dateLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.timePickerModel.mouthDayDate = self.mouthDayDateArray[row];
        
        NSArray *mouthDayArray = [self.timePickerModel.mouthDayDate componentsSeparatedByString:@"月"]; //从字符月中分隔成2个元素的数组3月8日  --3 ， 8日
        self.timePickerModel.mouthDate = [mouthDayArray firstObject];
        self.timePickerModel.dayDate = [NSString stringWithFormat:@"%d",[[mouthDayArray lastObject] intValue]];
        //更新星期日期
        [self updateWeekDate];
    } else if (component == 1) {
        self.timePickerModel.amPmDate = self.amPmDateArray[row];
        
    } else if (component == 2) {
        self.timePickerModel.hourDate = self.hourDate[row % self.hourDate.count];
    } else if (component == 3) {
        self.timePickerModel.minuteDate = self.minuteDate[row % self.minuteDate.count];
    }
   
    [self scrollToSelectDate];
    [self.pickerView reloadAllComponents];
}

@end
