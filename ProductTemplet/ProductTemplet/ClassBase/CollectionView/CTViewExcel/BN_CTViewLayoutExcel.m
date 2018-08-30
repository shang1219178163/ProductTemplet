
//
//  BN_CTViewLayoutExcel.m
//  BN_CollectionView
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_CTViewLayoutExcel.h"

@interface BN_CTViewLayoutExcel()

@property (nonatomic, strong) NSMutableArray *itemAttributes;//所有item的布局
@property (nonatomic, strong) NSMutableArray *itemsSizeList;//一行里面所有item的宽，每一行都是一样的

@property (nonatomic, assign) CGSize contentSize;//collectionView的contentSize大小

@end

@implementation BN_CTViewLayoutExcel

- (id)init{
    self = [super init];
    if (self) {
        _lockColumn = 0;
        _columnCount   = 0;
        _itemHeight = 24;
    }
    return self;
}

//重置每一个item的大小和布局
-(void)reset{
    if (self.itemAttributes) [self.itemAttributes removeAllObjects];
    if (self.itemsSizeList) [self.itemsSizeList removeAllObjects];
    
}

#pragma mark - 设置 行 里面的 item 的Size（每一列的宽度一样，所以只需要确定一行的item的宽度）
- (void)calculateItemsSizeList{
    for (NSInteger row = 0; row < _columnCount  ; row++) {
        if (self.itemsSizeList.count <= row) {
            CGSize itemSize = CGSizeMake([_columnWidths[row] floatValue], _itemHeight);
            NSValue *itemSizeValue = [NSValue valueWithCGSize:itemSize];
            [self.itemsSizeList addObject:itemSizeValue];
        }
    }
}

//每一个滚动都会走这里，去确定每一个item的位置
-(void)prepareLayout{
    if (self.collectionView.numberOfSections == 0) return;
    
    NSUInteger column = 0;//列
    CGFloat xOffset = 0.0;//X方向的偏移量
    CGFloat yOffset = 0.0;//Y方向的偏移量
    CGFloat contentWidth = 0.0;//collectionView.contentSize的宽度
    CGFloat contentHeight = 0.0;//collectionView.contentSize的高度
    
    if (self.itemAttributes.count > 0) {
        for (NSInteger section = 0; section < self.collectionView.numberOfSections; section++) {
            NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            for (NSUInteger row = 0; row < numberOfItems; row++) {
                if (section != 0 && row >= _lockColumn) {
                    continue;
                }
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
                UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
                
                [self bn_layoutAtt:attributes indexPath:indexPath];
            }
        }
        return;
    }
    
    //    self.itemAttributes = [@[] mutableCopy];
    //    self.itemsSizeList = [@[] mutableCopy];
    self.itemAttributes = [NSMutableArray arrayWithCapacity:0];
    self.itemsSizeList = [NSMutableArray arrayWithCapacity:0];
    
    if (self.itemsSizeList.count != _columnCount) {
        [self calculateItemsSizeList];
    }
    
    for (NSInteger section = 0; section < self.collectionView.numberOfSections; section ++) {
        NSMutableArray *sectionAttributes = [@[] mutableCopy];
        for (NSUInteger row = 0; row < _columnCount  ; row++) {
            CGSize itemSize = [self.itemsSizeList[row] CGSizeValue];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            if (indexPath.section == 0 && indexPath.row < _lockColumn) {
                attributes.zIndex = 2014; // 设置这个值是为了 让第一项(Sec0Row0)显示在第一列和第一行
            }
            else if (indexPath.section == 0 || indexPath.row < _lockColumn) {
                attributes.zIndex = 2013; // 设置这个是为了 让第一行在上下滚动的时候固定和锁定的列在左右滚动的时候固定，这个值要比上面的小要比0大
            }
            
            [self bn_layoutAtt:attributes indexPath:indexPath];
            [sectionAttributes addObject:attributes];
            
            xOffset = xOffset + itemSize.width;
            column ++;
            
            if (column == _columnCount) {
                if (xOffset > contentWidth) {
                    contentWidth = xOffset;
                }
                
                // 重置基本变量
                column = 0;
                xOffset = 0.0;
                yOffset += itemSize.height;
            }
        }
        [self.itemAttributes addObject:sectionAttributes];
    }
    
    // 获取右下角最有一个item，确定collectionView的contentSize大小
    UICollectionViewLayoutAttributes *attributes = [[self.itemAttributes lastObject] lastObject];
    contentHeight = attributes.frame.origin.y + attributes.frame.size.height;
    _contentSize = CGSizeMake(contentWidth, contentHeight);
}

- (void)bn_layoutAtt:(UICollectionViewLayoutAttributes *)layoutAtt indexPath:(NSIndexPath *)indexPath{
    //第一行
    if (indexPath.section == 0) {
        CGRect frame = layoutAtt.frame;
        frame.origin.y = self.collectionView.contentOffset.y;
        layoutAtt.frame = frame;
    }
    //确定锁定列的位置
    if (indexPath.row < _lockColumn) {
        CGRect frame = layoutAtt.frame;
        CGFloat offsetX = 0.0;
        if (index > 0) {
            for (NSInteger i = 0; i < indexPath.row; i++) {
                offsetX += [_columnWidths[i] floatValue];
            }
        }
        
        frame.origin.x = self.collectionView.contentOffset.x + offsetX;
        layoutAtt.frame = frame;
    }
    
}

#pragma mark - - UICollectionViewLayout (UISubclassingHooks)

-(CGSize)collectionViewContentSize{
    return  _contentSize;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemAttributes[indexPath.section][indexPath.row];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = [@[] mutableCopy];
    for (NSArray *section in self.itemAttributes) {
        [attributes addObjectsFromArray:[section filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
            CGRect frame = [evaluatedObject frame];
            return CGRectIntersectsRect(rect, frame);
        }]]];
    }
    return attributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


@end
