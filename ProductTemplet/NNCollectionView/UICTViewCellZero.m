
//
//  UICTViewCellZero.m
//  
//
//  Created by BIN on 2018/4/13.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTViewCellZero.h"

@implementation UICTViewCellZero

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.label];
        self.label.backgroundColor = UIColor.whiteColor;

//        self.label.backgroundColor = [UIColor randomColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = self.contentView.bounds;
}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz
 

@end
