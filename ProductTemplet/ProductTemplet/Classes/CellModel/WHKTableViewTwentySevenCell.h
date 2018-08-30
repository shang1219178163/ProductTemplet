//
//  WHKTableViewTwentySevenCell.h
//  HuiZhuBang
//
//  Created by BIN on 2017/9/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BINImgLabelView.h"
#import "XHStarRateView.h"

@interface WHKTableViewTwentySevenCell : UITableViewCell

@property (nonatomic, strong) UIImageView * imgViewLeft;

@property (nonatomic, strong) UILabel * labelName;
@property (nonatomic, strong) UILabel * labelPrice;
@property (nonatomic, strong) UILabel * labelIntegrityLevel;

@property (nonatomic, strong) UIButton * btnCall;
@property (nonatomic, strong) UIButton * btnConfirm;

@property (nonatomic, strong) BINImgLabelView * imgLabView;
@property (nonatomic, strong) XHStarRateView * starsView;

@property (nonatomic, strong) UIView * lineVert;

@property (nonatomic, strong) UIView * lineTop;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
