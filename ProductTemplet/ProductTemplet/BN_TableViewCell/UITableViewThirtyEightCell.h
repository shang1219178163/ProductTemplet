//
//  UITableViewThirtyEightCell.h
//  
//
//  Created by BIN on 2017/11/13.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BN_ImgLabelView.h"

/**
 ----------------------------
 文字
 BTN    图片+文字          + 文字
 图片+文字
 ----------------------------
 */
@interface UITableViewThirtyEightCell : UITableViewCell

@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, strong) UILabel * labTitle;
@property (nonatomic, strong) UILabel * labRight;

@property (nonatomic, strong) BN_ImgLabelView * imgLabViewOne;
@property (nonatomic, strong) BN_ImgLabelView * imgLabViewTwo;

@property (nonatomic, copy) void (^block)(UITableViewThirtyEightCell *cell, UIButton *sender);


@end
