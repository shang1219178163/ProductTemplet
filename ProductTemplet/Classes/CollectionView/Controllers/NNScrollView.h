//
//  NNScrollView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NNGloble/NNGloble.h>

NS_ASSUME_NONNULL_BEGIN

//typedef UICollectionViewCell *_Nullable(^BlockCellForItem)(UICollectionView *collectionView, NSIndexPath *indexPath);
//typedef void(^BlockDidSelectItem)(UICollectionView *collectionView, NSIndexPath *indexPath);

@interface NNScrollView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UICollectionViewFlowLayout *layout;

@property(nonatomic, strong) NSMutableArray *list;
@property(nonatomic, assign) NSInteger showItemNum;
@property(nonatomic, assign) NSInteger indicatorType;
@property(nonatomic, assign) CGFloat indicatorHeight UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, readonly) NSIndexPath *selectIndexPath;

@property(nonatomic, copy) BlockCellForItem blockCellForItem;
@property(nonatomic, copy) BlockDidSelectItem blockDidSelectItem;

@end

NS_ASSUME_NONNULL_END
