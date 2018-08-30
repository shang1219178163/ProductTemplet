
//
//  BN_CTViewCellTwo.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/16.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTViewCellTwo.h"

@implementation BN_CTViewCellTwo

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}
- (void)createControls{
    //图片+文字+文字
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.labelSub];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imgView.image) {
        self.imgView.frame = CGRectMake(kX_GAP, kY_GAP, self.height - kY_GAP*2, self.height - kY_GAP*2);
        
    }
    
    CGFloat widthLab = (self.width - kPadding*3 - CGRectGetMaxX(self.imgView.frame))*0.5;
    
    self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + kPadding, 0, widthLab, self.height);
    self.labelSub.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + kPadding, 0, widthLab, self.height);
    
}


//- (void)createControls{
//    //文字+文字
//    [self.contentView addSubview:self.label];
//    [self.contentView addSubview:self.labelSub];
//
//}
//
//-(void)layoutSubviews{
//    [super layoutSubviews];
//
//    CGFloat widthLab = (self.width - kPadding)*0.5;
//
//    self.label.frame = CGRectMake(0, 0, widthLab, self.height);
//    self.labelSub.frame = CGRectMake(CGRectGetMaxX(self.label.frame)+kPadding, 0, widthLab, self.height);
//
//}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz


@end
