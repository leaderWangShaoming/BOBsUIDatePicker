//
//  YMDHMSDataSource.h
//  BOBsUIDatePicker
//
//  Created by beyondsoft-聂小波 on 16/8/17.
//  Copyright © 2016年 NieXiaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatePickerModel.h"

@interface YMDHMSDataSource : NSObject
@property (nonatomic,strong)NSMutableArray * dayDate;//
@property (nonatomic,strong)NSMutableArray * minuteDate;//
@property (nonatomic,strong)NSMutableArray * yearDate;//
@property (nonatomic,strong)NSMutableArray * mouthDate;//
@property (nonatomic,strong)NSMutableArray * hourDate;//
@property (nonatomic,strong)NSMutableArray * dataArray;//存放日期数据
@property (nonatomic,strong)NSArray * dataTitleArray;//存放日期数据中文
@property (nonatomic,strong)DatePickerModel * currentTimePickerModel;
@property (nonatomic,strong)DatePickerModel * timePickerModel;

@end
