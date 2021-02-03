//
//  UICTViewLayoutSphere.m
//  NNCollectionView
//
//  Created by hsf on 2018/4/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICTViewLayoutSphere.h"

@implementation UICTViewLayoutSphere

-(void)prepareLayout{
    [super prepareLayout];
    //立体空间球体
    self.itemSize = CGSizeMake(40, 40);

}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * atti = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //获取item的个数
    NSInteger itemCounts = [self.collectionView numberOfItemsInSection:0];
    atti.center = CGPointMake(CGRectGetWidth(self.collectionView.frame)/2+self.collectionView.contentOffset.x, CGRectGetHeight(self.collectionView.frame)/2+self.collectionView.contentOffset.y);
    atti.size = self.itemSize;
    
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D.m34 = -1/900.0;
    
    CGFloat radius = atti.size.height*0.5/tanf(M_PI*2/itemCounts/2);
    //根据偏移量 改变角度
    //添加了一个x的偏移量
    CGFloat offsety = self.collectionView.contentOffset.y;
    CGFloat offsetx = self.collectionView.contentOffset.x;
    //分别计算偏移的角度
    CGFloat angleOffsety = offsety/CGRectGetHeight(self.collectionView.frame);
    CGFloat angleOffsetx = offsetx/CGRectGetWidth(self.collectionView.frame);
    CGFloat angle1 = (indexPath.row+angleOffsety-1)/itemCounts*M_PI*2;
    //x，y的默认方向相反
    CGFloat angle2 = (indexPath.row-angleOffsetx-1)/itemCounts*M_PI*2;
    //这里我们进行四个方向的排列
    if (indexPath.row%4 == 1) {
        trans3D = CATransform3DRotate(trans3D, angle1, 1.0,0, 0);
    } else if (indexPath.row%4 == 2){
        trans3D = CATransform3DRotate(trans3D, angle2, 0, 1, 0);
    } else if (indexPath.row%4 == 3){
        trans3D = CATransform3DRotate(trans3D, angle1, 0.5,0.5, 0);
    } else {
        trans3D = CATransform3DRotate(trans3D, angle1, 0.5,-0.5,0);
    }
    
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

//返回的滚动范围增加了对x轴的兼容
-(CGSize)collectionViewContentSize{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame)*([self.collectionView numberOfItemsInSection:0]+2), CGRectGetHeight(self.collectionView.frame)*([self.collectionView numberOfItemsInSection:0]+2));
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
