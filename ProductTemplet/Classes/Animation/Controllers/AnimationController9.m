//
//  AnimationController9.m
//  NNAnimation
//
//  Created by hsf on 2018/9/25.
//  Copyright © 2018年 whkj. All rights reserved.
//

#import "AnimationController9.h"

@interface AnimationController9 ()<CAAnimationDelegate>

@end

@implementation AnimationController9

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    imageView.backgroundColor = UIColor.redColor;
    [self.view addSubview:imageView];

    UIImage *image = [UIImage imageNamed:@"Googleplus"];
    UIImage *backImage = [UIImage imageNamed:@"Twitter"];
    [imageView addFlipAnimtion:image backImage:backImage];
    
//    [imageView addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:nil];
//
//    CABasicAnimation * rotationAnim = [CABasicAnimation animKeyPath:kTransformRotationY duration:2 fromValue:@0 toValue:@(2*M_PI) autoreverses:NO repeatCount:CGFLOAT_MAX];
//    rotationAnim.delegate = self;
//    [imageView.layer addAnimation:rotationAnim forKey:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -CAAnimation
- (void)animationDidStart:(CAAnimation *)anim{
    if ([anim isKindOfClass:[CABasicAnimation class]]) {
        CABasicAnimation *anim = (CABasicAnimation *)anim;
        NSLog(@"%@", anim.byValue);
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    
}
@end
