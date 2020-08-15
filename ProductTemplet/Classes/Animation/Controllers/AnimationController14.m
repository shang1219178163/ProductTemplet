//
//  AnimationController14.m
//  NNAnimation
//
//  Created by hsf on 2018/10/15.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import "AnimationController14.h"

@interface AnimationController14 ()

@property (nonatomic, strong) UIImageView * imgView;

@end

@implementation AnimationController14

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    imgView.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:imgView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionGesture:)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, CGRectGetMaxY(imgView.frame)+20, CGRectGetWidth(imgView.frame), 35);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleActionSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.imgView = imgView;
}
- (void)handleActionGesture:(UITapGestureRecognizer *)recognizer{

    NSLog(@"%@",recognizer.view.backgroundColor);
    
}


- (void)handleActionSender:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.imgView.backgroundColor = sender.selected == true ? UIColor.cyanColor : UIColor.greenColor;

    CGFloat r1 = CGRectGetWidth(self.imgView.frame);
    CGFloat r2 = CGRectGetHeight(self.imgView.frame);
    CGFloat radius = sqrt((r1 * r1) + (r2 * r2));
    UIBezierPath *bigCircleBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.imgView.frame, -radius, -radius)];
    UIBezierPath *smallCircleBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.imgView.center.x, self.imgView.center.y, 1, 1)];

    CGPathRef fromValue = sender.selected == true ? smallCircleBP.CGPath : bigCircleBP.CGPath;
    CGPathRef toValue = sender.selected == true ? bigCircleBP.CGPath : smallCircleBP.CGPath;

    //设置maskLayer
    CAShapeLayer *maskLayer = CAShapeLayer.layer;//将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    maskLayer.path = sender.selected == true ? bigCircleBP.CGPath : smallCircleBP.CGPath;
    self.imgView.layer.mask = maskLayer;
    
    //执行动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)fromValue;
    maskLayerAnimation.toValue = (__bridge id)toValue;
    maskLayerAnimation.duration = 1.35;
//    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}




@end
