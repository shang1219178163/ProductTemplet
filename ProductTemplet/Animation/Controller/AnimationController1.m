//
//  AnimationController1.m
//  BN_Animation
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 WHKJ. All rights reserved.
//

#import "AnimationController1.h"

@interface AnimationController1 ()

@end

@implementation AnimationController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"shapeLayer基本使用");
    
    [self.view.layer addSublayer:self.shapeLayer];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.生成path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(70, 150)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(150, 130)];
    [path addLineToPoint:CGPointMake(170, 200)];
    
    self.shapeLayer.path = path.CGPath;
    
    //设置animation
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @0;
    strokeAnimation.toValue = @1;
    strokeAnimation.duration = 5.f;
    
    
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.fromValue = @1;
    lineWidthAnimation.toValue = @5;
    lineWidthAnimation.duration = 5.f;
    
    
    CABasicAnimation *strokeColorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeColorAnimation.fromValue = (id)([UIColor redColor].CGColor);
    strokeColorAnimation.toValue = (id)([UIColor magentaColor].CGColor);
    strokeColorAnimation.duration = 5.f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[strokeAnimation, lineWidthAnimation, strokeColorAnimation];
    group.duration = 5.f;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [self.shapeLayer addAnimation:group forKey:@"groupAnimation"];
}

@end
