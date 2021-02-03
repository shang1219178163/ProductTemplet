//
//  NNCycleCollectionView.h
//  CollectionViewDemo1
//
//  Created by BIN on 2018/11/5.
//  Copyright © 2018年 com.elepphant.pingchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UICollectionView循环旋转
 */ 
@interface NNCycleCTView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) NSArray *imgList;

@end

