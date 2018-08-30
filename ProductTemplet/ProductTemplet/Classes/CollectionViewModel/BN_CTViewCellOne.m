
//
//  BN_CTViewCellOne.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTViewCellOne.h"

@implementation BN_CTViewCellOne


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
    图片
    文字
    */
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.label];
    
    
    self.imgView.backgroundColor = [UIColor whiteColor];
    self.label.backgroundColor = [UIColor whiteColor];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
//    self.imgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) - kH_LABEL);
//    self.label.frame = CGRectMake(CGRectGetMinX(self.imgView.frame), CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.imgView.frame), kH_LABEL);
    
    if (self.width == self.height) {
        self.imgView.frame = CGRectZero;
        self.label.frame = self.contentView.bounds;
        
    }else{
        
        if (self.width < self.height) {
            self.imgView.frame = CGRectMake(0, 0, self.width, self.height -kH_LABEL);
            self.label.frame = CGRectMake(CGRectGetMinX(self.imgView.frame), CGRectGetMaxY(self.imgView.frame), self.width, kH_LABEL);
        }
        else{
            self.imgView.frame = CGRectMake(0, 0, self.height, self.height);
            self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame), CGRectGetMinY(self.imgView.frame), self.width - CGRectGetWidth(self.imgView.frame), CGRectGetHeight(self.imgView.frame));
        }
    }
}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz

@end
