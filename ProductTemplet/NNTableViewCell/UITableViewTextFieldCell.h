//
//  UITableViewTextFieldCell.h
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"

/**
 NNTextField
 */
@interface UITableViewTextFieldCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, assign) BOOL hasAsterisk;

@property (nonatomic, strong) void(^block)(UITableViewTextFieldCell *view, UITextField * textField);

@end


