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
    for (int i = 1; i <= 12; i ++) {
        [self.hourDate addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    for (int i = 0; i <= 59; i ++) {
        [self.minuteDate addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    
//    [self updateWeekDate];
    
    [self.pickerView reloadAllComponents];
    
}

#pragma mark - 滚动到特定时间位置
- (void)scrollToSelectDate {

    [self.pickerView selectRow:[self.timePickerModel.mouthDate integerValue] - 1 inComponent:0 animated:YES];
    [self.pickerView selectRow:[self.timePickerModel.dayDate integerValue] - 1 inComponent:1 animated:YES];
    [self.pickerView selectRow:[self selectAMPMDateIndex:self.timePickerModel.amPmDate] inComponent:2 animated:YES];
    [self.pickerView selectRow:[self.timePickerModel.hourDate integerValue] - 1 inComponent:3 animated:YES];
    [self.pickerView selectRow:[self.timePickerModel.minuteDate integerValue] - 0 inComponent:4 animated:YES];
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
            result = self.mouthDate.count;
            break;
        case 1:
            result = self.dayDate.count;//根据数组的元素个数返回几行数据
            break;
        case 2:
            result = self.amPmDateArray.count;
            break;
        case 3:
            result = self.hourDate.count;//根据数组的元素个数返回几行数据
            break;
        case 4:
            result = self.minuteDate.count;//根据数组的元素个数返回几行数据
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
            title = [NSString stringWithFormat:@"%@月",self.mouthDate[row]];
            break;
        case 1:
            title = [NSString stringWithFormat:@"%@日",self.dayDate[row]];
            break;
            
        case 2:
            title = self.amPmDateArray[row];
            break;
        case 3:
            title = [NSString stringWithFormat:@"%@时",self.hourDate[row]];
            break;
        case 4:
            title = [NSString stringWithFormat:@"%@分",self.minuteDate[row]];
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
        self.timePickerModel.mouthDate = self.mouthDate[row];
    } else if (component == 1) {
        self.timePickerModel.dayDate = self.dayDate[row];
        
    } else if (component == 2) {
        self.timePickerModel.amPmDate = self.amPmDateArray[row];
        
    } else if (component == 3) {
        self.timePickerModel.hourDate = self.hourDate[row];
    } else if (component == 4) {
        self.timePickerModel.minuteDate = self.minuteDate[row];
    }
    
    if (component <= 1) {
        int chosenYear;
        int chosenMonth;
        
        chosenYear = [self.timePickerModel.yearDate intValue];
        chosenMonth = [self.timePickerModel.mouthDate intValue];
        int DayDateLen = [self updateDayDateYear:chosenYear chosenMonth:chosenMonth];
        
        if ([self.timePickerModel.dayDate intValue] > DayDateLen) {
            self.timePickerModel.dayDate = [NSString stringWithFormat:@"%d",DayDateLen];
        }
        self.dayDate = [[NSMutableArray alloc]init];
        for (int i = 1; i <= DayDateLen; i ++) {
            [self.dayDate addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    
    [self scrollToSelectDate];
    [self.pickerView reloadAllComponents];
}

@end