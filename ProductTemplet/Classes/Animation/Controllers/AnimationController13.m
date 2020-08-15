//
//  AnimationController13.m
//  NNAnimation
//
//  Created by hsf on 2018/9/27.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import "AnimationController13.h"

@interface AnimationController13 ()

@property (nonatomic,strong)NSMutableArray *marr;
@property (nonatomic,strong)UIButton *homeBtn;

@end

@implementation AnimationController13

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self animationStyle1];

    [self.view getViewLayer];
}

#pragma mark -----效果1 --------
-(void)animationStyle1{
    
    _marr = [NSMutableArray array];
    
    [self createBtn:@[@"1",@"2",@"3",@"4",@"5"]];
    
    _homeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _homeBtn.frame=CGRectMake(30, 400, 40, 40);
    [_homeBtn setBackgroundImage:[UIImage imageNamed:@"chooser-button-tab"] forState:UIControlStateNormal];
    [_homeBtn addTarget:self action:@selector(startAnimSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeBtn];
    NSLog(@"初始----%@",[_homeBtn.layer valueForKeyPath:@"position"]);
    
}

-(void)startAnimSender:(UIButton *)sender{
    _homeBtn.selected=!_homeBtn.selected;
    if (_homeBtn.selected) {
        [self showBtn:sender];
    }else{
        [self hiddenBtn:sender];
    }
    
}

-(void)showBtn:(UIButton *)sender{
    for (int  i = 0; i<_marr.count-1; i++) {
        UIButton *btn=_marr[i];
        //        btn.transform=CGAffineTransformIdentity;
        
        CGPoint startPoint = sender.center;
        CGPoint endPoint =CGPointMake(startPoint.x, startPoint.y - 60*(_marr.count-i-1));
        //position animation
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration=.3;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
        positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
        positionAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_marr.count * (float)i);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        
        btn.layer.position=endPoint;
        
        //scale animation
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration=.3;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = @(0);
        scaleAnimation.toValue = @(1);
        scaleAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_marr.count * (float)i);
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:scaleAnimation forKey:@"transformscale"];
        btn.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
}

-(void)hiddenBtn:(UIButton *)sender{
    int index = 0;
    for (int  i = (int)_marr.count-1; i>=0; i--) {
        UIButton *btn=_marr[i];
        //        btn.transform=CGAffineTransformIdentity;
        //CGPoint startPoint = CGPointMake(49, 419);
        CGPoint startPoint = CGPointFromString([NSString stringWithFormat:@"%@",[btn.layer valueForKeyPath:@"position"]]);
        CGPoint endPoint = sender.center;
        //position animation
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration=.3;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
        positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
        positionAnimation.beginTime = CACurrentMediaTime() + (.3/(float)_marr.count * (float)index);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        //btn.layer.position=startPoint;
        
        //scale animation
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration=.3;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = @(1);
        scaleAnimation.toValue = @(1);
        scaleAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_marr.count * (float)index);
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:scaleAnimation forKey:@"transformscale"];
        btn.transform = CGAffineTransformMakeScale(1.f, 1.f);
        index++;
    }
}

-(void)createBtn:(NSArray *)btnImageName{
    
    for (int i = 0 ; i < btnImageName.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(30, 400, 40, 40);
        btn.backgroundColor=[UIColor lightGrayColor];
        btn.layer.cornerRadius=CGRectGetWidth(btn.frame)/2.0;
        [btn setTitle:btnImageName[i] forState:UIControlStateNormal];
        btn.tag=i+1;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [_marr addObject:btn];
    }
    
}

-(void)clickBtn:(UIButton *)btn{
    NSLog(@"tag__%ld",(long)btn.tag);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
