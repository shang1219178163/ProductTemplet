//
//  BN_RefreshHeader.h
//  RefreshAnimation
//
//  Created by hsf on 2018/5/15.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

/**
 自定义的下拉刷新控件
 */


#import <UIKit/UIKit.h>

@class BN_RefreshHeader;

typedef void (^RefreshBlock)(BN_RefreshHeader *view,NSInteger state);

static NSString *FM_Refresh_foot_normal_title  = @"下拉刷新";
static NSString *FM_Refresh_foot_pulling_title  = @"释放刷新";
static NSString *FM_Refresh_foot_Refreshing_title  = @"正在刷新...";

@interface BN_RefreshHeader : UIView

@property (nonatomic,strong) UIImageView *refImgView;
@property (nonatomic,strong) UILabel *refLabel;

@property (nonatomic,copy) RefreshBlock block;;

- (void)endRefreshing;

@end
