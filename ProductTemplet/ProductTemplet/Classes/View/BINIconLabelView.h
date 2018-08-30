//
//  BINIconLabelView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/9/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//
/**
 推荐使用BINImgLabelView,此视图已被弃用
 */

#import <UIKit/UIKit.h>

@interface BINIconLabelView : UIView

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * labelTitle;


/**
 (弃用)
 */
+ (BINIconLabelView *)labWithImage:(id)image;

@end
