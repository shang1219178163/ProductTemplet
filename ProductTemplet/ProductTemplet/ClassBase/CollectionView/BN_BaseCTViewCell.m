//
//  BN_BaseCTViewCell.m
//  BN_CollectionView
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_BaseCTViewCell.h"

@interface BN_BaseCTViewCell ()


@end

@implementation BN_BaseCTViewCell

-(CGFloat)width{
    if (!_width) {
        _width = CGRectGetWidth(self.contentView.frame);

    }
    return _width;
}

-(CGFloat)height{
    if (!_height) {
        _height = CGRectGetHeight(self.contentView.frame);

    }
    return _height;
}

//+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
//
//    NSString * identifier = [UICollectionView cellIdentifierByClassName:NSStringFromClass([self class])];
//    BN_BaseCTViewCell *view = (BN_BaseCTViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    return view;
//}

#pragma mark - -layz

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:15];
//            label.textColor = UIColor.grayColor;
            label.textAlignment = NSTextAlignmentCenter;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
//        label.backgroundColor = UIColor.greenColor;
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
            label.textColor = UIColor.grayColor;
            label.textAlignment = NSTextAlignmentCenter;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
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
//            imgView.backgroundColor = UIColor.orangeColor;
            
            imgView;
        });
    }
    return _imgView;
}

@end
