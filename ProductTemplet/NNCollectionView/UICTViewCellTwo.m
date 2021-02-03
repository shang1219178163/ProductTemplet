
//
//  UICTViewCellTwo.m
//  
//
//  Created by BIN on 2018/4/16.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTViewCellTwo.h"

@implementation UICTViewCellTwo

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        //图片+文字+文字
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.labelSub];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imgView.image) {
        self.imgView.frame = CGRectMake(kX_GAP, kY_GAP, self.contentView.maxY - kY_GAP*2, self.contentView.maxY - kY_GAP*2);
        
    }
    
    CGFloat widthLab = (self.contentView.maxX - kPadding*3 - CGRectGetMaxX(self.imgView.frame))*0.5;
    
    self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + kPadding, 0, widthLab, self.contentView.maxY);
    self.labelSub.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + kPadding, 0, widthLab, self.contentView.maxY);
    
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
//    CGFloat widthLab = (self.contentView.maxX - kPadding)*0.5;
//
//    self.label.frame = CGRectMake(0, 0, widthLab, self.contentView.maxY);
//    self.labelSub.frame = CGRectMake(CGRectGetMaxX(self.label.frame)+kPadding, 0, widthLab, self.contentView.maxY);
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
