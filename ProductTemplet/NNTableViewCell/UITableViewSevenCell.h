//
//  UITableViewSevenCell.h
//  
//
//  Created by BIN on 2017/8/18.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+Helper.h"
#import "UITableViewCell+AddView.h"

/**
 文字+文字+文字
 文字+文字+文字
 */
@interface UITableViewSevenCell : UITableViewCell

@property (nonatomic, strong) UILabel * labOne;
@property (nonatomic, strong) UILabel * labTwo;
@property (nonatomic, strong) UILabel * labThree;

@property (nonatomic, strong) UILabel * labOneSub;
@property (nonatomic, strong) UILabel * labTwoSub;
@property (nonatomic, strong) UILabel * labThreeSub;

@end
