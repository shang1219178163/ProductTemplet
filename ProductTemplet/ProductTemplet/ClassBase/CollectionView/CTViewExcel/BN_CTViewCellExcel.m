//
//  BN_CTViewCellExcel.m
//  BN_CollectionView
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_CTViewCellExcel.h"

@interface BN_CTViewCellExcel ()


@end

@implementation BN_CTViewCellExcel

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    
    NSString * identifier = [UICollectionView cellIdentifierByClassName:NSStringFromClass([self class])];
    BN_CTViewCellExcel *view = (BN_CTViewCellExcel *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return view;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
//    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.label];

    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
//    self.imgView.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + 1, 0, 1, CGRectGetHeight(self.contentView.frame));
    
//    UIColor * lineColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
//    lineColor = [UIColor redColor];
//    [self.label.layer addSublayer:[self.label createLayerType:@"2" color:kExcelColor width:kW_LayerBorderWidth]];
//    [self.label.layer addSublayer:[self.label createLayerType:@"3" color:kExcelColor width:kW_LayerBorderWidth]];
    
    [self.label.layer addSublayer:[self.label createLayerType:@2 color:kExcelColor width:kW_LayerBorderWidth paddingScale:0]];
    [self.label.layer addSublayer:[self.label createLayerType:@3 color:kExcelColor width:kW_LayerBorderWidth paddingScale:0]];

}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz


@end
