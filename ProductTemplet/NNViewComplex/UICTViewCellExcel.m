//
//  UICTViewCellExcel.m
//  BNCollectionView
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICTViewCellExcel.h"
#import "NNGloble.h"
#import <NNCategoryPro/NNCategoryPro.h>

@interface UICTViewCellExcel ()

@property(nonatomic, strong) UIColor *excelColor;

@end

@implementation UICTViewCellExcel

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.label];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
   
//    lineColor = UIColor.redColor;
    [self.label.layer addSublayer:[self.label createLayerType:@2 color:self.excelColor width:kW_LayerBorder paddingScale:0]];
    [self.label.layer addSublayer:[self.label createLayerType:@3 color:self.excelColor width:kW_LayerBorder paddingScale:0]];
 
}

#pragma mark - -layz

-(UIColor *)excelColor{
    if (!_excelColor) {
        _excelColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _excelColor;
}


@end
