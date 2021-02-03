//
//  UICTReusableViewTwo.m
//  
//
//  Created by BIN on 2018/5/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTReusableViewTwo.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"

@implementation UICTReusableViewTwo

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        /*
         文字
         文字(大号字)
         */
        [self addSubview:self.label];
        [self addSubview:self.labelSub];
        
        self.labelSub.font = [UIFont systemFontOfSize:36];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0, kY_GAP, self.maxX, kH_LABEL);
    self.labelSub.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame)+kPadding, self.maxX, self.maxY - CGRectGetHeight(self.label.frame) - kY_GAP - kPadding);

} 

#pragma mark - -layz



@end
