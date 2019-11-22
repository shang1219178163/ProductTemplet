//
//  BNSecondViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "BNSecondViewController.h"


@interface BNSecondViewController ()

@end

@implementation BNSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createBarItemTitle:@"label" imgName:nil isLeft:NO isHidden:NO handler:^(id obj, id item, NSInteger idx) {
        
        UIViewController * controller = [NSClassFromString(@"CycleLabelViewController") new];

        CATransition *anim = [CATransition animDuration:0.5 functionName:kCAMediaTimingFunctionEaseIn type:kCATransitionFade subType:kCATransitionFromRight];
//        [UIApplication.sharedApplication.keyWindow.layer addAnimation:anim forKey:nil];
        [self.navigationController.view.layer addAnimation:anim forKey:nil];
        [self.navigationController pushViewController:controller animated:false];
//        [self goController:@"CycleLabelViewController" title:@"滚动lab"];

    }];
    
    
    UIViewController * controller = [NSClassFromString(@"FriendListController") new];
    [self addControllerVC:controller];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
