//
//  BN_CircleView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/17.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_Circle.h"

@implementation BN_Circle

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2.0;
    }
    return self;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle: nil message: @"点击圆形视图" delegate: nil cancelButtonTitle: @"确认" otherButtonTitles: nil];
    [alert show];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    return [path containsPoint: point];
}


@end
