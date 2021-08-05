//
//  UIRecognizerController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/4.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIRecognizerController.h"


@interface UIRecognizerController ()<UIGestureRecognizerDelegate>

@property (retain, nonatomic) UIImageView *imgView;

@property (retain, nonatomic) UILabel *labPoint;
@property (retain, nonatomic) UILabel *labRotation;
@property (retain, nonatomic) UILabel *labScale;

@end

@implementation UIRecognizerController

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imgView.image = UIImageNamed(@"Skull.jpg");
    }
    return _imgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"边缘手势";
   
    
    self.imgView.frame = CGRectMake(0, 0, 200, 400);
    self.imgView.center = self.view.center;
    [self.view addSubview:self.imgView];
    
    
    [self.imgView addGestureTap:^(UITapGestureRecognizer * _Nonnull reco) {
        DDLog(@"%@", @(reco.view.tag));
    }];
    
    UIPanGestureRecognizer *pan = [self.imgView addGesturePan:^(id sender) {
        DDLog(@"%@", sender);
//        UIPanGestureRecognizer *recognizer = sender;

    }];
    pan.delegate = self;
    
    UIPinchGestureRecognizer *pinch = [self.imgView addGesturePinch:^(id sender) {
        DDLog(@"%@", sender);
//        UIPinchGestureRecognizer *recognizer = sender;

        
    }];
    pinch.delegate = self;

    
    UIRotationGestureRecognizer *rotation = [self.imgView addGestureRotation:^(id sender) {
        DDLog(@"%@", sender);
//        UIRotationGestureRecognizer *recognizer = sender;

    }];
    rotation.delegate = self;

    
//    [self addGesture];
    return;
    [self.view addRecognizerEdgPan:^(UIScreenEdgePanGestureRecognizer * _Nonnull recognizer) {
//        DDLog(@"%@",recognizer);
//        DDLog(NSStringFromCGRect(self.view.showView.frame));
    }];
}

- (void)addGesture {
//    [self.view addGestureTap:^(id sender) {
//        DDLog(@"%@", sender);
//    }];
//
//    [self.view addGestureSwipe:^(id sender) {
//        DDLog(@"%@", sender);
//
//    } forDirection:UISwipeGestureRecognizerDirectionLeft];
//
//    [self.view addGestureSwipe:^(id sender) {
//        DDLog(@"%@", sender);
//
//    } forDirection:UISwipeGestureRecognizerDirectionRight];
    
    
//    [self.view addGesturePan:^(id sender) {
//        DDLog(@"%@", sender);
//
//    }];
    
    [self.view addGesturePinch:^(id sender) {
        DDLog(@"%@", sender);

    }];

//    [self.view addGestureLongPress:^(id sender) {
//        DDLog(@"%@", sender);
//
//    } forDuration:.5];
    
    [self.view addGestureEdgPan:^(id sender) {
        DDLog(@"%@", sender);

    } forEdges:UIRectEdgeLeft];

    [self.view addGestureEdgPan:^(id sender) {
        DDLog(@"%@", sender);
        
    } forEdges:UIRectEdgeRight];
    
}

//一个视图同时响应多个手势需要实现的方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return NO;
    }
//    return YES;
}

@end
