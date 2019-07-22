
//
//  UICTViewLayoutPhoto.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/7/22.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UICTViewLayoutPhoto.h"

@interface UICTViewLayoutPhoto ()
//属性数组
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation UICTViewLayoutPhoto

/**
 初始化设置
 */
- (void)prepareLayout{
    [super prepareLayout];
    NSInteger rows = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < rows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 返回所有的cell的位置组成的数组, 在这里确定每一个cell的具体位置
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

/**
 这个方法需要返回indexPath位置对应cell的布局属性
 collectionView切换layout布局时必须实现的方法
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger rows = [self.collectionView numberOfItemsInSection:indexPath.section];
    
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat hegiht = self.collectionView.frame.size.height;
    //宽度直径
    CGFloat widthDismeter = width - self.sectionInset.left - self.sectionInset.right;
    //高度直径
    CGFloat hegihtDismeter = hegiht - self.sectionInset.top - self.sectionInset.bottom;
    //圆的半径
    CGFloat raduis = (widthDismeter > hegihtDismeter ? hegihtDismeter : widthDismeter) * 0.5 - (self.itemSize.width > self.itemSize.height ? self.itemSize.height : self.itemSize.width) * 0.5;
    //计算cell的布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = self.itemSize;
    CGFloat angle = 2 * M_PI / rows * indexPath.item;
    CGFloat centerX = CGRectGetMidX(self.collectionView.frame) + raduis * sin(angle);
    CGFloat centerY = CGRectGetMidY(self.collectionView.frame) + raduis * cos(angle);
    attrs.center = CGPointMake(centerX, centerY);
    
    return attrs;
}

#pragma mark -lazy

- (NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        self.attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

@end
