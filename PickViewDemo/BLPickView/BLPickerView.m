//
//  BLPickView.m
//  AreaPicker
//
//  Created by boundlessocean on 2016/11/22.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import "BLPickerView.h"

@interface BLPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

/** pickView */
@property (nonatomic, strong, nullable) UIPickerView *pickView;
@end

static const CGFloat topViewHeight = 30;
static const CGFloat buttonWidth = 60;
static const CGFloat animationDuration = 0.3;
#define BL_ScreenW  [[UIScreen mainScreen] bounds].size.width
#define BL_ScreenH  [[UIScreen mainScreen] bounds].size.height

@implementation BLPickerView
{
    CGRect _pickViewFrame;
}

#pragma mark - - load
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self bl_initData:frame];
        [self bl_initSubviews];
    }
    return self;
}

/** 初始化子视图 */
- (void)bl_initSubviews{
    
    [self addSubview:self.topView];
    [self addSubview:self.pickView];
    [self.topView addSubview:self.cancelButton];
    [self.topView addSubview:self.sureButton];
}

/** 初始化数据 */
- (void)bl_initData:(CGRect)frame{
    _pickViewFrame = frame;
    
    self.frame = CGRectMake(0, 0, BL_ScreenW, BL_ScreenH);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}

#pragma mark - - get
- (UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), BL_ScreenW, _pickViewFrame.size.height)];
        _pickView.dataSource = self;
        _pickView.delegate = self;
        _pickView.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
    }
    return _pickView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, BL_ScreenH, BL_ScreenW, topViewHeight)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 0, buttonWidth, topViewHeight);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(self.frame.size.width - buttonWidth, 0, buttonWidth, topViewHeight);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sureButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_sureButton addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

#pragma mark - - set

- (void)setPickViewBackgroundColor:(UIColor *)pickViewBackgroundColor{
    self.pickView.backgroundColor = pickViewBackgroundColor;
}

- (void)setAlphaValue:(CGFloat)alphaValue{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alphaValue];
}

#pragma mark - show,dismiss

- (void)bl_show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect tempRect = _topView.frame;
        tempRect.origin.y = BL_ScreenH - topViewHeight - _pickViewFrame.size.height;
        _topView.frame = tempRect;
        tempRect = _pickViewFrame;
        tempRect.origin.y = CGRectGetMaxY(_topView.frame);
        _pickView.frame = tempRect;
    }];
}

- (void)bl_dismiss{
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect tempRect = _topView.frame;
        tempRect.origin.y = BL_ScreenH;
        _topView.frame = tempRect;
        tempRect = _pickViewFrame;
        tempRect.origin.y = CGRectGetMaxY(_topView.frame);
        _pickView.frame = tempRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

#pragma mark - - Button Action
- (void)cancelButtonClicked:(UIButton *)sender{
    
    !_buttonClickedBlock ? : _buttonClickedBlock(NO);
    [self bl_dismiss];
}

- (void)sureButtonClicked:(UIButton *)sender{
    
    !_buttonClickedBlock ? : _buttonClickedBlock(YES);
    [self bl_dismiss];
}

#pragma mark - - UIPickerViewDelegate,UIPickerViewDataSource

// 显示少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.pickViewDataSource &&
        [self.pickViewDataSource respondsToSelector:@selector(bl_numberOfComponentsInPickerView:)]) {
        return [self.pickViewDataSource bl_numberOfComponentsInPickerView:pickerView];
    }else{
        return 0;
    }
}

// 哪一组有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.pickViewDataSource &&
        [self.pickViewDataSource respondsToSelector:@selector(bl_pickerView:numberOfRowsInComponent:)]) {
        return [self.pickViewDataSource bl_pickerView:pickerView
                              numberOfRowsInComponent:component];
    }else{
        return 0;
    }
}

// 哪一组的哪一行显示什么标题
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    
    if (self.pickViewDelegate &&
        [self.pickViewDelegate respondsToSelector:@selector(bl_pickerView: titleForRow: forComponent:)]) {
        return [self.pickViewDelegate bl_pickerView:pickerView
                                        titleForRow:row
                                       forComponent:component];
    }else{
        return @"";
    }
}

// 哪一组的哪一行显示什么标题（attributed）
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView
             attributedTitleForRow:(NSInteger)row
                      forComponent:(NSInteger)component{
    if (self.pickViewDelegate &&
        [self.pickViewDelegate respondsToSelector:@selector(bl_pickerView:attributedTitleForRow:forComponent:)]) {
        return [self.pickViewDelegate bl_pickerView:pickerView
                              attributedTitleForRow:row
                                       forComponent:component];
    }else{
        return [[NSAttributedString alloc] init];
    }
}

// 选中了哪一组的哪一行
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    if (self.pickViewDelegate &&
        [self.pickViewDelegate respondsToSelector:@selector(bl_pickerView: didSelectRow:inComponent:)]) {
        [self.pickViewDelegate bl_pickerView:pickerView
                                didSelectRow:row
                                 inComponent:component];
    }
}

// 哪一组有多宽
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.pickViewDelegate &&
        [self.pickViewDelegate respondsToSelector:@selector(bl_pickerView:widthForComponent:)]) {
        return [self.pickViewDelegate bl_pickerView:pickerView widthForComponent:component];
    }else{
        return BL_ScreenW;
    }
}

// 哪一组的哪一行有多高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    if (self.pickViewDelegate &&
        [self.pickViewDelegate respondsToSelector:@selector(bl_pickerView:rowHeightForComponent:)]) {
        return [self.pickViewDelegate bl_pickerView:pickerView rowHeightForComponent:component];
    }else{
        return 30;
    }
}

// 哪一组的哪一行显示什么视图
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view{
    
    if (self.pickViewDelegate &&
        [self.pickViewDelegate respondsToSelector:@selector(bl_pickerView:viewForRow:forComponent:reusingView:)]) {
        return [self.pickViewDelegate bl_pickerView:pickerView
                                  viewForRow:row
                                forComponent:component
                                 reusingView:view];
    }else{
        UILabel* pickerLabel = (UILabel*)view;
        if (!pickerLabel){
            pickerLabel = [[UILabel alloc] init];
            pickerLabel.adjustsFontSizeToFitWidth = YES;
            [pickerLabel setTextAlignment:NSTextAlignmentCenter];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            [pickerLabel setFont:_titleFont ? _titleFont : [UIFont systemFontOfSize:14]];
        }
        pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        return pickerLabel;
    }
}



@end
