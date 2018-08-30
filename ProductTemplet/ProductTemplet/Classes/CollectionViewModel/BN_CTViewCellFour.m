
//
//  BN_CTViewCellFour.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTViewCellFour.h"

@implementation BN_CTViewCellFour

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     圆形进度(中心百分比)
     文字
     */
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.progressView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect rectLab = CGRectMake(0, self.height - kH_LABEL - kX_GAP, self.width, kH_LABEL);
    CGFloat radius = (self.height - CGRectGetHeight(rectLab) - kXY_GAP*3)/2.0;
    CGRect rectImgV = CGRectMake(self.width/2.0 - radius, kX_GAP, radius*2, radius*2);
    
    self.progressView.frame = rectImgV;
    self.label.frame = rectLab;
    
}

#pragma mark - -layz

-(BN_CricleProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[BN_CricleProgressView alloc]initWithFrame:CGRectZero];
    }
    return _progressView;
}

@end
