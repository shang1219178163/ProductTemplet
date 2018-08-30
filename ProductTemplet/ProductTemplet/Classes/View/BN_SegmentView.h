//
//  BN_SegmentView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/3/29.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

/*
 类似tabBar
 */

#import <UIKit/UIKit.h>

static NSString *const BN_ItemTitle        = @"BN_ItemTitle";
static NSString *const BN_ItemTitleColor_N = @"BN_ItemTitleColor_N";
static NSString *const BN_ItemTitleColor_H = @"BN_ItemTitleColor_H";
static NSString *const BN_ItemImage_N      = @"BN_ItemImage_N";
static NSString *const BN_ItemImage_H      = @"BN_ItemImage_H";
static NSString *const BN_ItemControlName  = @"BN_ItemControlName";
static NSString *const BN_ItemSelected     = @"BN_ItemSelected";

@interface BN_SegmentView : UIView

@property (nonatomic, strong, readonly) NSArray *items;
@property (nonatomic, assign) NSInteger selectedIndex;

+ (instancetype)viewWithRect:(CGRect)frame items:(NSArray *)items type:(NSNumber *)type;

@end
