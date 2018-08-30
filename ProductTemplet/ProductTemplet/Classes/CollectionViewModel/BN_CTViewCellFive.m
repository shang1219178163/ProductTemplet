//
//  BN_CTViewCellFive.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTViewCellFive.h"

@implementation BN_CTViewCellFive

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}
- (void)createControls{
    //图片+文字+进度条+文字
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.labelSub];
    
    [self.contentView addSubview:self.progressView];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [self sizeWithText:self.label.text font:self.label.font width:kScreen_width];
    CGSize sizeSub = [self sizeWithText:self.labelSub.text font:self.labelSub.font width:kScreen_width];
    
    if (self.imgView.image) {
        CGSize sizeImg = CGSizeMake(30, 30);
        self.imgView.frame = CGRectMake(kX_GAP, (self.height - sizeImg.height)*0.5, sizeImg.width, sizeImg.height);

    }
    self.labelSub.frame = CGRectMake(self.width - kX_GAP - sizeSub.width, 0, sizeSub.width, self.height);

    self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + kPadding, 0, size.width, self.height);
    self.progressView.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + kPadding, self.height/2.0, CGRectGetMinX(self.labelSub.frame) - CGRectGetMaxX(self.label.frame) - kPadding*2, self.height);
    
}


#pragma mark - -layz

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = ({
            UIProgressView *view = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            view.frame = CGRectZero;;
            //设置进度条颜色
            view.trackTintColor = [UIColor lightGrayColor];
            view.progressTintColor = [UIColor redColor];
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
