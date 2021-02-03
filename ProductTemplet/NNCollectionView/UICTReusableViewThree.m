

//
//  UICTReusableViewThree.m
//  
//
//  Created by BIN on 2018/5/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTReusableViewThree.h"
#import <NNGloble/NNGloble.h>
#import <NNCategoryPro/NNCategoryPro.h>

@implementation UICTReusableViewThree

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        //图片+文字+ | +文字
        [self addSubview:self.imgView];
        [self addSubview:self.label];
        [self addSubview:self.labelSub];
        
        [self addSubview:self.lineView];
        
        self.label.textColor = UIColor.themeColor;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [self sizeWithText:self.label.text font:self.label.font width:CGFLOAT_MAX];
    CGSize sizeSub = [self sizeWithText:self.labelSub.text font:self.labelSub.font width:CGFLOAT_MAX];
    
    if (self.imgView.image) {
        self.imgView.frame = CGRectMake(kX_GAP, kY_GAP, self.maxY - kY_GAP*2, self.maxY - kY_GAP*2);
        
    }
    
    self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + kPadding, 0, size.width, self.maxY);
    self.lineView.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + kPadding, kY_GAP, 1, self.maxY - kY_GAP*2);
    self.labelSub.frame = CGRectMake(CGRectGetMaxX(self.lineView.frame) + kPadding, 0, sizeSub.width, self.maxY);
    
} 

#pragma mark - -layz

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = ({
            UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
            view.backgroundColor = UIColor.lineColor;
            
            view;
        });
    }
    return _lineView;
}


@end
