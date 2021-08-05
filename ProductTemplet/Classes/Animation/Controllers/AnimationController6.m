//
//  AnimationController6.m
//  NNAnimation
//
//  Created by BIN on 2018/9/20.
//  Copyright © 2018年 WHKJ. All rights reserved.
//

#import "AnimationController6.h"

#import "NNRotationView.h"

@interface AnimationController6 ()

@property (nonatomic, strong) NNRotationView * rotaionView;

@end

@implementation AnimationController6

-(NNRotationView *)rotaionView{
    if (!_rotaionView) {
        _rotaionView = [[NNRotationView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
//        _rotaionView = [[NNRotationView alloc]init];

    }
    return _rotaionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    
    self.rotaionView.frame = CGRectMake(50, 50, 100, 100);
    [self.view addSubview:self.rotaionView];
    
    self.rotaionView.imgView.image = [UIImage imageNamed:@"Pinterest"];
    self.rotaionView.imgView.image = [UIImage imageNamed:@"Facebook"];

//    self.rotaionView.layerFront.strokeColor = self.rotaionView.imgView.image.mostColor.CGColor;

    
//    self.rotaionView.layerFront.strokeColor = UIColor.greenColor.CGColor;
//    self.rotaionView.backgroundColor = UIColor.greenColor;
//    [self.rotaionView.layer getLayer];
    
    [self createControls];
}

- (void)createControls{
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imgView.center = self.view.center;
    imgView.image = [UIImage imageNamed:@"Twitter"];
    [self.view addSubview:imgView];
    

    //layer
    CGRect rect = CGRectMake(10, 10, 115, 115);
    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){{0, 0}, rect.size}].CGPath; //设置绘制路径
    CAShapeLayer *shapeLayer = [CAShapeLayer layerWithRect:rect path:path strokeEnd:0.5 fillColor:UIColor.clearColor strokeColor:UIColor.redColor lineWidth:1];
    shapeLayer.strokeColor = imgView.image.mostColor.CGColor;
    shapeLayer.position = imgView.center;
    //以subLayer的形式添加给self.view
    [self.view.layer addSublayer:shapeLayer];
    
    //layerBack
    UIColor * colorBack = [UIColor colorWithWhite:0.8 alpha:0.5];
    CAShapeLayer *shapeLayerBack = [CAShapeLayer layerWithRect:rect path:path strokeEnd:1 fillColor:UIColor.clearColor strokeColor:colorBack lineWidth:2];
    shapeLayerBack.position = imgView.center;
    [self.view.layer insertSublayer:shapeLayerBack below:shapeLayer];

    [self.view bringSubviewToFront:imgView];
    
    //旋转动画
    CABasicAnimation * animation = [CABasicAnimation animKeyPath:kTransformRotationZ duration:2 fromValue:nil toValue:@(M_PI*2.0) autoreverses:NO repeatCount:CGFLOAT_MAX];
    //    self.layer.anchorPoint = CGPointMake(0.5, 0.5);//锚点设置为图片中心，绕中心抖动
    [shapeLayer addAnimation:animation forKey:@"rotationAnim"];
    return;
    
    //设置animation
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @0.2;
    strokeAnimation.toValue = @0.8;
    strokeAnimation.duration = 1;
    strokeAnimation.autoreverses = YES;
    strokeAnimation.fillMode = kCAFillModeForwards;
    strokeAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.fromValue = @2;
    lineWidthAnimation.toValue = @10;
    lineWidthAnimation.duration = 1;
    lineWidthAnimation.autoreverses = YES;
    
    
    CABasicAnimation *strokeColorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeColorAnimation.fromValue = (id)UIColor.greenColor.CGColor;
    strokeColorAnimation.toValue = (id)UIColor.blueColor.CGColor;
    strokeColorAnimation.duration = 0.5;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation, strokeAnimation, lineWidthAnimation];
    group.duration = 1;
    group.repeatCount = CGFLOAT_MAX;//旋转次数
    
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [shapeLayer addAnimation:group forKey:@"groupAnim"];
}

@end
