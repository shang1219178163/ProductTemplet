//
//  WHKTableViewNinetyCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/6/19.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface WHKTableViewNinetyCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) BN_TextField * textFieldLeft;
@property (nonatomic, strong) BN_TextField * textFieldRight;

@property (nonatomic, strong) void(^block)(WHKTableViewNinetyCell *view, NSString * dateStart, NSString * dateEnd, id obj, NSInteger idx);

@end
