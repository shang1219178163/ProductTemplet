//
//  UITableViewSenventyTwoCell.m
//  
//
//  Created by BIN on 2018/4/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewSenventyTwoCell.h"
#import <NNGloble/NNGloble.h>
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UIView+Helper.h"

@implementation UITableViewSenventyTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字(icon)+文字(icon)+文字(icon)+文字(icon)

    [self.contentView addSubview:self.labViewOne];
    [self.contentView addSubview:self.labViewTwo];
    [self.contentView addSubview:self.labViewThree];
    [self.contentView addSubview:self.labViewFour];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    
    CGFloat padding = kPadding;
    NSInteger itemCount = 4;
    CGFloat width = (self.contentView.sizeWidth - (itemCount-1)*padding - kX_GAP*2)/itemCount;
    width = floorf(width);


    self.labViewOne.frame   =  CGRectMake(kX_GAP, YGap, width, kH_LABEL);
    self.labViewTwo.frame   = CGRectMake(CGRectGetMaxX(self.labViewOne.frame)+padding, YGap, width, kH_LABEL);
    self.labViewThree.frame = CGRectMake(CGRectGetMaxX(self.labViewTwo.frame)+padding, YGap, width, kH_LABEL);
    self.labViewFour.frame  = CGRectMake(CGRectGetMaxX(self.labViewThree.frame)+padding, YGap, width, kH_LABEL);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(NNLabView *)labViewOne{
    if (!_labViewOne) {
        _labViewOne = ({
            NNLabView * labView = [[NNLabView alloc]initWithFrame:CGRectZero];
            labView.padding = 0.0;
            labView.type = @3;
            
            labView;
        });
    }
    return _labViewOne;
}

-(NNLabView *)labViewTwo{
    if (!_labViewTwo) {
        _labViewTwo = ({
            NNLabView * labView = [[NNLabView alloc]initWithFrame:CGRectZero];
            labView.padding = 0.0;
            labView.type = @3;
            
            labView;
        });

    }
    return _labViewTwo;
}


-(NNLabView *)labViewThree{
    if (!_labViewThree) {
        _labViewThree = ({
            NNLabView * labView = [[NNLabView alloc]initWithFrame:CGRectZero];
            labView.padding = 0.0;
            labView.type = @3;
            
            labView;
        });

    }
    return _labViewThree;
}

-(NNLabView *)labViewFour{
    if (!_labViewFour) {
        _labViewFour = ({
            NNLabView * labView = [[NNLabView alloc]initWithFrame:CGRectZero];
            labView.padding = 0.0;
            labView.type = @3;
            
            labView;
        });

    }
    return _labViewFour;
}

@end
