//
//  UICTViewLayoutCircle.m
//  NNCollectionView
//
//  Created by hsf on 2018/4/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICTViewLayoutCircle.h"

@interface UICTViewLayoutCircle()

@property (nonatomic, strong) NSMutableArray *attrsArray;


@end

@implementation UICTViewLayoutCircle

- (instancetype)init{
    self = [super init];
    if (self) {
        //不是流水布局，需要自己写
        //item水平间距
        self.minimumLineSpacing = 5;
        //item垂直间距
        self.minimumInteritemSpacing = 5;
        //item的尺寸
        self.itemSize = CGSizeMake(40, 40);
        //item的UIEdgeInsets
    //    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //滑动方向,默认垂直
    //    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //sectionView 尺寸
        self.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.collectionView.bounds), 40);
        self.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.collectionView.bounds), 20);
        
    }
    return self;
}

//放射性圆形布局
-(void)prepareLayout{
    [super prepareLayout];
    //球形平铺
    [self.attrsArray removeAllObjects];
    
    //组数
    NSInteger section = self.collectionView.numberOfSections;
    for (NSInteger i = 0;  i < section; i++) {
        //每组cell数
        NSInteger count = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0 ; j < count; j++) {
            //获取布局信息
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attrs];
        }
    }
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //组数
    NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
    //设置半径
    CGFloat radius = CGRectGetMidX(self.collectionView.frame) - indexPath.section *(self.itemSize.width + self.minimumInteritemSpacing)  - (self.itemSize.width + self.minimumInteritemSpacing)*0.5;
    
    //设置cell的中心
    CGFloat angle = 2 * M_PI / count * indexPath.item;
    CGFloat centerX = CGRectGetMidX(self.collectionView.frame) + radius * sin(angle);
    CGFloat centerY = CGRectGetMidY(self.collectionView.frame) + radius * cos(angle);
    
    //原本的布局信息
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.center = CGPointMake(centerX, centerY);
    //设置宽高
    attrs.size = self.itemSize;
    return attrs;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

#pragma mark ---- 返回CollectionView的内容视图大小
//-(CGSize)collectionViewContentSize{
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, (self.radius - CGRectGetMidX(self.collectionView.frame))*2, 0, 0);
//    return CGSizeMake(self.radius*2, CGRectGetHeight(self.collectionView.frame));
//}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

#pragma mark -lazy

-(NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

@end
