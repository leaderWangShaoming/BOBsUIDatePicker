//
//  ViewController.m
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "ViewController.h"
#import "BOBsUIDatePicker.h"

#define Screen_height  [[UIScreen mainScreen] bounds].size.height
#define Screen_width  [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<BOBsUIDatePickerDelegate>
@property(nonatomic, strong) BOBsUIDatePicker *datePicterView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    sureBtn.tag = 2;
    [self setupButton:sureBtn Title:@"显示时间选择器" Color:[UIColor colorWithRed:(float)201/255.0 green:(float)52/255.0 blue:(float)21/255.0 alpha:1]];
    
    [self.view addSubview:sureBtn];
}

#pragma mark - 时间选择器
- (BOBsUIDatePicker *)datePicterView{
    if (!_datePicterView) {
        _datePicterView = [BOBsUIDatePicker initWithFrame:CGRectMake(0, Screen_height - 300, Screen_width, 300) DatePickType:DatePickerModeDate];
        _datePicterView.delegate = self;
        [self.view addSubview:_datePicterView];
    }
    return _datePicterView;
}

- (void)pickerViewSureButtonClick:(DatePickerModel *)datePickerModel {


}

- (void)setupButton:(UIButton*)Button  Title:(NSString*)Title  Color:(UIColor*)Color{
    [Button setTitle:Title forState:UIControlStateNormal];
    [Button setTitleColor:Color forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 按钮事件
- (void)buttonClick:(UIButton*)button {
    //调用方法
    self.datePicterView.tag = 102;
    [self.datePicterView setupShow];
    [self.datePicterView setupMsgLabel:@"时间选择器标题"];
}


@end
