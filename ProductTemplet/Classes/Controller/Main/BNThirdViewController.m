//
//  BNThirdViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "BNThirdViewController.h"
#import "BNCheckVersApi.h"
#import "BNAppInfoRootModel.h"

@interface BNThirdViewController ()

@end

@implementation BNThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self addChildControllerView:@"SliderTabBarController"];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    BNAppInfoRootModel *userModel = [BNCacheManager.shared objectForKey:kCacheKeyUserModel];
    DDLog(@"%@", userModel.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
