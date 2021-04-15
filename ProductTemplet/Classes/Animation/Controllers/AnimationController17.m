//
//  AnimationController17.m
//  NNAnimation
//
//  Created by Bin Shang on 2019/1/18.
//  Copyright © 2019 世纪阳天. All rights reserved.
//

#import "AnimationController17.h"

@interface AnimationController17 ()

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UIImageView * imgView1;

@end

@implementation AnimationController17

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.imgView1];
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionGesture:)];
//    self.view.userInteractionEnabled = YES;
//    [self.view addGestureRecognizer:tap];
    
}
 
- (void)handleActionGesture:(UITapGestureRecognizer *)recognizer{
    
    DDLog(@"%@", @(recognizer.view.tag));
    UIView * fromView = recognizer.view.tag % 2 == 0 ? self.imgView : self.imgView1;
    UIView * toView = recognizer.view.tag % 2 == 0 ? self.imgView1 : self.imgView;
    [UIView transitionFromView:fromView toView:toView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        
    }];
//    UIView transitionWithView:<#(nonnull UIView *)#> duration:<#(NSTimeInterval)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>
    
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
            view.backgroundColor = UIColor.greenColor;
            view.tag = 0;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionGesture:)];
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:tap];
            
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

            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionGesture:)];
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:tap];
            view;
        });
    }
    return _imgView1;
}

@end
