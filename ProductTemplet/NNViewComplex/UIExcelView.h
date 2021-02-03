//
//  UIExcelView.h
//  ChildViewControllers
//
//  Created by hsf on 2018/4/10.
//  Copyright © 2018年 BIN. All rights reserved.
//

/**
控制器需加入下边一行代码
 self.edgesForExtendedLayout = NO;

 */

#import <UIKit/UIKit.h>

#import "UICTViewCellExcel.h"
#import "UICTReusableViewZero.h"
#import "UICTViewLayoutExcel.h"

#import "NNCTView.h"

static NSString * kExcelTitles  = @"kExcelTitles";//标题栏
static NSString * kExcelDatas   = @"kExcelDatas";//数据源
static NSString * kExcelWidths  = @"kExcelWidths";//自定义各行宽度
static NSString * kExcelLockColumn  = @"kExcelLockColumn";//从左到右锁定几行


@interface UIExcelView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICTViewLayoutExcel *layout;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) NSDictionary *dictClass;

@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, copy)  void(^block)(UIExcelView * view, UICTViewCellExcel * cell, NSIndexPath * indexPath);

- (void)reloadData;

- (NSArray *)arrayWithItem:(id)item count:(NSInteger)count;
- (NSArray *)widthByDataList:(NSArray *)dataList longItems:(NSArray *)items itemWidth:(CGFloat)itemWidth;
+ (NSMutableArray *)dataByList:(NSArray *)modelList propertyList:(NSArray *)propertyList;

@end
