//
//  RecognizerController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/4.
//  Copyright © 2019 BN. All rights reserved.
//

#import "RecognizerController.h"

@interface RecognizerController ()

@property(nonatomic, strong) UIView *showView;

@end

@implementation RecognizerController

-(UIView *)showView{
    if (!_showView) {
        _showView = ({
            UIView * view = [[UIView alloc]initWithFrame:UIScreen.mainScreen.bounds];
            view.backgroundColor = UIColor.redColor;
            view.alpha = .5;
            
            CGRect frame = view.frame;
            frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);// 将x值改成负的屏幕宽度,默认就在屏幕的左边
            view.frame = frame;
//            // 因为该view是盖在所有的view身上,所以应该添加到window上
            [UIApplication.sharedApplication.keyWindow addSubview:view];
            
            // 添加轻扫手势  -- 滑回
            UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeShowView:)];
            recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
            [view addGestureRecognizer:recognizer];
            
            view;
        });
    }
    return _showView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"手势";
    
//    [self.view addSubview:self.showView];
    // 添加边缘手势
    UIScreenEdgePanGestureRecognizer *recoginzer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(showAd:)];
    // 指定左边缘滑动
    recoginzer.edges = UIRectEdgeLeft;
    
    [self.view addGestureRecognizer:recoginzer];
    // 如果ges的手势与collectionView手势都识别的话,指定以下代码,代表是识别传入的手势
//    [self.collectionView.panGestureRecognizer requireGestureRecognizerToFail:ges];
    
 //添加边缘手势
//    UIScreenEdgePanGestureRecognizer *screenEdgeGesOut = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenGesOut:)];
//    screenEdgeGesOut.edges = UIRectEdgeLeft;
//
//    [self.view addGestureRecognizer:screenEdgeGesOut];
//
//    UIScreenEdgePanGestureRecognizer *screenEdgeGesIn = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenGesIn:)];
//    screenEdgeGesIn.edges = UIRectEdgeRight;
//
//     [self.view addGestureRecognizer:screenEdgeGesIn];
}

//- (void)screenGesOut:(UIScreenEdgePanGestureRecognizer *)ges{
//
//}

- (void)showAd:(UIScreenEdgePanGestureRecognizer *)ges {
    // 让view跟着手指去移动
    // frame的x应该为多少??应该获取到手指的x值
    // 取到手势在当前控制器视图中识别的位置
    CGPoint point = [ges locationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(point));
    CGRect frame = self.showView.frame;
    // 更改adView的x值. 手指的位置 - 屏幕宽度
    frame.origin.x = point.x - CGRectGetWidth(UIScreen.mainScreen.bounds);
    self.showView.frame = frame;
    
    if (ges.state == UIGestureRecognizerStateEnded || ges.state == UIGestureRecognizerStateCancelled) {
        // 判断当前广告视图在屏幕上显示是否超过一半
        if (CGRectContainsPoint(self.view.frame, self.showView.center)) {
            // 如果超过,那么完全展示出来
            frame.origin.x = 0;
        }else{
            // 如果没有,隐藏
            frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.showView.frame = frame;
        }];
    }
}

- (void)closeShowView:(UISwipeGestureRecognizer *)recognizer {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = recognizer.view.frame;
        frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);
        recognizer.view.frame = frame;
    }];
}


@end
