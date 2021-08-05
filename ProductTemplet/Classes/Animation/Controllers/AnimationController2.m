//
//  AnimationController2.m
//  NNAnimation
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 WHKJ. All rights reserved.
//

#import "AnimationController2.h"

@interface AnimationController2 ()

@end

@implementation AnimationController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    NSLog(@"CAShapeLayer与贝塞尔曲线");
    [self.view.layer addSublayer:self.shapeLayer];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //二次贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.shapeLayer.bounds.size.height / 2)];
    [path addCurveToPoint:CGPointMake(self.shapeLayer.bounds.size.width, 100) controlPoint1:CGPointMake(50, 0) controlPoint2:CGPointMake(150, 200)];
    self.shapeLayer.path = path.CGPath;
    
    //绘制动画
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0.5;
    strokeEndAnimation.toValue = @1;
    strokeEndAnimation.duration = 5.f;
    
    [self.shapeLayer addAnimation:strokeEndAnimation forKey:@"strokeAnimation"];
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @0.5;
    strokeStartAnimation.toValue = @0;
    strokeStartAnimation.duration = 5.f;
    
    [self.shapeLayer addAnimation:strokeStartAnimation forKey:@"strokeStartAnimation"];
}

@end
