//
//  BN_LabView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_LabView : UIView

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSNumber * patternType;

@property (nonatomic, copy) void(^BlockView)(BN_LabView *view);

@end
