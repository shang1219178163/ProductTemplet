//
//  UICTViewLayoutCard.m
//  NNCollectionView
//
//  Created by hsf on 2018/8/9.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICTViewLayoutCard.h"
#import <NNGloble/NNGloble.h>

@interface UICTViewLayoutCard ()

@property(nonatomic, assign) NSInteger itemsCount;

@end

@implementation UICTViewLayoutCard

-(void)prepareLayout {
    [super prepareLayout];
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    
    _itemsCount = [self.collectionView numberOfItemsInSection:0];
    self.minimumInteritemSpacing = self.minimumInteritemSpacing > 0.0 ? self.minimumInteritemSpacing : 5;
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, self.sectionInset)) {
        self.sectionInset = UIEdgeInsetsMake(0, (width - self.itemSize.width) / 2, 0, (width - self.itemSize.width) / 2);

    }
}

-(void)collectionViewTapped:(UIGestureRecognizer*)recognizer {
    CGPoint location = [recognizer locationInView:self.collectionView];
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    if(indexPath == nil)
        return ;
    
    if(_currentItemIndex == indexPath.item) {
        if([self.collectionView.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)])
            [self.collectionView.delegate collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }
    else {
        _currentItemIndex = indexPath.item;
        [self.collectionView setContentOffset:CGPointMake(indexPath.item * (self.minimumInteritemSpacing + self.itemSize.width), 0) animated:YES];
        
        if([self.delegate respondsToSelector:@selector(scrolledToTheCurrentItemAtIndex:)])
            [self.delegate scrolledToTheCurrentItemAtIndex:_currentItemIndex];
    }
    
    return ;
}

-(void)scrollToItemAtIndex:(NSInteger)itemIndex {
    _currentItemIndex = itemIndex;
    
    [self.collectionView setContentOffset:CGPointMake(_currentItemIndex * (self.minimumInteritemSpacing + self.itemSize.width), 0) animated:YES];
    
    if([self.delegate respondsToSelector:@selector(scrolledToTheCurrentItemAtIndex:)])
        [self.delegate scrolledToTheCurrentItemAtIndex:itemIndex];
}

-(CGSize)collectionViewContentSize {
    CGFloat contentWidth = self.sectionInset.left + self.sectionInset.right + _itemsCount * self.itemSize.width + (_itemsCount - 1) * self.minimumInteritemSpacing;
    CGFloat contentHeight = self.sectionInset.top + self.sectionInset.bottom + self.collectionView.frame.size.height;
    return CGSizeMake(contentWidth, contentHeight);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attr.size = self.itemSize;
    attr.frame = CGRectMake((int)indexPath.row * (self.itemSize.width + self.minimumInteritemSpacing) + self.sectionInset.left, (self.collectionView.bounds.size.height - self.itemSize.height) / 2 + self.sectionInset.top, attr.size.width, attr.size.height);
    
    return attr;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* attributes = [NSMutableArray array];
    
    CGRect visiableRect = CGRectMake(self.collectionView.contentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    CGFloat centerX = self.collectionView.contentOffset.x + [UIScreen mainScreen].bounds.size.width / 2;
    
    for (NSInteger i=0 ; i < _itemsCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes* attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attr];
        
        if(CGRectIntersectsRect(attr.frame, visiableRect) == false)
            continue ;
        CGFloat xOffset = fabs(attr.center.x - centerX);
        
        CGFloat scale = 1 - (xOffset * (1 - _scale)) / (([UIScreen mainScreen].bounds.size.width + self.itemSize.width) / 2 - self.minimumInteritemSpacing);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
    return CGPointMake(3 * (self.itemSize.width + self.minimumInteritemSpacing) + self.sectionInset.left, 0);
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    NSInteger itemIndex = (NSInteger)(self.collectionView.contentOffset.x / (self.itemSize.width + self.minimumInteritemSpacing));
    CGFloat xOffset = itemIndex * (self.minimumInteritemSpacing + self.itemSize.width);
    CGFloat xOffset_1 = (itemIndex + 1) * (self.minimumInteritemSpacing + self.itemSize.width);
    
    if(fabs(proposedContentOffset.x - xOffset) > fabs(xOffset_1 - proposedContentOffset.x)) {
        _currentItemIndex = itemIndex + 1;
        if([self.delegate respondsToSelector:@selector(scrolledToTheCurrentItemAtIndex:)])
            [self.delegate scrolledToTheCurrentItemAtIndex:_currentItemIndex];
        return CGPointMake(xOffset_1, 0);
    }
    
    _currentItemIndex = itemIndex;
    if([self.delegate respondsToSelector:@selector(scrolledToTheCurrentItemAtIndex:)])
        [self.delegate scrolledToTheCurrentItemAtIndex:_currentItemIndex];
    return CGPointMake(xOffset, 0);
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self.collectionView];
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    if(indexPath == nil || indexPath.item == _currentItemIndex)
        return NO;
    return YES;
}

@end
