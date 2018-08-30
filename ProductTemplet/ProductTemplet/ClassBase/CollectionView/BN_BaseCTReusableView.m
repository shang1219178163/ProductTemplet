//
//  BN_BaseCollectionReusableView.m
//  BN_ExcelView
//
//  Created by hsf on 2018/4/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_BaseCTReusableView.h"

@interface BN_BaseCTReusableView ()


@end

@implementation BN_BaseCTReusableView

-(CGFloat)width{
    if (!_width) {
        _width = CGRectGetWidth(self.frame);
        
    }
    return _width;
}

-(CGFloat)height{
    if (!_height) {
        _height = CGRectGetHeight(self.frame);
        
    }
    return _height;
}

//+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath kind:(NSString *)kind{
//    
//    NSString * identifier = [UICollectionView viewIdentifierByClassName:NSStringFromClass([self class]) kind:kind];
//    
//    BN_BaseCTReusableView *view = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
//        
//    }
//    else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
//        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
//        
//    }
//    return view;
//}

#pragma mark - -layz

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:15];
            //            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
//            label.backgroundColor = [UIColor clearColor];
            label;
        });
    }
    return _label;
}

-(UILabel *)labelSub{
    if (!_labelSub) {
        _labelSub = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = [UIColor greenColor];
            label;
        });
    }
    return _labelSub;
}


-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
//            imgView.backgroundColor = [UIColor orangeColor];
            
            imgView;
        });
        
    }
    return _imgView;
}


@end
