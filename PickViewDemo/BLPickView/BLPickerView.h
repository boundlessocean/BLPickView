//
//  BLPickView.h
//  AreaPicker
//
//  Created by boundlessocean on 2016/11/22.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLPickerViewDataSource <NSObject>
@required
// 显示少组
- (NSInteger)bl_numberOfComponentsInPickerView:(nullable UIPickerView *)pickerView;

// 哪一组有多少行
- (NSInteger)bl_pickerView:(nullable UIPickerView *)pickerView
   numberOfRowsInComponent:(NSInteger)component;
@end

@protocol BLPickerViewDelegate <NSObject>
@optional
// 哪一组有多宽
- (CGFloat)bl_pickerView:(nullable UIPickerView *)pickerView
       widthForComponent:(NSInteger)component;

// 哪一组的哪一行有多高
- (CGFloat)bl_pickerView:(nullable UIPickerView *)pickerView
   rowHeightForComponent:(NSInteger)component;

// 哪一组的哪一行显示什么标题
- (nullable NSString *)bl_pickerView:(nullable UIPickerView *)pickerView
                         titleForRow:(NSInteger)row
                        forComponent:(NSInteger)component;

// 哪一组的哪一行显示什么标题（attributed）
- (nullable NSAttributedString *)bl_pickerView:(nullable UIPickerView *)pickerView
                         attributedTitleForRow:(NSInteger)row
                                  forComponent:(NSInteger)component;

// 哪一组的哪一行显示什么视图
- (nullable UIView *)bl_pickerView:(nullable UIPickerView *)pickerView
                        viewForRow:(NSInteger)row
                      forComponent:(NSInteger)component
                       reusingView:(nullable UIView *)view ;

// 选中了哪一组的哪一行
- (void)bl_pickerView:(nullable UIPickerView *)pickerView
         didSelectRow:(NSInteger)row
          inComponent:(NSInteger)component;

@end

typedef void(^BLPickViewButtonClickedBlock)(BOOL isSureButtonClicked);

@interface BLPickerView : UIView

/** pickView */
@property (nonatomic, strong, nullable, readonly) UIPickerView *pickView;
/** 顶部视图 */
@property (nonatomic, strong, nullable) UIView *topView;
/** 取消按钮 */
@property (nonatomic, strong, nullable) UIButton *cancelButton;
/** 确定按钮 */
@property (nonatomic, strong, nullable) UIButton *sureButton;

/** pickerView 每行标题大小 */
@property (nonatomic, strong, nullable)UIFont  *titleFont;
/** pickerView 背景颜色 */
@property (nonatomic, strong, nullable)UIColor *pickViewBackgroundColor;
/** pickerView父视图（半透明视图）透明度 */
@property (nonatomic, assign)CGFloat alphaValue;


/** 按钮点击回调block */
@property (nonatomic, copy, nullable) BLPickViewButtonClickedBlock buttonClickedBlock;

/** 选择器代理 */
@property (nonatomic, weak, nullable) id<BLPickerViewDelegate> pickViewDelegate;
/** 选择器数据源 */
@property (nonatomic, weak, nullable) id<BLPickerViewDataSource> pickViewDataSource;

/** 显示选择器 */
- (void)bl_show;

@end
