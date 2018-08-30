//
//  BN_RangeView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BN_RangeView;

typedef void (^BlockRangeView)(BN_RangeView * rangeView, NSString * low, NSString * height);
@interface BN_RangeView : UIView

@end
