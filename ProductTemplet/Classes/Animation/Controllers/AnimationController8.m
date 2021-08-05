//
//  AnimationController8.m
//  NNAnimation
//
//  Created by BIN on 2018/9/20.
//  Copyright © 2018年 WHKJ. All rights reserved.
//

#import "AnimationController8.h"

static CGFloat count;

@interface AnimationController8 ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CALayer       *greenLayer;
@property (nonatomic, strong) CAShapeLayer  *redLayer;

@end

@implementation AnimationController8

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    [self.view.layer addSublayer:self.shapeLayer];

    [self createControls];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)createControls{
    
    self.greenLayer = ({
        
        CALayer *layer        = [CALayer layer];
        layer.bounds          = CGRectMake(0, 0, 200, 45);
        layer.position        = self.view.center;
        layer.backgroundColor = UIColor.greenColor.CGColor;
        
        layer;
    });
    
    self.redLayer = ({
        
        CAShapeLayer *layer   = [CAShapeLayer layer];
        layer.bounds          = CGRectMake(0, 0, 200, 45);
        layer.position        = self.view.center;
        layer.path            = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, count / 6 * 2, 45)].CGPath;
        layer.fillColor       = [UIColor redColor].CGColor;
        layer.fillRule        = kCAFillRuleEvenOdd;
        
        layer;
    });
    
    [self.view.layer addSublayer:self.greenLayer];
    [self.view.layer addSublayer:self.redLayer];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)action {
    
    count ++;
    self.redLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, count / 6 * 2, 45)].CGPath;
    
    if (count > 60 * 10 -1) {
        [self.displayLink invalidate];
    }
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
