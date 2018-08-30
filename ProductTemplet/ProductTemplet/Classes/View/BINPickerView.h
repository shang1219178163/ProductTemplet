//
//  BINPickerView.h
//  BINView
//
//  Created by BIN on 2017/9/12.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>
//浅层PickerView封装

@interface BINPickerView : UIPickerView

@property (nonatomic, copy) void(^block)(UIPickerView *pickerView,NSInteger index);;

@property (nonatomic, strong) NSString *title;

-(instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString *)confirmBtnTitle;

- (void)show;
- (void)dismissPickerView;

@end
