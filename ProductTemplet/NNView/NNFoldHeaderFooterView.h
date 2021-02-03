//
//  NNFoldHeaderFooterView.h
//  ChildViewControllers
//
//  Created by BIN on 2017/11/6.
//  Copyright © 2017年 BIN. All rights reserved.
//

/*
 
 */

#import <UIKit/UIKit.h>
 
#import "NNHeaderFooterView.h"

@class NNFoldHeaderFooterView;
@protocol NNFoldHeaderFooterViewDelegate <NSObject>

- (void)foldHeaderFooterView:(NNFoldHeaderFooterView *)foldView section:(NSInteger)section;

@end

@interface NNFoldHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView * imgViewArrow;
@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UILabel * labelTitle;
@property (nonatomic, strong) UILabel * labelTitleSub;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL iscanOPen;

@property (nonatomic, assign) NSInteger section;/**< 选中的section */
@property (nonatomic, weak) id<NNFoldHeaderFooterViewDelegate> delegate;/**< 代理 */

- (void)foldViewWithTitle:(NSString *)title image:(id)image section:(NSInteger)section isOpen:(BOOL)isOpen isHeader:(BOOL)isHeader type:(NSNumber *)type;

@property (nonatomic, copy) void (^block)(NNFoldHeaderFooterView *foldView,NSInteger index);;

@end



