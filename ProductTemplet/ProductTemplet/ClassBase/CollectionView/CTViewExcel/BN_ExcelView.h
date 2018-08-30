//
//  BN_ExcelView.h
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

#import "BN_CTViewCellExcel.h"
#import "BN_CTReusableViewZero.h"

#import "BN_CTViewLayoutExcel.h"

#import "BN_CollectionView.h"

static NSString * kExcel_TitleList   = @"kExcel_TitleList";//标题栏
static NSString * kExcel_DataList    = @"kExcel_DataList";//数据源
static NSString * kExcel_WidthList   = @"kExcel_WidthList";//自定义各行宽度
static NSString * kExcel_LockColumn  = @"kExcel_LockColumn";//从左到右锁定几行

@interface BN_ExcelView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) BN_CTViewLayoutExcel *layout;

@property (nonatomic, strong) UILabel *label;
//@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BN_CollectionView *collectionView;
@property (nonatomic, strong, readonly) NSDictionary *dictClass;

@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, copy)  void(^BlockObject)(id obj, id item, NSIndexPath * indexPath);

- (NSArray *)widthByDataList:(NSArray *)dataList longItems:(NSArray *)items itemWidth:(CGFloat)itemWidth;

- (void)reloadData;


@end
