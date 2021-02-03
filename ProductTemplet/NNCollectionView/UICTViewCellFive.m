//
//  UICTViewCellFive.m
//  
//
//  Created by BIN on 2018/5/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTViewCellFive.h"
#import <NNGloble/NNGloble.h>
#import <NNCategoryPro/NNCategoryPro.h>

@implementation UICTViewCellFive

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        //图片+文字+条形进度+文字
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.labelSub];
        
        [self.contentView addSubview:self.progressView];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [self sizeWithText:self.label.text font:self.label.font width:CGFLOAT_MAX];
    CGSize sizeSub = [self sizeWithText:self.labelSub.text font:self.labelSub.font width:CGFLOAT_MAX];
    
    if (self.imgView.image) {
        CGSize sizeImg = CGSizeMake(30, 30);
        self.imgView.frame = CGRectMake(kX_GAP, (self.contentView.maxY - sizeImg.height)*0.5, sizeImg.width, sizeImg.height);

    } 
    self.labelSub.frame = CGRectMake(self.contentView.maxX - kX_GAP - sizeSub.width, 0, sizeSub.width, self.contentView.maxY);

    self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + kPadding, 0, size.width, self.contentView.maxY);
    self.progressView.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + kPadding, self.contentView.maxY/2.0, CGRectGetMinX(self.labelSub.frame) - CGRectGetMaxX(self.label.frame) - kPadding*2, self.contentView.maxY);
    
}


#pragma mark - -layz

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = ({
            UIProgressView *view = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            view.frame = CGRectZero;;
            //设置进度条颜色
            view.trackTintColor = UIColor.lightGrayColor;
            view.progressTintColor = UIColor.redColor;
            view.progress = 0.1;
//            view.trackImage = [UIImage imageNamed:@""];//设置进度条的背景图片
//            view.progressImage = [UIImage imageNamed:@""];//设置进度条上进度的背景图片

            view.transform = CGAffineTransformMakeScale(1.0f, 10.0f);//设定宽高
            //设定两端弧度
            view.layer.cornerRadius = 1.0;
            view.layer.masksToBounds = YES;
            view;
        });
    }
    return _progressView;
}

@end
