//
//  AnimationController4.m
//  NNAnimation
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 WHKJ. All rights reserved.
//

#import "AnimationController4.h"

#import "CALayer+Helper.h"

@interface AnimationController4 ()

@end

@implementation AnimationController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;NSLog(@"把CAShapeLayer设置为蒙版来做动画");
    
  
    [self.view.layer addSublayer:self.shapeLayer];

    [self.view.layer getLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CAShapeLayer *shapeLayer = CAShapeLayer.layer;
    shapeLayer.backgroundColor = UIColor.redColor.CGColor;
    self.shapeLayer.mask = shapeLayer;
    
    UIBezierPath *fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 200, 0)];
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 200, 200)];
    shapeLayer.path = fromPath.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (id)fromPath.CGPath;
    animation.toValue = (id)toPath.CGPath;
    animation.duration = 5.f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [shapeLayer addAnimation:animation forKey:@"animation"];
}

@end
