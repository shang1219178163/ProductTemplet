//
//  UITableViewDateRangeCell.h
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "NNDateRangeView.h"

/**
 时间选择(开始-截止)
 */
@interface UITableViewDateRangeCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, assign) BOOL hasAsterisk;

@property (nonatomic, strong) NNDateRangeView * dateRangeView;

@end
