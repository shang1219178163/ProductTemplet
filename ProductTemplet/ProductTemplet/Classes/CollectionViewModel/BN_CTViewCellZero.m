
//
//  BN_CTViewCellZero.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTViewCellZero.h"

@implementation BN_CTViewCellZero

//+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
//NSString * identifier = NSStringFromClass([self class]);
//    BN_CTViewCellZero *view = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//
//    return view;
//}
//
//+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
//    BN_CTViewCellZero *view = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//
//    return view;
//}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.label];
    
    self.label.backgroundColor = [UIColor whiteColor];
    self.imgView.backgroundColor = [UIColor whiteColor];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.width == self.height) {
        self.imgView.frame = CGRectZero;
        self.label.frame = self.contentView.bounds;
        
    }else{
        
        if (self.width > self.height) {
            self.imgView.frame = CGRectMake(kPadding, 0, self.height, self.height);
            self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+kPadding,0, self.width - CGRectGetWidth(self.imgView.frame) - kPadding*3, self.height);
            
        }else{
            self.imgView.frame = CGRectMake(0, kPadding, self.height, self.height);
            self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+kPadding, self.width, self.height - CGRectGetHeight(self.imgView.frame) - kPadding*3);
            
        }
    }
    
}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz


@end
