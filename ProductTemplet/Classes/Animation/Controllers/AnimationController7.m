//
//  AnimationController7.m
//  NNAnimation
//
//  Created by BIN on 2018/9/20.
//  Copyright © 2018年 WHKJ. All rights reserved.
//

#import "AnimationController7.h"

@interface AnimationController7 ()

@end

@implementation AnimationController7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createControls];
    
//    [self.view.layer addSublayer:self.shapeLayer];
//    self.shapeLayer.backgroundColor = UIColor.clearColor.CGColor;

    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    imgView.backgroundColor = UIColor.greenColor;
    
    [self.view addSubview:imgView];
    
    
    CAShapeLayer * layer = [imgView.layer createCircleLayer];
    layer.fillColor = UIColor.cyanColor.CGColor;
    
    [imgView.layer createAppCircleProgressWithStartAngle:1.5 * M_PI endAngle:1.8 * M_PI];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)createControls{
    
    CAShapeLayer *layer = ({
        
        CGRect rect = CGRectMake(0, 0, 100, 100);
        
        //创建矩形圆角正方形路径
        UIBezierPath * path   = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetHeight(rect)*0.1];
        
        //创建圆路径
        UIBezierPath * pathOutside = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 80, 80)];
    
        //内部弧路径
        UIBezierPath * pathInside  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50)
                                                                radius:35
                                                            startAngle:1.5 * M_PI
                                                              endAngle:1.7 * M_PI
                                                             clockwise:NO];
        [pathInside addLineToPoint:CGPointMake(50, 50)];
        [pathInside closePath];
        
        //合体
        [path appendPath:pathOutside];
        [path appendPath:pathInside];
        
        CAShapeLayer * layer = CAShapeLayer.layer;
        layer.bounds         = CGRectMake(0, 0, 100, 100);
        layer.position       = self.view.center;
        layer.path           = path.CGPath;
//        layer.fillColor      = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        layer.fillColor      = [UIColor.blackColor colorWithAlphaComponent:0.3].CGColor;
        layer.fillRule       = kCAFillRuleEvenOdd;  //重点， 填充规则
        
        layer;
    });
    
    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
