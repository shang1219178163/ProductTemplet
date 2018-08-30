
//
//  WHKCTReusableViewOne.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTReusableViewOne.h"

@implementation BN_CTReusableViewOne

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    [self addSubview:self.imgView];
    [self addSubview:self.label];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat xGap = 15;
    self.imgView.frame = CGRectMake(kPadding, 0, 2, CGRectGetHeight(self.frame));
    self.label.frame = CGRectMake(xGap, 0, CGRectGetWidth(self.frame) - xGap*2, CGRectGetHeight(self.frame));
}


#pragma mark - -layz


@end
