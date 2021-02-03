
//
//  UICTViewCellThree.m
//  
//
//  Created by BIN on 2018/5/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTViewCellThree.h"


@implementation UICTViewCellThree

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        /*
         文字
         文字
         */
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.labelSub];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0, kY_GAP, self.contentView.maxX, kH_LABEL);
    self.labelSub.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame), self.contentView.maxX, kH_LABEL);
    
} 

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz


@end
