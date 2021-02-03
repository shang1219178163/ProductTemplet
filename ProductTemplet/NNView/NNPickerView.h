//
//  NNPickerView.h
//  BINView
//
//  Created by BIN on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//
 

#import <UIKit/UIKit.h>

@interface NNPickerView : UIView

@property (nonatomic, strong, readonly) UIPickerView *pickerView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) void(^block)(UIPickerView *pickerView, NSInteger btnIndex);;

- (void)show;
- (void)dismiss;

@end
