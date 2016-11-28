# BLPickView
pickView的封装，将数据源与代理抛出

使用方法： 1.初始化
```

    _pickView = [[BLPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    _pickView.pickViewDelegate = self;
    _pickView.pickViewDataSource = self;
    _pickView.buttonClickedBlock = ^(BOOL isSureButton){
        NSLog(@"%@",isSureButton ? @"确定按钮点击":@"取消按钮点击");
    };
    [_pickView bl_show];
    ```
2.实现数据源代理的相关方法提供数据

```
-(NSInteger)bl_numberOfComponentsInPickerView:(UIPickerView *)pickerView{
}

-(NSInteger)bl_pickerView:(UIPickerView *)pickerView
   numberOfRowsInComponent:(NSInteger)component{
}

-(NSString *)bl_pickerView:(UIPickerView *)pickerView
                titleForRow:(NSInteger)row
               forComponent:(NSInteger)component{
}

-(CGFloat)bl_pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
}

-(void)bl_pickerView:(UIPickerView *)pickerView
         didSelectRow:(NSInteger)row
          inComponent:(NSInteger)component{
}
```
