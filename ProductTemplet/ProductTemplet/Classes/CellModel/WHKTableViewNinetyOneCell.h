//
//  WHKTableViewNinetyOneCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/6/19.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface WHKTableViewNinetyOneCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSString * string;

@property (nonatomic, strong) void(^block)(WHKTableViewNinetyOneCell *view, NSString * strLeft, NSString * strRight);

@end
