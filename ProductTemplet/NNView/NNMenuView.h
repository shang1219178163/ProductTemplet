//
//  NNMenuView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/16.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//
 
#import <UIKit/UIKit.h>

@interface NNMenuView : UIView

//@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSArray * dataList;

/// 菜单相对屏幕顶部的偏移（遮罩与列表从此处开始展开），默认 64。
@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^block)(NNMenuView * view, NSIndexPath * indexPath);

- (void)show;
- (void)dismiss;


@end
