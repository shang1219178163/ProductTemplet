//
//  UIRecognizerController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/4.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIRecognizerController.h"


@interface UIRecognizerController ()

@end

@implementation UIRecognizerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"边缘手势";
   
    [self addGesture];
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
    
//    [self.view addGesturePinch:^(id sender) {
//        DDLog(@"%@", sender);
//
//    }];

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

@end
