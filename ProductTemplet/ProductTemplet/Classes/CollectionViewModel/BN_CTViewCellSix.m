//
//  BN_CTViewCellSix.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_CTViewCellSix.h"

@implementation BN_CTViewCellSix

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
    [self.contentView addSubview:self.labelSub];

    self.imgView.backgroundColor = UIColor.whiteColor;
    self.imgView.contentMode = UIViewContentModeScaleToFill;

    self.label.backgroundColor = UIColor.whiteColor;
    self.labelSub.textColor = kC_ThemeCOLOR;;
    self.labelSub.backgroundColor = UIColor.clearColor;

}

-(void)layoutSubviews{
    [super layoutSubviews];
   
    self.imgView.frame = CGRectMake(0, 0, self.width, self.height - kH_LABEL);
    self.label.frame = CGRectMake(CGRectGetMinX(self.imgView.frame), CGRectGetMaxY(self.imgView.frame), self.width, kH_LABEL);
    
    self.labelSub.frame = CGRectMake(0, CGRectGetMaxY(self.imgView.frame) - kH_LABEL, CGRectGetWidth(self.imgView.frame), kH_LABEL);
    
}


#pragma mark - -layz

@end

