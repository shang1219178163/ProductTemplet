//
//  AnimationController18.m
//  NNAnimation
//
//  Created by Bin Shang on 2019/1/18.
//  Copyright © 2019 世纪阳天. All rights reserved.
//

#import "AnimationController18.h"

@interface AnimationController18 ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UIImageView * imgView1;
@property (nonatomic, strong) UIImageView * containerView;

@property (nonatomic, assign) UINavigationControllerOperation type;

@property (nonatomic, strong) UIImageView * imgView2;
@property (nonatomic, strong) UIImageView * imgView3;

@end

@implementation AnimationController18

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    [self.containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [self.view addSubview:self.containerView];
    DDLog(@"_%p_%p_",self.imgView,self.imgView1);

    
    self.imgView2.frame = CGRectMake(20, CGRectGetMaxY(self.containerView.frame)+20, 150, 150);
    self.imgView2.backgroundColor = UIColor.randomColor;
    [self.view addSubview:self.imgView2];
    
    [self.imgView2 addGestureTap:^(UIGestureRecognizer *recognizer) {
        UIBezierPath *smallCircleBP = [recognizer pathBigCircle:false];
        UIBezierPath *bigCircleBP = [recognizer pathBigCircle:true];

        CAShapeLayer * toViewMask = [recognizer layerBigCircle:true];
        CABasicAnimation *toViewMaskAnim = [CABasicAnimation animKeyPath:@"path" duration:1.5 fromValue:(id)smallCircleBP.CGPath toValue:(id)bigCircleBP.CGPath];
        [toViewMask addAnimation:toViewMaskAnim forKey:@"path"];
        recognizer.view.layer.mask = toViewMask;
    }];
    
   
    self.imgView3.frame = CGRectMake(CGRectGetMaxX(self.imgView2.frame)+20, CGRectGetMaxY(self.containerView.frame)+20, 150, 150);
    self.imgView3.backgroundColor = UIColor.randomColor;
    [self.view addSubview:self.imgView3];
    
    [self.imgView3 addGestureTap:^(UIGestureRecognizer *recognizer) {
        UIBezierPath *smallCircleBP = [recognizer pathBigCircle:false];
        UIBezierPath *bigCircleBP = [recognizer pathBigCircle:true];
        
        CAShapeLayer * toViewMask = [recognizer layerBigCircle:false];
        CABasicAnimation *toViewMaskAnim = [CABasicAnimation animKeyPath:@"path" duration:1.5 fromValue:(id)bigCircleBP.CGPath toValue:(id)smallCircleBP.CGPath];
        [toViewMask addAnimation:toViewMaskAnim forKey:@"path"];
        recognizer.view.layer.mask = toViewMask;
    }];
    
    [self.view getViewLayer];
}

- (void)handleActionGesture:(UITapGestureRecognizer *)recognizer{
    
    BOOL isPush = recognizer.view.tag % 2 == 0 ? true : false;
    UIView * fromView = isPush ? self.imgView : self.imgView1;
    UIView * toView = isPush ? self.imgView1 : self.imgView;
    self.type = isPush == true ? UINavigationControllerOperationPush : UINavigationControllerOperationPop ;
    
    DDLog(@"_%p_%p_%@_", fromView, toView,@(recognizer.view.tag));
    
    CGRect circleRect = [recognizer cirlceRectBigCircle:false];
    CGRect bigCircleRect = [recognizer cirlceRectBigCircle:true];
    UIBezierPath *smallCircleBP = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    UIBezierPath *bigCircleBP = [UIBezierPath bezierPathWithOvalInRect:bigCircleRect];

    //跳转到新视图
    if (self.type == UINavigationControllerOperationPush) {
        //1.把 页面二 加到内容页
        if ([self.containerView.subviews containsObject:toView]) {
            [self.containerView bringSubviewToFront:toView];
        } else {
            [self.containerView addSubview:toView];
        }

        CAShapeLayer * toViewMask = [CAShapeLayer layerWithPath:bigCircleBP];
        CABasicAnimation *toViewMaskAnim = [CABasicAnimation animKeyPath:@"path" duration:1.5 fromValue:(id)smallCircleBP.CGPath toValue:(id)bigCircleBP.CGPath];
        [toViewMask addAnimation:toViewMaskAnim forKey:@"path"];
        toView.layer.mask = toViewMask;
    }
    //返回
    else{
        [self.containerView sendSubviewToBack:toView];

        //1.把 页面一 加入到视图 同时挪到当前视图后面
        CAShapeLayer * fromViewMask = [CAShapeLayer layerWithPath:smallCircleBP];
        CABasicAnimation *fromViewMaskAnim = [CABasicAnimation animKeyPath:@"path" duration:1.5 fromValue:(id)bigCircleBP.CGPath toValue:(id)smallCircleBP.CGPath];
        [fromViewMask addAnimation:fromViewMaskAnim forKey:@"path"];
        fromView.layer.mask = fromViewMask;

    }
    
}

#pragma mark -  CABasicAnimation的Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    for (UIView *subView in self.containerView.subviews) {
        subView.layer.mask = nil;
    }
   
    if (self.type == UINavigationControllerOperationPush) {
        self.type = UINavigationControllerOperationPop;
    }else{
        self.type = UINavigationControllerOperationPush;

    }
}

- (UIImageView *)containerView{
    if (!_containerView) {
        _containerView = ({
            UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 300, 300)];
            view.userInteractionEnabled = true;
            
            view;
        });
        
        self.imgView.frame = _containerView.bounds;
        self.imgView1.frame = _containerView.bounds;
        [_containerView addSubview:self.imgView];
        [_containerView addSubview:self.imgView1];
    }
    return _containerView;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
            view.backgroundColor = UIColor.greenColor;
            view.tag = 0;
            
            [view addGestureTap:^(UIGestureRecognizer *sender) {
                [self handleActionGesture:(UITapGestureRecognizer *)sender];
                
            }];
            
            view;
        });
    }
    return _imgView;
}

-(UIImageView *)imgView1{
    if (!_imgView1) {
        _imgView1 = ({
            UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
            view.backgroundColor = UIColor.yellowColor;
            view.tag = 1;
            [view addGestureTap:^(UIGestureRecognizer *sender) {
                [self handleActionGesture:(UITapGestureRecognizer *)sender];
                
            }];
            view;
        });
    }
    return _imgView1;
}

-(UIImageView *)imgView2{
    if (!_imgView2) {
        _imgView2 = ({
            UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
            view.backgroundColor = UIColor.yellowColor;
            view.tag = 2;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionGesture:)];
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:tap];
            view;
        });
    }
    return _imgView2;
}

-(UIImageView *)imgView3{
    if (!_imgView3) {
        _imgView3 = ({
            UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
            view.backgroundColor = UIColor.yellowColor;
            view.tag = 3;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionGesture:)];
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:tap];
            view;
        });
    }
    return _imgView3;
}

@end
