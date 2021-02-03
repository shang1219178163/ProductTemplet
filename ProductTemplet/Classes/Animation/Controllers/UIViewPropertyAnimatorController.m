//
//  UIViewPropertyAnimatorController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/15.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UIViewPropertyAnimatorController.h"

#import <NNCategoryPro/NNCategoryPro.h>

#import "UIAlertController+Helper.h"

@interface UIViewPropertyAnimatorController ()

@property (nonatomic, strong) UIViewPropertyAnimator *animator;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, assign) CGFloat circleRadius;

@end

@implementation UIViewPropertyAnimatorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.circleRadius = 50;
    self.circleView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, self.circleRadius, self.circleRadius)];
    self.circleView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.circleView];
    
    
    @weakify(self);
    [self.circleView addGestureTap:^(UITapGestureRecognizer * _Nonnull reco) {
        @strongify(self);
        NSArray * list = @[@"bezierSystemAnimation",@"bezierCustomAnimation1",@"bezierCustomAnimation2",@"dampingSystemAnimation",@"dampingCustomeAnimation",];
        [UIAlertController createSheetTitle:@"请选择"
                                    message:@"提示信息"
                               actionTitles:list
                                    handler:^(UIAlertController *alertVC, UIAlertAction * _Nullable action) {
            if ([action.title isEqualToString:list[0]]) {
                if (@available(iOS 10.0, *)) {
                    self.animator = [[UIViewPropertyAnimator alloc]initWithDuration:1.5 curve:UIViewAnimationCurveLinear animations:^{
                        self.circleView.transform = CGAffineTransformMakeTranslation(kScreenWidth-2*self.circleRadius, 0);
                        
                    }];
                    DDLog(@"_%@_",@(self.animator.state));
                    [self.animator startAnimation];
                    DDLog(@"_%@__",@(self.animator.state));
                    
                }
                else {
                    // Fallback on earlier versions
                }
                
            }
            else if ([action.title isEqualToString:list[1]]) {
                if (@available(iOS 10.0, *)) {
                    self.animator = [[UIViewPropertyAnimator alloc]initWithDuration:3 controlPoint1:CGPointMake(0.2, 0.8) controlPoint2:CGPointMake(0.2, 0.8) animations:^{
                        self.circleView.transform = CGAffineTransformMakeTranslation(kScreenWidth-2*self.circleRadius, 0);
                        
                    }];
                    [self.animator startAnimation];
                }
                else {
                    // Fallback on earlier versions
                }
                
            }
            else if ([action.title isEqualToString:list[2]]) {
                if (@available(iOS 10.0, *)) {
                    UICubicTimingParameters * bezierParams = [[UICubicTimingParameters alloc]initWithControlPoint1:CGPointMake(0.2, 0.8) controlPoint2:CGPointMake(0.2, 0.8)];
                    self.animator = [[UIViewPropertyAnimator alloc]initWithDuration:3 timingParameters:bezierParams];
                    @weakify(self);
                    [self.animator addAnimations:^{
                        @strongify(self);
                        self.circleView.transform = CGAffineTransformMakeScale(3, 3);
                    }];
                    [self.animator addAnimations:^{
                        @strongify(self);
                        self.circleView.transform = CGAffineTransformMakeTranslation(kScreenWidth-2*self.circleRadius, 0);
                    }];
                    [self.animator startAnimation];
                }
                else {
                    // Fallback on earlier versions
                }
            }
            else if ([action.title isEqualToString:list[3]]) {
                if (@available(iOS 10.0, *)) {
                    self.animator = [[UIViewPropertyAnimator alloc]initWithDuration:3 dampingRatio:0.1 animations:^{
                        self.circleView.transform = CGAffineTransformMakeTranslation(self.view.center.x-self.circleRadius, 0);
                        
                    }];
                    [self.animator startAnimation];
                    
                }
                else {
                    // Fallback on earlier versions
                }
            }
            else if ([action.title isEqualToString:list[4]]) {
                if (@available(iOS 10.0, *)) {
                    UICubicTimingParameters * bezierParams = [[UISpringTimingParameters alloc]initWithDampingRatio:1 initialVelocity:CGVectorMake(1, 1)];
                    self.animator = [[UIViewPropertyAnimator alloc]initWithDuration:0.5 timingParameters:bezierParams];
                } else {
                    // Fallback on earlier versions
                }
                
                self.circleView.center = self.view.center;
                
                [self.animator addAnimations:^{
                    self.circleView.transform = CGAffineTransformMakeScale(3, 3);
                    self.circleView.alpha = 0.2;
                }];
                [self.animator startAnimation];
                
                if (@available(iOS 10.0, *)) {
                    [self.animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
                        self.circleView.alpha = 1.0;
//                    self.circleView.center = CGPointMake(self.circleRadius, self.circleView.center.y);
                        self.circleView.transform = CGAffineTransformMakeScale(1, 1);
                    }];
                } else {
                    // Fallback on earlier versions
                }
            }
        }];
    }];

}

- (void)handleAction{
 
    
//    if (@available(iOS 10.0, *)) {
//        self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:2.f curve:UIViewAnimationCurveLinear animations:^{
//            self.circleView.frame = CGRectMake(kScreenWidth - 100, 200, 100, 100);
//        }];
//        [self.animator startAnimation];
//    }
//    else {
//        // Fallback on earlier versions
//    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self handleAction];
    return;
    
    
}

@end
