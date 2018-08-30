//
//  UITableViewHeaderFooterView+AddView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/8/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (AddView)

@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;

@property (nonatomic, strong) UIImageView * viewIndicator;
@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UIImageView * imgViewRight;

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelLeftMark;
@property (nonatomic, strong) UILabel * labelLeftSub;
@property (nonatomic, strong) UILabel * labelLeftSubMark;

@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isCanOPen;//默认为NO

@property (nonatomic, copy) void (^blockView)(UITableViewHeaderFooterView *foldView,NSInteger index);

+(instancetype)viewWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
+(instancetype)viewWithTableView:(UITableView *)tableView;

@end
