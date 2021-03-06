//
//  UITableViewPickerListCell.h
//  Utilis
//
//  Created by BIN on 2018/10/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "NNAlertViewOne.h"

/**
 列表选择(弹窗方式)
 */
@interface UITableViewPickerListCell : UITableViewCell<UITextFieldDelegate>
 
@property (nonatomic, strong) NSDictionary * dic;
@property (nonatomic, strong) NNAlertViewOne * alertView;

@property (nonatomic, strong) void(^block)(UITableViewPickerListCell *view, NNAlertViewOne * alertView, id obj, NSArray * keys, NSIndexPath * indexP);

@end

