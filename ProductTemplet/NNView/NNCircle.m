//
//  NNCircleView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/17.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NNCircle.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"

@implementation NNCircle

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2.0;
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@:%@", NSStringFromSelector(_cmd), @"点击圆形视图");
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    return [path containsPoint: point];
}


@end
