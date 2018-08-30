//
//  BN_PickerViewAddress.h
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
     
     BN_PickerViewAddress * pickerView = [BN_PickerViewAddress pickerViewCancelBtnTitle:@"取消" confirmBtnTitle:@"确定"];
     pickerView.title = @"请选择";
     pickerView.tag = tag;
     
     [pickerView actionSelectAddress:@"内蒙古自治区 呼和浩特市 回民区"];
     [self.view addSubview:pickerView];
     
     [pickerView show];
     pickerView.block = ^(UIPickerView *pickerView, NSString *address, NSInteger btnIndex) {
         DDLog(@"BN_PickerView_%@_%ld",address,(long)btnIndex);
         if (btnIndex == 1) {
         
         
     }
     };
 }
 */


#import <UIKit/UIKit.h>

#define kString_Separate @" "

/**
 代码块传值

 @param pickerView pickerView
 @param address 点击确定返回的地址信息,标准格式:@"内蒙古自治区 呼和浩特市 回民区"
 @param btnIndex 0取消,1确定
 */

@interface BN_PickerViewAddress : UIView

@property (nonatomic, copy) void(^block)(UIPickerView *pickerView, NSString * address,NSInteger btnIndex);

@property (nonatomic, strong) NSString *title;

/**
 返回省份 地区 城市 三级地址

 @param cancelBtnTitle @"取消"
 @param confirmBtnTitle @"确定"
 @return BN_PickerViewAddress
 */
+(BN_PickerViewAddress *)pickerViewCancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString *)confirmBtnTitle;

/**
 传入之前选择的地址(不要做字符处理)
 @param address 标准格式:@"内蒙古自治区 呼和浩特市 回民区"
 */
- (void)actionSelectAddress:(NSString *)address;

- (void)show;
- (void)dismissPickerView;

@end
