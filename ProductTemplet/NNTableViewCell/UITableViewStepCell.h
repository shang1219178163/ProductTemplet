//
//  UITableViewStepCell.h
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "PPNumberButton.h"

/**
 购物车加减商品
 */
@interface UITableViewStepCell : UITableViewCell

@property (nonatomic, assign) BOOL hasAsterisk;

@property (nonatomic, strong) PPNumberButton * ppBtn;

@end

