//
//  NNPickerViewAddress.h
//  picker
//
//  Created by BIN on 2017/11/15.
//  Copyright © 2017年 Sylar. All rights reserved.
//

/**
 //调用
 [self createPickerViewAddress:100];
 
 
 - (void)createPickerViewAddress:(NSInteger)tag{
     [self.view endEditing:YES];
     
     NNPickerViewAddress * pickerView = [NNPickerViewAddress pickerViewCancelBtnTitle:@"取消" confirmBtnTitle:@"确定"];
     pickerView.title = @"请选择";
     pickerView.tag = tag;
     
     [pickerView actionSelectAddress:@"内蒙古自治区 呼和浩特市 回民区"];
     [self.view addSubview:pickerView];
     
     [pickerView show];
     pickerView.block = ^(UIPickerView *pickerView, NSString *address, NSInteger btnIndex) {
         DDLog(@"NNPickerView_%@_%ld",address,(long)btnIndex);
         if (btnIndex == 1) {
         
     }
     };
 }
 */


#import <UIKit/UIKit.h>

#define kString_Separate @" "

@interface NNPickerViewAddress : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) void(^block)(UIPickerView *pickerView, NSString * address,NSInteger btnIndex);

/**
 返回省份 地区 城市 三级地址

 @param cancelTitle @"取消"
 @param confirmTitle @"确定"
 @return NNPickerViewAddress
 */
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle;

/**
 传入之前选择的地址(不要做字符处理)
 @param address 标准格式:@"内蒙古自治区 呼和浩特市 回民区"
 */
- (void)actionSelectAddress:(NSString *)address;

- (void)show;
- (void)dismiss;

@end
