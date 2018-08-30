
//
//  BN_CTViewCellThree.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTViewCellThree.h"

@implementation BN_CTViewCellThree

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     文字
     文字
     */
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.labelSub];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
        
    self.label.frame = CGRectMake(0, kY_GAP, self.width, kH_LABEL);
    self.labelSub.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame), self.width, kH_LABEL);
    
}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz


@end
