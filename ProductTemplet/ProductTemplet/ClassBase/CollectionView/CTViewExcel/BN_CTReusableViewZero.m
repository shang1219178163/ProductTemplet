//
//  BN_CTReusableViewZero.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTReusableViewZero.h"

@interface BN_CTReusableViewZero ()

@end

@implementation BN_CTReusableViewZero

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath kind:(NSString *)kind{
    
    NSString * identifier = [UICollectionView viewIdentifierByClassName:NSStringFromClass([self class]) kind:kind];
    BN_CTReusableViewZero *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
        
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
        
    }
    
    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? @"headerView": @"footerView";
    view.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? [UIColor greenColor] : [UIColor yellowColor];

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
    [self addSubview:self.label];
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(15, 0, CGRectGetWidth(self.frame) - 15*2, CGRectGetHeight(self.frame));

  
}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz



@end
