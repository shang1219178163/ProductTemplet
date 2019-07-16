//
//  UICTViewCellCycle.m
//  CollectionViewDemo1
//
//  Created by IOS.Mac on 16/10/27.
//  Copyright © 2016年 com.elepphant.pingchuan. All rights reserved.
//

#import "UICTViewCellCycle.h"
#import "Masonry.h"

@interface UICTViewCellCycle()

@end

@implementation UICTViewCellCycle

//- (void)prepareForReuse {
//    [super prepareForReuse];
//    _imageView.image = nil;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.label];
        
        self.backgroundColor = UIColor.whiteColor;
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = self.contentView.frame;
    self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame)/2.0, CGRectGetWidth(self.contentView.frame)/2.0);
}

#pragma mark - Public Method

#pragma mark -lazy

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView * view = [[UIImageView alloc]init];
            view.userInteractionEnabled = YES;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.contentMode = UIViewContentModeScaleAspectFill;

            //        imgView.backgroundColor = UIColor.randomColor;
            
            view;
        });
    }
    return _imgView;
}

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel *view = [[UILabel alloc]initWithFrame:CGRectZero];
            view.textAlignment = NSTextAlignmentCenter;
            view.textColor = UIColor.whiteColor;
            view.backgroundColor = UIColor.redColor;

            view;
        });
    }
    return _label;
}



@end
