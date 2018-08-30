//
//  WHKTableViewSixtyCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/3/28.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BN_DatePicker.h"

@interface WHKTableViewSixtyCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSString * dateStr;

@property (nonatomic, strong) BN_DatePicker * datePicker;

@property (nonatomic, strong) void(^block)(WHKTableViewSixtyCell *view, NSString * dateStr);

@end
