//
//  BOBsUIDatePicker.m
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import "BOBsUIDatePicker.h"


#define Screen_height  [[UIScreen mainScreen] bounds].size.height
#define Screen_width  [[UIScreen mainScreen] bounds].size.width

@interface BOBsUIDatePicker()<PickerTabbarViewDelegate>

@property (nonatomic,strong)PickerTabbarView *tabbarView;

@property (nonatomic,strong)YMDHMSDatePickerView *YMDHMDatePicker;
@property (nonatomic,strong)UIView *TempPickerView;

@end

@implementation BOBsUIDatePicker

+ (id)initWithFrame:(CGRect)frame DatePickType:(BOBDatePickerMode)datePickerType {
    
    BOBsUIDatePicker *datePicterView=[[BOBsUIDatePicker alloc]init];
    
    datePicterView.frame = CGRectMake(0, 0, Screen_width, Screen_height);
    datePicterView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    //添加datePicterView
    datePicterView.YMDHMDatePicker = [YMDHMSDatePickerView initWithFrame:frame DatePickType:DatePickerModeDateAndTime];
    datePicterView.YMDHMDatePicker.backgroundColor = [UIColor colorWithRed:(float)249/255.0 green:(float)249/255.0 blue:(float)249/255.0 alpha:1];
    [datePicterView addSubview:datePicterView.YMDHMDatePicker];
    [datePicterView.YMDHMDatePicker addSubview:datePicterView.tabbarView];
    
    [datePicterView setupShow];
    
    return datePicterView;
}

- (PickerTabbarView *)tabbarView{
    if (!_tabbarView) {
        _tabbarView = [[PickerTabbarView alloc]init];
        [_tabbarView drawPickerTabbarViewRect:CGRectMake(0, 0, Screen_width, 50)];
        _tabbarView.delegate = self;
        
    }
    return _tabbarView;
}

#pragma mark- PickerTabbarViewDelegate
- (void)pickerTabbarButtonClick:(UIButton *)Button {
    
    if (Button.tag == 1) {//取消
        [self setupHidden];
        
    } else if (Button.tag == 2) {//确定
        [self setupHidden];
        [self SureButtonClick];
    }
}

#pragma mark - 隐藏自己
- (void)setupHidden {
    [UIView animateWithDuration:0.3 animations:^{
        self.YMDHMDatePicker.y = Screen_height;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.YMDHMDatePicker.hidden = YES;
        self.hidden = YES;
    });
}

#pragma mark - 显示自己
- (void)setupShow {
    self.YMDHMDatePicker.y =  Screen_height;
    self.hidden = NO;
    self.YMDHMDatePicker.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.YMDHMDatePicker.y = Screen_height - 300;
        
    }];
}

#pragma mark - 标题
- (void)setupMsgLabel:(NSString*)message {
    self.tabbarView.msgLabel.text = message;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
    [self setupHidden];
}

#pragma mark - 确定 事件
- (void)SureButtonClick {
    if ([self.delegate respondsToSelector:@selector(pickerViewSureButtonClick:)]) {
        [self.delegate pickerViewSureButtonClick:self.YMDHMDatePicker.timePickerModel];
    }
}

@end
