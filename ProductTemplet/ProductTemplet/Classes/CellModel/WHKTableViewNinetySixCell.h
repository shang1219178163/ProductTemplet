//
//  WHKTableViewNinetySixCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/6/27.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BN_AlertViewOne.h"

@interface WHKTableViewNinetySixCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NSDictionary * dic;

@property (nonatomic, strong) BN_AlertViewOne * alertView;
@property (nonatomic, strong) void(^block)(WHKTableViewNinetySixCell *view,BN_AlertViewOne * alertView, id obj, NSArray * keys, NSIndexPath * indexPath);


@end
