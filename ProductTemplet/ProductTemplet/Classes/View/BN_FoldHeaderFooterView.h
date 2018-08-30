//
//  BN_FoldHeaderFooterView.h
//  ChildViewControllers
//
//  Created by BIN on 2017/11/6.
//  Copyright © 2017年 BIN. All rights reserved.
//

/*
 (弃用)
 */

#import <UIKit/UIKit.h>

#import "BN_HeaderFooterView.h"

@class BN_FoldHeaderFooterView;
@protocol BINFoldHeaderFooterViewDelegate <NSObject>

- (void)foldHeaderFooterView:(BN_FoldHeaderFooterView *)foldView section:(NSInteger)section;

@end

@interface BN_FoldHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView * imgViewArrow;
@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UILabel * labelTitle;
@property (nonatomic, strong) UILabel * labelTitleSub;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL iscanOPen;

@property (nonatomic, assign) NSInteger section;/**< 选中的section */
@property (nonatomic, weak) id<BINFoldHeaderFooterViewDelegate> delegate;/**< 代理 */

- (void)foldViewWithTitle:(NSString *)title image:(id)image section:(NSInteger)section isOpen:(BOOL)isOpen isHeader:(BOOL)isHeader patternType:(NSString *)patternType;

@property (nonatomic, copy) void (^block)(BN_FoldHeaderFooterView *foldView,NSInteger index);;

+(instancetype)viewWithTableView:(UITableView *)tableView section:(NSInteger)section;
+(instancetype)viewWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
+(instancetype)viewWithTableView:(UITableView *)tableView;

@end



