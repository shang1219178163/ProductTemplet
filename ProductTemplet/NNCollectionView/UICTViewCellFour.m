
//
//  UICTViewCellFour.m
//  
//
//  Created by BIN on 2018/5/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTViewCellFour.h"

@implementation UICTViewCellFour

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        /*
         圆形进度(中心百分比)
         文字
         */
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.progressView];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect rectLab = CGRectMake(0, self.contentView.maxY - kH_LABEL - kX_GAP, self.contentView.maxX, kH_LABEL);
    CGFloat radius = (self.contentView.maxY - CGRectGetHeight(rectLab) - kX_GAP*3)/2.0;
    CGRect rectImgV = CGRectMake(self.contentView.maxX/2.0 - radius, kX_GAP, radius*2, radius*2);
    
    self.progressView.frame = rectImgV;
    self.label.frame = rectLab;
    
}

#pragma mark - -layz

-(NNCricleProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[NNCricleProgressView alloc]initWithFrame:CGRectZero];
    }
    return _progressView;
}

@end
