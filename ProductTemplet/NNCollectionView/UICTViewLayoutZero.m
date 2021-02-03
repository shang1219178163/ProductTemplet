//
//  UICTViewLayoutZero.m
//  
//
//  Created by BIN on 2018/4/16.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTViewLayoutZero.h"

#import <NNGloble/NNGloble.h>

static NSInteger numberOfRow = 2;

@interface UICTViewLayoutZero()

@property (nonatomic, strong) NSMutableArray *attrsArray;
@property (nonatomic, assign) CGFloat height;

@end

@implementation UICTViewLayoutZero

- (instancetype)init{
    self = [super init];
    if (self) {
        //布局初始化
        CGFloat width = CGRectGetWidth(self.collectionView.frame);

        self.minimumLineSpacing = self.minimumLineSpacing > 0.0 ? : kPadding;
        self.minimumInteritemSpacing = self.minimumInteritemSpacing > 0.0 ? : kPadding;
        
        //item的UIEdgeInsets
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //    self.sectionInset = UIEdgeInsetsZero;
        
        //    滑动方向,默认垂直
        //    sectionView 尺寸
        self.headerReferenceSize = CGSizeMake(width, 40);
        self.footerReferenceSize = CGSizeMake(width, 20);
        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    //
    [self.attrsArray removeAllObjects];
    
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - self.minimumInteritemSpacing - self.sectionInset.left - self.sectionInset.right)*0.5;
    self.itemSize = CGSizeEqualToSize(self.itemSize, CGSizeZero) ? CGSizeMake(itemWidth, 35) : CGSizeMake(itemWidth, self.itemSize.height);
    
    
    [self setupAttributes];
}

- (void)setupAttributes{
    //
    UICollectionViewLayoutAttributes * attri = nil;
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
