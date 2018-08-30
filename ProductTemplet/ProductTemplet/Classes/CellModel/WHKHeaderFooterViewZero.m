//
//  WHKHeaderFooterViewZero.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/2.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKHeaderFooterViewZero.h"

@interface WHKHeaderFooterViewZero ()

@end

@implementation WHKHeaderFooterViewZero

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:self.viewIndicator];
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    self.viewIndicator.image = [UIImage imageNamed:@"img_arrowRight_gray.png"];
    self.labelLeftSub.textAlignment = NSTextAlignmentCenter;
    
    //添加点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleActionTapView:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.contentView addGestureRecognizer:tap];
    
     [self.contentView getViewLayer];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat XGap = kX_GAP;
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    CGFloat padding = kPadding;
    CGSize imgViewArrow = CGSizeMake(20, 20);
    
    self.viewIndicator.frame = CGRectMake(XGap, YGap, imgViewArrow.width, imgViewArrow.height);
    self.imgViewLeft.frame = CGRectMake(CGRectGetMaxX(self.viewIndicator.frame) + padding, YGap, kH_LABEL*2, kH_LABEL);
    if (self.imgViewLeft.image == nil) self.imgViewLeft.frame = CGRectZero;
    
    CGFloat titleGapX = CGRectGetMaxX(self.viewIndicator.frame) + CGRectGetWidth(self.imgViewLeft.frame) + padding*2;
    self.labelLeft.frame = CGRectMake(titleGapX, YGap, CGRectGetWidth(self.contentView.frame) - titleGapX*2, kH_LABEL);
    self.labelLeftSub.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding*2, YGap, 30, kH_LABEL);
    
}

- (void)hanleActionTapView:(UITapGestureRecognizer *)tap{
    
    if (self.isCanOPen == YES) {
        [UIView animateWithDuration:kAnimationDuration_Drop animations:^{
            self.viewIndicator.transform = CGAffineTransformIsIdentity(self.viewIndicator.transform) ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
            
        }];
        
        if (self.blockView) {
            self.blockView(self, 0);
        }
    }
}

- (void)setIsOpen:(BOOL)isOpen{
    self.viewIndicator.transform = isOpen == YES ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
    
}

#pragma mark - -layz
//
//-(UIImageView *)viewIndicator{
//    if (!_viewIndicator) {
//        UIImage * imageArrow = [UIImage imageNamed:@"img_arrowRight_gray.png"];
//        _viewIndicator = [UIView createImageViewWithRect:CGRectZero image:imageArrow tag:kTAG_IMGVIEW patternType:@"0"];
//        _viewIndicator.contentMode = UIViewContentModeCenter;
//
//    }
//    return _viewIndicator;
//}

@end
