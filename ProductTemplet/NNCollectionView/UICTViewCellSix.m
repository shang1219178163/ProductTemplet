//
//  UICTViewCellSix.m
//  
//
//  Created by BIN on 2018/5/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTViewCellSix.h"
#import <NNGloble/NNGloble.h>
#import <NNCategoryPro/NNCategoryPro.h>

@implementation UICTViewCellSix

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
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
        self.labelSub.textColor = UIColor.themeColor;;
        self.labelSub.backgroundColor = UIColor.clearColor;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
    self.imgView.frame = CGRectMake(0, 0, self.contentView.maxX, self.contentView.maxY - kH_LABEL);
    self.label.frame = CGRectMake(CGRectGetMinX(self.imgView.frame), CGRectGetMaxY(self.imgView.frame), self.contentView.maxX, kH_LABEL);
    
    self.labelSub.frame = CGRectMake(0, CGRectGetMaxY(self.imgView.frame) - kH_LABEL, CGRectGetWidth(self.imgView.frame), kH_LABEL);
    
}

 
#pragma mark - -layz

@end

