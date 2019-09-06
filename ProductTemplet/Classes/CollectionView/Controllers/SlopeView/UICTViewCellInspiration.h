//
//  NormalCollectionViewCell.h
//  ParallaxEffectlayout
//
//  Created by bjovov on 2017/11/7.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class InspirationModel;
@interface UICTViewCellInspiration : UICollectionViewCell

@property (nonatomic,strong) UIView *containerview;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeAndRoomLabel;
@property (nonatomic,strong) UILabel *speakerLabel;

//@property (nonatomic,strong) InspirationModel *model;
//- (void)parallaxOffsetForCollectionBounds:(CGRect)collectionBounds;
@end
