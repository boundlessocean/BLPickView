//
//  ViewController.m
//  PickViewDemo
//
//  Created by boundlessocean on 2016/11/22.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import "ViewController.h"
#import "BLPickerView.h"
@interface ViewController ()<BLPickerViewDelegate, BLPickerViewDataSource>

@property (nonatomic, strong) UITextField *f1;
@property (nonatomic, strong) BLPickerView *pickView;

@end
@implementation ViewController
{
    NSArray *_testDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    _f1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _f1.placeholder = @"性别";
    _f1.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:_f1];
    
    _testDataArray = @[@"男",@"女"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _pickView = [[BLPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    _pickView.pickViewDelegate = self;
    _pickView.pickViewDataSource = self;
    _pickView.buttonClickedBlock = ^(BOOL isSureButton){
        NSLog(@"%@",isSureButton ? @"确定按钮点击":@"取消按钮点击");
    };
    [_pickView bl_show];
}

#pragma mark - - BLPickerViewDelegate, BLPickerViewDataSource

- (NSInteger)bl_numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)bl_pickerView:(UIPickerView *)pickerView
   numberOfRowsInComponent:(NSInteger)component{
    return _testDataArray.count;
}

- (NSString *)bl_pickerView:(UIPickerView *)pickerView
                titleForRow:(NSInteger)row
               forComponent:(NSInteger)component{
    return _testDataArray[row];
}

- (CGFloat)bl_pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.view.frame.size.width/3;
}

- (void)bl_pickerView:(UIPickerView *)pickerView
         didSelectRow:(NSInteger)row
          inComponent:(NSInteger)component{
    _f1.text = [_testDataArray objectAtIndex:row];
}
@end
