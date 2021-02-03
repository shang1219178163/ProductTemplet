//
//  NNGroupViewZero.h
//  BINAlertView
//
//  Created by BIN on 2018/3/23.
//  Copyright © 2018年 SouFun. All rights reserved.
//

/*
 子视图为button
 */
 
#import <UIKit/UIKit.h>

@class NNGroupViewZero;

typedef void (^NNGroupViewZeroBlock)(NNGroupViewZero * groupView, id selectedItems, NSString *title, BOOL isOnlyOne);

@interface NNGroupViewZero : UIView

@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) NSArray * chooseList;

@property (nonatomic, strong) UIColor * colorBackNormal;
@property (nonatomic, strong) UIColor * colorBackSelected;

@property (nonatomic, assign) BOOL isOnlyOne;

@property (nonatomic, copy) NNGroupViewZeroBlock viewBlock;

- (id)initRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

+ (NNGroupViewZero *)viewRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList;

@end
