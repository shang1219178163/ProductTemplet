
//
//  WHKCTReusableViewOne.m
//  
//
//  Created by BIN on 2018/4/13.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTReusableViewOne.h"
#import <NNGloble/NNGloble.h>
#import <NNCategoryPro/NNCategoryPro.h>

@implementation UICTReusableViewOne

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubview:self.imgView];
        [self addSubview:self.label];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(kPadding, 0, 2, self.sizeHeight);
    self.label.frame = CGRectMake(kX_GAP, 0, self.sizeWidth - kX_GAP*2, self.sizeHeight);
}

#pragma mark - -layz


@end
