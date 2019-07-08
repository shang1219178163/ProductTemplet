//
//  AnimationController12.m
//  BN_Animation
//
//  Created by hsf on 2018/9/27.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import "AnimationController12.h"

@interface AnimationController12 ()

@property (nonatomic,strong)UIView *testView;
@property (nonatomic,strong)UIView *testView1;
@property (nonatomic,strong)UIBezierPath *path;

@end

@implementation AnimationController12

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //雷达，波纹效果
    [self setup];
    
    //绘制不规则图形
    [self myTest];
    
    [self.view getViewLayer];
}

- (void)setup{
    _testView=[[UIView alloc] initWithFrame:CGRectMake(30, 300, 200, 200)];
    [self.view addSubview:_testView];
    
    _testView.layer.backgroundColor = UIColor.clearColor.CGColor;
    //CAShapeLayer和CAReplicatorLayer都是CALayer的子类
    //CAShapeLayer的实现必须有一个path，可以配合贝塞尔曲线
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = _testView.layer.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.fillColor = [UIColor redColor].CGColor;//填充色
    pulseLayer.opacity = 0.0;
    
    //可以复制layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = _testView.bounds;
    replicatorLayer.instanceCount = 6;//创建副本的数量,包括源对象。
    replicatorLayer.instanceDelay = 1;//复制副本之间的延迟
    [replicatorLayer addSublayer:pulseLayer];
    [_testView.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @(1);
    opacityAnim.toValue = @(0.0);
    

    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnim.fromValue = @0.0;
    scaleAnim.toValue = @1.0;
    
    CAAnimationGroup *groupAnim = CAAnimationGroup.animation;
    groupAnim.animations = @[opacityAnim, scaleAnim];
    groupAnim.duration = 4.0;
    groupAnim.autoreverses = NO;
    groupAnim.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnim forKey:@"groupAnimation"];
}

-(void)myTest{
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 100, 400, 1)];
    line.backgroundColor=[UIColor grayColor];
    [self.view addSubview:line];
    
    _testView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 300, 200)];
    _testView1.userInteractionEnabled=YES;
    [self.view addSubview:_testView1];
    
    
    //贝塞尔曲线,以下是4个角的位置，相对于_testView1
    CGPoint point1= CGPointMake(10, 80);
    CGPoint point2= CGPointMake(10, 200);
    CGPoint point3= CGPointMake(300, 200);
    CGPoint point4= CGPointMake(300, 80);
    
    _path=[UIBezierPath bezierPath];
    [_path moveToPoint:point1];//移动到某个点，也就是起始点
    [_path addLineToPoint:point2];
    [_path addLineToPoint:point3];
    [_path addLineToPoint:point4];
    //controlPoint控制点，不等于曲线顶点
    [_path addQuadCurveToPoint:point1 controlPoint:CGPointMake(150, -30)];
    
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.path=_path.CGPath;
    shapeLayer.fillColor=UIColor.clearColor.CGColor;//填充颜色
    shapeLayer.strokeColor=[UIColor orangeColor].CGColor;//边框颜色
    [_testView1.layer addSublayer:shapeLayer];
    
    //动画
    CABasicAnimation *pathAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAniamtion.duration = 3;
    pathAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAniamtion.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAniamtion.toValue = [NSNumber numberWithFloat:1.0];
    pathAniamtion.autoreverses = NO;
    [shapeLayer addAnimation:pathAniamtion forKey:nil];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickk:)];
    [_testView1 addGestureRecognizer:tap];
    
}

-(void)clickk:(UITapGestureRecognizer *)tap{
    CGPoint point=[tap locationInView:_testView1];
    if ([_path containsPoint:point]) {
        NSLog(@"点击不规则图形");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
