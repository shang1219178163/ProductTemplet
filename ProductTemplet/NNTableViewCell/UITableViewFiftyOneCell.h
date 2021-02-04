//
//  UITableViewFiftyOneCell.h
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NNGloble/NNGloble.h>
#import "UITableViewCell+Helper.h"

/**
 文字+textField+textField+textField
 */
@interface UITableViewFiftyOneCell : UITableViewCell

@property (nonatomic, strong) NNTextField * textFieldLeft;
@property (nonatomic, strong) NNTextField * textFieldCenter;
@property (nonatomic, strong) NNTextField * textFieldRight;

@end
