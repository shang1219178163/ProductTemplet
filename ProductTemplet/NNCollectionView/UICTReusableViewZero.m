//
//  UICTReusableViewZero.m
//  
//
//  Created by BIN on 2018/4/13.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTReusableViewZero.h"
#import <NNGloble/NNGloble.h>
//#import "Masonry.h"

@interface UICTReusableViewZero ()

@end

@implementation UICTReusableViewZero

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubview:self.imgView];
        [self addSubview:self.label];
        
        self.imgView.backgroundColor = UIColor.clearColor;

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imgView.image) {
        self.imgView.frame = CGRectMake(kX_GAP, 0, kWH_ArrowRight, self.sizeHeight);
        self.label.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + kX_GAP, 0, self.sizeWidth - CGRectGetMaxX(self.imgView.frame) - kX_GAP, self.sizeHeight);
    }
    else{
        self.label.frame = CGRectMake(kX_GAP, 0, self.sizeWidth - kX_GAP*2, self.sizeHeight);
        
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
