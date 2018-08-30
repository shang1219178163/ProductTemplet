//
//  BINSegmentView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/15.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BN_SegmentViewZero;

@interface BN_SegmentViewZero : UIScrollView

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) NSInteger IsSelectIndex;

@property (nonatomic, strong) UIColor * indicatorColor;
@property (nonatomic, strong) UIColor * titleColorSelected;
@property (nonatomic, strong) UIColor * gapLineColor;

@property (nonatomic, strong) NSMutableArray * titleLabels;

@property (nonatomic, copy) void (^block)(BN_SegmentViewZero * view,NSInteger index);

- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)titles titleWidth:(CGFloat)titleWith selectIndex:(NSInteger)selectIndex IsBottom:(BOOL)isBottom;

@end
