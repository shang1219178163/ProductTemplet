//
//  UICTViewLayoutOne.h
//  BNCollectionView
//
//  Created by BIN on 2018/4/17.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 自定义实现系统flow布局
@interface UICTViewLayoutOne : UICollectionViewLayout

@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGSize headerReferenceSize;
@property (nonatomic, assign) CGSize footerReferenceSize;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@end
 
