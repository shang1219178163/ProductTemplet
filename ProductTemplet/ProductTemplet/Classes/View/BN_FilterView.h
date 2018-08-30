//
//  BN_RightView.h
//  BN_CollectionView
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BN_FilterView : UIView

+(instancetype)shared;

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray * dataList;

@property (nonatomic, strong) NSNumber * direction;
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, copy) void (^block)(BN_FilterView * view,NSIndexPath * indexPath, NSInteger idx);

- (void)show;
- (void)dismiss;

@end
