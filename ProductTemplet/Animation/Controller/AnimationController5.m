//
//  AnimationController5.m
//  BN_Animation
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 WHKJ. All rights reserved.
//

#import "AnimationController5.h"

#import "CALayer+Helper.h"
#import "UIView+Animation.h"

@interface AnimationController5 ()

@property (weak, nonatomic)  UIButton *btnLog;

@end

@implementation AnimationController5

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"一个复杂一点的登录动画");
    [self.shapeLayer removeFromSuperlayer];
    
    UIButton *startButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor purpleColor];
        [btn setTitle:@"start" forState:UIControlStateNormal];
        btn.frame = (CGRect){{0, 0}, {200, 50}};
        btn.center = self.view.center;
        
        [btn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    [self.view addSubview:startButton];
    
    self.btnLog = startButton;
    
    UIImage *image = [UIImage imageNamed:@"Twitter"];
    startButton.backgroundColor = image.mostColor;
    startButton.titleLabel.textColor = UIColor.whiteColor;
    [startButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
}

- (void)startAction:(UIButton *)sender {
//    [self addMaskAnimationWithSender:sender];
    
    [sender addAnimLoginHandler:^{
        NSLog(@"--Login--");

    }];
    
    return;
//    CALayer *layer0 = [sender.layer addAnimMask:@"mask"];
//    CAAnimation * anim0 = [layer0 animationForKey:@"mask"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim0.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [layer0 removeFromSuperlayer];
//
//        CALayer *layer1 = [sender.layer addAnimPackup:@"Packup"];
//        CAAnimation * anim1 = [layer1 animationForKey:@"Packup"];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim1.duration* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [layer1 removeFromSuperlayer];
//            sender.hidden = YES;
//            CALayer *layer2 = [self.view.layer addAnimLoading:@"loading" duration:3];
//            CAAnimation * anim2 = [layer2 animationForKey:@"loading"];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim2.duration* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [layer2 removeAllAnimations];
//                [layer2 removeFromSuperlayer];
//
//                sender.hidden = NO;
//
//            });
//        });
//    });
    
}


//- (void)addMaskAnimationWithSender:(UIView *)sender{
//
//    CGPathRef path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetWidth(sender.bounds) / 2, 0, 1, CGRectGetHeight(sender.bounds))].CGPath;//不初始化则无动画效果
//    CAShapeLayer *shapeLayer = [CAShapeLayer layerWithSender:sender.layer path:path fillColor:UIColor.whiteColor strokeColor:UIColor.whiteColor opacity:0.3];
//    [sender.layer addSublayer:shapeLayer];
//
//
//    CGPathRef toValue = [UIBezierPath bezierPathWithRect:sender.bounds].CGPath;
//    CABasicAnimation *anim = [CABasicAnimation animKeyPath:@"path" duration:0.5 fromValue:nil toValue:(__bridge id)toValue autoreverses:NO repeatCount:1];
//    [shapeLayer addAnimation:anim forKey:@"shapeAnimation"];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [shapeLayer removeFromSuperlayer];
//        [self addPackupAnimationWithSender:sender];
//    });
//
//    NSLog(@"%@_%@_%@",NSStringFromSelector(_cmd),@(sender.bounds),@(sender.layer.bounds));
//}
//
//- (void)addPackupAnimationWithSender:(UIView *)sender{
//
//    CAShapeLayer *maskLayer = CAShapeLayer.layer;
//    maskLayer.frame = sender.bounds;
//    sender.layer.mask = maskLayer;
//
//    //path动画
//    CGPoint point = CGPointMake(CGRectGetWidth(sender.bounds) / 2, CGRectGetHeight(sender.bounds) / 2);
//    CGPathRef fromValue = [UIBezierPath bezierPathWithArcCenter:point radius:CGRectGetWidth(sender.bounds) / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
//    CGPathRef toValue = [UIBezierPath bezierPathWithArcCenter:point radius:1 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
//    CABasicAnimation *pathAnim = [CABasicAnimation animKeyPath:kTransformPath duration:0.3 fromValue:(__bridge id)(fromValue) toValue:(__bridge id)(toValue) autoreverses:NO repeatCount:1];
//
//
//    CAAnimationGroup *groupAnim = [CAAnimationGroup animList:@[pathAnim] duration:0.3 autoreverses:NO repeatCount:1];
//    [maskLayer addAnimation:groupAnim forKey:@"groupAnim"];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        sender.hidden = YES;
//        [maskLayer removeFromSuperlayer];
//        [self addLoadingAnimationWithSender:self.view];
//
//    });
//}
//
//- (void)addLoadingAnimationWithSender:(UIView *)sender{
//    CAShapeLayer *shapeLayer =  ({
//        CAShapeLayer *layer = CAShapeLayer.layer;
//        layer.position = sender.center;
//        layer.bounds = CGRectMake(0, 0, 50, 50);
//        layer.backgroundColor = UIColor.clearColor.CGColor;
//        layer.strokeColor = UIColor.redColor.CGColor;
//        layer.fillColor = UIColor.clearColor.CGColor;
//        layer.lineWidth = 5.f;
//        UIBezierPath *storkePath = [UIBezierPath bezierPathWithOvalInRect:layer.bounds];
//        layer.path = storkePath.CGPath;
//        layer.strokeStart = 0;
//        layer.strokeEnd = 0.1;
//
//        layer;
//    });
//
//    [sender.layer addSublayer:shapeLayer];
//
//    //旋转动画
//    CABasicAnimation *rotateAnim = [CABasicAnimation animKeyPath:kTransformRotationZ duration:1 fromValue:nil toValue:@(M_PI * 2) autoreverses:NO repeatCount:CGFLOAT_MAX];
//
//    //stroke动画
//    CABasicAnimation *storkeAnim = [CABasicAnimation animKeyPath:@"strokeEnd" duration:2.0 fromValue:nil toValue:@1 autoreverses:NO repeatCount:CGFLOAT_MAX];
//
//    CAAnimationGroup *groupAnim = [CAAnimationGroup animList:@[rotateAnim, storkeAnim] duration:2 autoreverses:NO repeatCount:CGFLOAT_MAX];
//    [shapeLayer addAnimation:groupAnim forKey:@"indicatorAnimation"];
//}


@end
