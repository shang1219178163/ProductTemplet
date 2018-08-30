

//
//  BN_CTReusableViewThree.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTReusableViewThree.h"

@implementation BN_CTReusableViewThree

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片+文字+ | + 文字
    [self addSubview:self.imgView];
    [self addSubview:self.label];
    [self addSubview:self.labelSub];

    [self addSubview:self.lineView];
    
    self.label.textColor = kC_ThemeCOLOR;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [self sizeWithText:self.label.text font:self.label.font width:kScreen_width];
    CGSize sizeSub = [self sizeWithText:self.labelSub.text font:self.labelSub.font width:kScreen_width];
    
    if (self.imgView.image) {
        self.imgView.frame = CGRectMake(kXY_GAP, kY_GAP, self.height - kY_GAP*2, self.height - kY_GAP*2);
        
    }
    
    self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + kPadding, 0, size.width, self.height);
    self.lineView.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + kPadding, kY_GAP, 1, self.height - kY_GAP*2);
    self.labelSub.frame = CGRectMake(CGRectGetMaxX(self.lineView.frame) + kPadding, 0, sizeSub.width, self.height);
    
}

#pragma mark - -layz

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = ({
            UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
            view.backgroundColor = kC_LineColor;
            
            view;
        });
    }
    return _lineView;
}


@end
