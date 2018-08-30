//
//  BN_GView.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kGview_items = @"kGview_items";
static NSString * const kGview_numberOfRow = @"kGview_numberOfRow";
static NSString * const kGview_itemHeight = @"kGview_itemHeight";
static NSString * const kGview_padding = @"kGview_padding";
static NSString * const kGview_type = @"kGview_type";
static NSString * const kGview_isSingle = @"kGview_isSingle";
static NSString * const kGview_itemsSelected = @"kGview_itemsSelected";

@interface BN_GView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, strong) NSMutableArray * selectedList;

@property (nonatomic, strong) NSDictionary * params;
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, copy) void(^block)(BN_GView * view, id item, NSInteger idx);

+ (instancetype)viewWithRect:(CGRect)rect params:(NSDictionary *)params;

@end
