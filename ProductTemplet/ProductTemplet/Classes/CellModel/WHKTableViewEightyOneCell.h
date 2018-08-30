//
//  WHKTableViewEightyOneCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface WHKTableViewEightyOneCell : UITableViewCell

@property (nonatomic, strong) NSArray *itemManger;

@property (nonatomic, copy) void(^block)(UIImageView * obj, UILabel * item, NSInteger idx);

@end
