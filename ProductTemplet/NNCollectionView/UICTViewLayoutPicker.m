//
//  UICTViewLayoutPicker.m
//  NNCollectionView
//
//  Created by hsf on 2018/4/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICTViewLayoutPicker.h"

@implementation UICTViewLayoutPicker

-(void)prepareLayout{
    [super prepareLayout];
    //滚轮
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 60);

}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * atti = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //获取item的个数
    NSInteger itemCounts = [self.collectionView numberOfItemsInSection:0];
    atti.center = CGPointMake(CGRectGetMidX(self.collectionView.frame), 
                              CGRectGetMidY(self.collectionView.frame)+self.collectionView.contentOffset.y);
    atti.size = self.itemSize;

    CATransform3D trans3D = CATransform3DIdentity;
    trans3D.m34 = -1/900.0;
    
    CGFloat radius = atti.size.height*0.5/tanf(M_PI*2/itemCounts/2);
    //根据偏移量 改变角度
    CGFloat offset = self.collectionView.contentOffset.y;
    CGFloat angleOffset = offset/CGRectGetHeight(self.collectionView.frame);
    CGFloat angle = (indexPath.row + angleOffset - 1)/itemCounts * M_PI*2;
    trans3D = CATransform3DRotate(trans3D, angle, 1.0, 0, 0);
    trans3D = CATransform3DTranslate(trans3D, 0, 0, radius);
    atti.transform3D = trans3D;
    return atti;
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray * attributes = [[NSMutableArray alloc]init];
    //遍历设置每个item的布局属性
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attri];
        
    }
    return attributes;
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame)*([self.collectionView numberOfItemsInSection:0]+2));
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
