//
//  NNSecondViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NNSecondViewController.h"


@interface NNSecondViewController ()

@end

@implementation NNSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.rightBarButtonItems = [@[@"one", @"two"] map:^id _Nonnull(id  _Nonnull obj, NSUInteger idx) {
        return [UIBarButtonItem customViewWithButton:obj
                                             handler:^(UIButton * _Nonnull sender) {
            if (idx == 0) {
                [self jump];
            }
            DDLog(@"obj: %@", obj);
        }];
    }];
    
    UIViewController *vc = [NSClassFromString(@"FriendListController") new];
    [self addControllerVC:vc];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:animated];
//    hud.label.text = NSLocalizedString(kNetWorkRequesting, @"HUD loading title");
//    
//    [hud hideAnimated:YES afterDelay:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)jump {
    UIViewController *vc = [NSClassFromString(@"CycleLabelViewController") new];
    CATransition *anim = [CATransition animateWithDuration:0.5
                                              functionName:kCAMediaTimingFunctionEaseIn
                                                      type:kCATransitionFade
                                                   subType:kCATransitionFromRight];
//        [UIApplication.sharedApplication.keyWindow.layer addAnimation:anim forKey:nil];
    [self.navigationController.view.layer addAnimation:anim forKey:nil];
    [self.navigationController pushViewController:vc animated:false];
}


@end
