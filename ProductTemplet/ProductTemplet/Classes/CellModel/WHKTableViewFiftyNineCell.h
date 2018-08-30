//
//  WHKTableViewFiftyNineCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/6/22.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BN_AlertViewOne.h"

@interface WHKTableViewFiftyNineCell : UITableViewCell

@property (nonatomic, strong) NSDictionary * dic;
@property (nonatomic, strong) void(^block)(WHKTableViewFiftyNineCell *view, NSString * string, NSIndexPath * indexPath);

@end
