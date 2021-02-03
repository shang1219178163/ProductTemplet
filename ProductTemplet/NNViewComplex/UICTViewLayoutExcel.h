//
//  UICTViewLayoutExcel.h
//  NNCollectionView
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICTViewLayoutExcel : UICollectionViewFlowLayout

@property (nonatomic, strong) NSMutableArray *columnWidths;//每列的实际宽度数组

@property (nonatomic, assign) NSUInteger columnCount;

@property (nonatomic, assign) NSInteger lockColumn;//锁定列数
@property (nonatomic, assign) CGFloat itemHeight;//每行item高度

//重置每一个item的大小和布局
- (void)reset;

@end
