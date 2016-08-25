# BOBsUIDatePicker

     模仿UIDatePicker的一套自定义DatePicker时间选择器（系统时间选择器 对自定义功能权限不够，无法满足不同设计）。此选择器可以自定义文字大小和颜色，位置，时间类型等等

#### 拖动DatePicterView文件到项目中

#### 功能说明：
      YMDHMSDatePickerView 是数据源以及方法设置base view ，包括年月日时分秒，在此基础上继承文件添加 星期 和 AM/PM。


#### 使用说明：

        #pragma mark - 时间选择器 懒加载
        - (BOBsUIDatePicker *)datePicterView{
        if (!_datePicterView) {
        _datePicterView = [BOBsUIDatePicker initWithFrame:CGRectMake(0, Screen_height - 300, Screen_width, 300) DatePickType:self.btnTag == 0 ? DatePickerModeTime : (self.btnTag == 1 ? DatePickerModeDate : DatePickerModeDateAndTime)];
        _datePicterView.delegate = self;
        [self.view addSubview:_datePicterView];
        }
        return _datePicterView;
        }


        #pragma mark - 按钮点击事件
        - (void)buttonClick:(UIButton*)button {
        _datePicterView = nil;
        self.btnTag = button.tag;
        [self.datePicterView setupShow];
        [self.datePicterView setupMsgLabel:@"时间选择器标题"];
        }

#### 屏幕截图：

![image](https://github.com/niexiaobo/BOBsUIDatePicker/tree/master/Demo/BOBsUIDatePicker/BOBsUIDatePicker/shotImages/a1)

![image](https://github.com/niexiaobo/BOBsUIDatePicker/tree/master/Demo/BOBsUIDatePicker/BOBsUIDatePicker/shotImages/a2)

![image](https://github.com/niexiaobo/BOBsUIDatePicker/tree/master/Demo/BOBsUIDatePicker/BOBsUIDatePicker/shotImages/a3)

![image](https://github.com/niexiaobo/BOBsUIDatePicker/tree/master/Demo/BOBsUIDatePicker/BOBsUIDatePicker/shotImages/a4)





