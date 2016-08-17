//
//  YMDHMSDatePickerView.m
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "YMDHMSDatePickerView.h"
#import "YMDHMDatePickerView.h"
#import "YMandDHMDatePickerView.h"

#define Screen_height  [[UIScreen mainScreen] bounds].size.height
#define Screen_width  [[UIScreen mainScreen] bounds].size.width

@interface YMDHMSDatePickerView()<YMDHMDatePickerViewDelegate>

@end
@implementation YMDHMSDatePickerView

+ (id)initWithFrame:(CGRect)frame DatePickType:(BOBDatePickerMode)datePickerType {
    YMDHMSDatePickerView *datePicterView=[[YMDHMSDatePickerView alloc]initWithFrame:frame];
    [datePicterView datePicter:datePicterView addPickerViewType:datePickerType];
    return datePicterView;
}

- (void)datePicter:(YMDHMSDatePickerView *)datePicterView addPickerViewType:(BOBDatePickerMode)datePickerType {
    switch (datePickerType) {
        case DatePickerModeTime:
        {
            YMDHMDatePickerView *picterView=[YMDHMDatePickerView initWithFrame:CGRectMake(0, 50, datePicterView.bounds.size.width, datePicterView.frame.size.height - 50) BGcolor:[UIColor colorWithRed:(float)249/255.0 green:(float)249/255.0 blue:(float)249/255.0 alpha:1]];
            
            //指定委托
            picterView.delegate = datePicterView;
            [datePicterView addSubview:picterView];
        }
            break;
        case DatePickerModeDate:
        {
            YMandDHMDatePickerView *picterView=[YMandDHMDatePickerView initWithFrame:CGRectMake(0, 50, datePicterView.bounds.size.width, datePicterView.frame.size.height - 50) BGcolor:[UIColor colorWithRed:(float)249/255.0 green:(float)249/255.0 blue:(float)249/255.0 alpha:1]];
            
            //指定委托
            picterView.delegate = datePicterView;
            [datePicterView addSubview:picterView];
        }
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
}

@end
