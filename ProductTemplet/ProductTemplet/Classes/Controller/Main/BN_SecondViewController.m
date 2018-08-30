//
//  BN_SecondViewController.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_SecondViewController.h"

@interface BN_SecondViewController ()

@end

@implementation BN_SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createBarBtnItemWithTitle:@"label" imageName:nil isLeft:NO isHidden:NO handler:^(id obj, id item, NSInteger idx) {
        [self goController:@"LabelViewController" title:@"滚动lab"];

    }];
    
    
    UIViewController * controller = [NSClassFromString(@"FriendListController") new];
    [self addChildViewController:controller];
    
    [self.view addSubview:controller.view];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:animated];
//    hud.label.text = NSLocalizedString(kMsg_NetWorkRequesting, @"HUD loading title");
//    
//    [hud hideAnimated:YES afterDelay:3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end