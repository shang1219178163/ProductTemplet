//
//  AnimationController11.m
//  NNAnimation
//
//  Created by hsf on 2018/9/27.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import "AnimationController11.h"

@interface AnimationController11 ()

@end

@implementation AnimationController11


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title=@"圆形加载动画";
    
    //加载动画 范围0-1 可用于下载时显示
    [self animation1:.8];
    
    //loading动画
    [self animation2];
}

-(void)animation1:(CGFloat)toValue{
    CGRect rect = CGRectMake(100, 100, 100, 100);
    
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
    //先画一个圆
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=beizPath.CGPath;
    layer.fillColor=UIColor.clearColor.CGColor;//填充色
    layer.strokeColor=[UIColor redColor].CGColor;//边框颜色
    layer.lineWidth=6.0f;
    layer.lineCap=kCALineCapRound;//线框类型
    [self.view.layer addSublayer:layer];
    
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue=[NSNumber numberWithFloat:0.0f];
    animation.toValue=[NSNumber numberWithFloat:toValue];
    animation.duration=2.0;
    //animation.repeatCount=HUGE;//永久重复动画
    //animation.delegate=self;
    //removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
    //fillMode：决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后
    //autoreverses:动画结束时是否执行逆动画
    //timingFunction:设定动画的速度变化
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"animation"];
    
}

-(void)animation2{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(100, 300, 50, 50)];
    view.backgroundColor=UIColor.clearColor;
    [self.view addSubview:view];
    
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(25, 25) radius:25 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    //先画一个圆
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=beizPath.CGPath;
    layer.fillColor=UIColor.clearColor.CGColor;//填充色
    layer.strokeColor=[UIColor redColor].CGColor;//边框颜色
    layer.lineWidth=3.0f;
    layer.lineCap=kCALineCapRound;//线框类型
    [view.layer addSublayer:layer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue=@(0);
    animation.toValue=@(M_PI*2);
    animation.duration=.6;
    animation.repeatCount=HUGE;//永久重复动画
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [view.layer addAnimation:animation forKey:@"animation"];
}

-(void)animationDidStart:(CAAnimation *)anim{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
