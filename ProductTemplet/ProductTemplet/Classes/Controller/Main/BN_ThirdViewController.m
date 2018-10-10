//
//  BN_ThirdViewController.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_ThirdViewController.h"

#import "UIViewController+Helper.h"

@interface BN_ThirdViewController ()

@end

@implementation BN_ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self BN_AddChildControllerView:@"SliderTabBarController"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
