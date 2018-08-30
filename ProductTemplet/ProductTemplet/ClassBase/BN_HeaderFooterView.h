//
//  BN_HeaderFooterView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/2.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

/*
 UITableViewHeaderFooterView根类
 
 */

#import <UIKit/UIKit.h>

@class FoldSectionModel;
@class BN_HeaderFooterView;

@interface BN_HeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;

@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, copy) void (^blockView)(BN_HeaderFooterView *foldView,NSInteger index);

+(instancetype)viewWithTableView:(UITableView *)tableView;

@end


//折叠数据模型
@interface FoldSectionModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * titleSub;

@property (nonatomic, strong) id image;

@property (nonatomic, strong) NSMutableArray * dataList;

@property (nonatomic, assign) BOOL isOpen;

@end
