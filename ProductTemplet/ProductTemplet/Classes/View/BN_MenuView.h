//
//  BN_MenuView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/16.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_MenuView : UIView

//@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSArray * dataList;

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^block)(BN_MenuView * view, NSIndexPath * indexPath);

- (void)show;
- (void)dismiss;


@end
