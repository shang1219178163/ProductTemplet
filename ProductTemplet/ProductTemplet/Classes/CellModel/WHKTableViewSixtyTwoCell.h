//
//  WHKTableViewSixtyTwoCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/2.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface WHKTableViewSixtyTwoCell : UITableViewCell

@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, strong) void(^block)(WHKTableViewSixtyTwoCell *view, UITextView * textView);

@end
