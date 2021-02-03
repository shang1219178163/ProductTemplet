//
//  NNRefreshHeader.h
//  RefreshAnimation
//
//  Created by hsf on 2018/5/15.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

/**
 自定义的下拉刷新控件
 */

#import <UIKit/UIKit.h>

@class NNRefreshHeader;

typedef void (^RefreshBlock)(NNRefreshHeader *view,NSInteger state);

FOUNDATION_EXPORT NSString *FM_Refresh_foot_normal_title ;
FOUNDATION_EXPORT NSString *FM_Refresh_foot_pulling_title ;
FOUNDATION_EXPORT NSString *FM_Refresh_foot_Refreshing_title ;

@interface NNRefreshHeader : UIView

@property (nonatomic,strong) UIImageView *refImgView;
@property (nonatomic,strong) UILabel *refLabel;

@property (nonatomic,copy) RefreshBlock block;;

- (void)endRefreshing;

@end
