//
//  UICTViewLayoutOne.m
//  BNCollectionView
//
//  Created by BIN on 2018/4/17.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICTViewLayoutOne.h"

#import <NNGloble/NNGloble.h>

static NSInteger numberOfRow = 2;

@interface UICTViewLayoutOne()

@property (nonatomic, strong) NSMutableArray *attrsArray;

@property (nonatomic, assign) CGFloat height;

@end

@implementation UICTViewLayoutOne

- (instancetype)init{
    self = [super init];
    if (self) {
        //布局初始化
        CGFloat width = CGRectGetWidth(self.collectionView.frame);

        self.minimumLineSpacing = kPadding;
        self.minimumInteritemSpacing = kPadding;
        
        //item的UIEdgeInsets
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //    self.sectionInset = UIEdgeInsetsZero;
        
        //    滑动方向,默认垂直
        //    sectionView 尺寸
        self.headerReferenceSize = CGSizeMake(width, 30);
        self.footerReferenceSize = CGSizeMake(width, 30);
        
    }
    return self;
}

/**
 在init和prepareLayout之间的阶段可以对属性二次设置
 */
-(void)prepareLayout{
    [super prepareLayout];
    //布局初始化
    [self.attrsArray removeAllObjects];
    
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - self.minimumInteritemSpacing - self.sectionInset.left - self.sectionInset.right)*0.5;
    self.itemSize = CGSizeEqualToSize(self.itemSize, CGSizeZero) ?  CGSizeMake(itemWidth, 35) : CGSizeMake(itemWidth, self.itemSize.height);
    //    DDLog(@"%@_%@",@(itemWidth),@(self.itemSize));
    
    [self setupAttributes];
}

- (void)setupAttributes{
    //
    UICollectionViewLayoutAttributes *attri = nil;
    UICollectionViewLayoutAttributes *attriHeader = nil;
    UICollectionViewLayoutAttributes *attriFooter = nil;
    //组数
    NSInteger section = self.collectionView.numberOfSections;
    for (NSInteger i = 0;  i < section; i++) {
        NSIndexPath *indexP = [NSIndexPath indexPathWithIndex:i];
        attriHeader = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexP];
        attriHeader.frame = CGRectMake(0, CGRectGetMaxY(attriFooter.frame), self.headerReferenceSize.width, self.headerReferenceSize.height);
        [self.attrsArray addObject:attriHeader];

        //每组cell数
        NSInteger count = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0 ; j < count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            //获取布局信息
            attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            //            attri.size = self.itemSize;
            attri.size = self.itemSize;
            //获取布局信息
            CGFloat w = attri.size.width;
            CGFloat h = attri.size.height;
            CGFloat x = (j % numberOfRow) * (w + self.minimumInteritemSpacing);
            CGFloat y = (j / numberOfRow) * (h + self.minimumLineSpacing);
            //
            x += self.sectionInset.left;
            y += self.sectionInset.top;

            attri.frame = CGRectMake(x, CGRectGetMaxY(attriHeader.frame) + y, w, h);
            [self.attrsArray addObject:attri];

        }
        attriFooter = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexP];
        attriFooter.frame = CGRectMake(0,self.sectionInset.top + CGRectGetMaxY(attri.frame), self.footerReferenceSize.width, self.footerReferenceSize.height);
        [self.attrsArray addObject:attriFooter];

        //        DDLog(@"%@_%@_%@",NSStringFromCGRect(attriHeader.frame),NSStringFromCGRect(attri.frame),NSStringFromCGRect(attriFooter.frame))
    }
    self.height = CGRectGetMaxY(attriFooter.frame);
//    DDLog(@"%.2f_%@_%ld",self.height,NSStringFromCGRect(self.collectionView.frame),self.attrsArray.count);
    
}

//此方法应该返回当前屏幕正在显示的视图UICollectionViewLayoutAttributes 对象集合
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
    
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), self.height);
    
}

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
 
