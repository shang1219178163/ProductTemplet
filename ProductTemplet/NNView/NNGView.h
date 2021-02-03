//
//  NNGView.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//
 
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const kGviewItems ;
FOUNDATION_EXPORT NSString * const kGviewNumberOfRow ;
FOUNDATION_EXPORT NSString * const kGviewItemHeight ;
FOUNDATION_EXPORT NSString * const kGviewPadding ;
FOUNDATION_EXPORT NSString * const kGviewType ;
FOUNDATION_EXPORT NSString * const kGviewIsSingle ;
FOUNDATION_EXPORT NSString * const kGviewItemsSelected ;

@interface NNGView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, strong) NSMutableArray *selectedList;

@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, copy) void(^block)(NNGView *view, id item, NSInteger idx);

+ (instancetype)viewRect:(CGRect)rect params:(NSDictionary *)params;

@end
