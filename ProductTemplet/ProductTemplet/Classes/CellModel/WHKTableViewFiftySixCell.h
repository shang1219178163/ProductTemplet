//
//  WHKTableViewFiftySixCell.h
//  HuiZhuBang
//
//  Created by BIN on 2018/3/26.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface WHKTableViewFiftySixCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSString * string;

@property (nonatomic, strong) void(^block)(WHKTableViewFiftySixCell *view, NSString * string);


@end
