//
//  UICTViewLayoutFive.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICTViewLayoutFive.h"
#import <NNGloble/NNGloble.h>

#define ACTIVE_DISTANCE 200
#define kScale_zoom 0.4

@implementation UICTViewLayoutFive

- (instancetype)init{
    self = [super init];
    if (self) {
        CGFloat width = CGRectGetWidth(self.collectionView.frame);

        self.itemSize = CGSizeMake(180, 180);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //  确定了缩进，此处为上方、下方各缩进200
        
        CGFloat gapX = (width - self.itemSize.width)/2.0;
        self.sectionInset = UIEdgeInsetsMake(self.itemSize.width, gapX, self.itemSize.height, gapX);
        //  每个item在水平方向的最小间距
        self.minimumLineSpacing = self.itemSize.height/4;
        
    }
    return self;
}

//  初始的layout外观将由该方法返回的UICollctionViewLayoutAttributes来决定
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                CGFloat zoom = 1 + kScale_zoom*(1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
    }
    return array;
}

//  自动对齐到网格
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //  proposedContentOffset是没有对齐到网格时本来应该停下来的位置
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    //  当前显示的区域
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    //  取当前显示的item
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    //  对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds{
    return YES;
}

@end

