//
//  UITableViewDateRangeCell.h
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

/**
 时间选择(开始-截止)
 */
@interface UITableViewDateRangeCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) BN_TextField * textFieldLeft;
@property (nonatomic, strong) BN_TextField * textFieldRight;

@property (nonatomic, strong) void(^block)(UITableViewDateRangeCell *view, NSString * dateStart, NSString * dateEnd, id obj, NSInteger idx);

@end
