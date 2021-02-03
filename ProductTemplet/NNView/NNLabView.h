//
//  NNLabView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//
 
#import <UIKit/UIKit.h>

@interface NNLabView : UIView

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSNumber * type;

@property (nonatomic, copy) void(^BlockView)(NNLabView *view);

@end
