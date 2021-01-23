//
//  NNAnimationController.m
//  HuiZhuBang
//
//  Created by hsf on 2018/9/19.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NNAnimationController.h"


@interface NNAnimationController ()<CAAnimationDelegate>

@property (nonatomic, strong) void(^block)(id obj, id item, NSInteger idx);

@end

@implementation NNAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = self.title ?  : self.vcName;
    self.title = @"购物动画";
    
//    [self circleView];
    
//    CAShapeLayer * layer = [self createCircleShapeLayer];
//    [self.view.layer addSublayer:layer];
//    
//    return;
    
    [self createControls];
    
}

-(void)createControls{
    NSArray * elements = @[@"1",@"2",@"3",@"4"];
    UIView * groupView = [self createViewWithRect:CGRectMake(10, 50, kScreenWidth - 20, 50) items:elements numberOfRow:4 itemHeight:40 padding:kPadding];

    [self.view addSubview:groupView];

    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 50)/2.0, CGRectGetMidY(self.view.frame), 50, 50)];
    imgView.image = [UIImage imageNamed:@"Twitter_round@2x"];
    [self.view addSubview:imgView];
    
    UIImageView * backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    backView.center = imgView.center;
    backView.backgroundColor = UIColor.greenColor;
    [self.view insertSubview:backView belowSubview:imgView];

}


- (void)clickAddShopCartBtn:(UIButton *)sender {
    CGPoint end = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame) - 40);
    [self.view addAnimCartWithSender:sender pointEnd:end];
    
}


- (void)circleView{
    CALayer *layer = CALayer.layer;
    layer.backgroundColor = UIColor.greenColor.CGColor; //圆环底色
    layer.frame = CGRectMake(100, 100, 110, 110);
    
    
    //创建一个圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(55, 55) radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //圆环遮罩
    CAShapeLayer *shapeLayer = CAShapeLayer.layer;
    shapeLayer.fillColor = UIColor.grayColor.CGColor;
    shapeLayer.strokeColor = UIColor.blueColor.CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0.8;
    shapeLayer.lineCap = @"round";
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    layer.mask = shapeLayer;

    //颜色渐变
    CAGradientLayer *gradientLayer = CAGradientLayer.layer;
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(50, 50, 60, 60);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(id)UIColor.redColor.CGColor,(id)UIColor.whiteColor.CGColor];
    gradientLayer.locations = @[@(0.6), @(0.4),];

    [layer addSublayer:gradientLayer]; //设置颜色渐变
    [self.view.layer addSublayer:layer];
    
//    layer.shadowPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:30 startAngle:0 endAngle:M_PI*2-0.34 clockwise:YES].CGPath;
//    layer.position = self.view.center;
//    [layer addAnimationRotation];
//    return;
    //动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animKeyPath:kTransformScale duration:0.8 fromValue:@(1.0) toValue:@(1.0) autoreverses:NO repeatCount:MAXFLOAT];
    
    CABasicAnimation *rotationAnim = [CABasicAnimation animKeyPath:kTransformRotationZ duration:1 fromValue:@(0) toValue:@(2*M_PI) autoreverses:NO repeatCount:MAXFLOAT];

    NSArray * animations = @[scaleAnim, rotationAnim];
    //组合动画
//    CAAnimationGroup *groupAnnim = [CAAnimationGroup animList:animations duration:1 autoreverses:NO repeatCount:MAXFLOAT];
//    [layer addAnimation:groupAnnim forKey:@"groupAnnimation"];
    
    [layer getLayer];
}


- (CAShapeLayer *)createCircleShapeLayer{
    //创建圆路径
    UIBezierPath * circleP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 80, 80)];
    
    CAShapeLayer * layer = CAShapeLayer.layer;
    layer.bounds         = CGRectMake(0, 0, 100, 100);
    layer.position       = self.view.center;
    layer.path           = circleP.CGPath;
    layer.strokeColor    = [UIColor.redColor colorWithAlphaComponent:1].CGColor;
    layer.lineWidth      = 1;
    layer.strokeStart    = 0;
    layer.strokeEnd      = 0;
    layer.fillColor      = UIColor.greenColor.CGColor;
    layer.fillRule       = kCAFillRuleEvenOdd;
    
    return layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createViewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding{
    
    //    CGFloat padding = 15;
    //    CGFloat viewHeight = 30;
    //    NSInteger numberOfRow = 4;
    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(rect) - (numberOfRow-1)*padding)/numberOfRow;
    itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
    
    //
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * itemHeight + (rowCount - 1) * padding)];
    backgroudView.backgroundColor = UIColor.yellowColor;
    
    for (NSInteger i = 0; i< items.count; i++) {
        
        CGFloat w = itemWidth;
        CGFloat h = itemHeight;
        CGFloat x = (i % numberOfRow) * (w + padding);
        CGFloat y = (i / numberOfRow) * (h + padding);
        
        NSString * title = items[i];
        CGRect itemRect = CGRectMake(x, y, w, h);
        
        UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.frame = itemRect;
        [view setTitle:title forState:UIControlStateNormal];
        [view setTitleColor:UIColor.redColor forState:UIControlStateNormal];
//        [view setBackgroundColor:UIColor.yellowColor];
        [view addTarget:self action:@selector(handleActionSender:) forControlEvents:UIControlEventTouchUpInside];
        [backgroudView addSubview:view];
        
    }
    return backgroudView;
}

- (void)handleActionSender:(UIButton *)sender{
    [self clickAddShopCartBtn:sender];

}

@end
