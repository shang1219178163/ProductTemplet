//
//  HomeViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/13.
//  Copyright © 2018 BN. All rights reserved.
//

#import "HomeViewController.h"

#import <NNCategoryPro/NNCategoryPro.h>

@interface HomeViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *btnList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBar.tintColor = UIColor.themeColor;
//    self.tabBar.barTintColor = UIColor.whiteColor;
  
    NSArray *list = @[@[@"NNFirstViewController", @"首页", @"Item_first_N", @"Item_first_H",@"0",],
                      @[@"NNSecondViewController", @"圈子", @"Item_second_N", @"Item_second_H",@"11",],
                      @[@"NNCenterViewController", @"总览", @"Item_center_N", @"Item_center_H",@"10",],
                      @[@"NNThirdViewController", @"消息", @"Item_third_N", @"Item_third_H",@"12",],
                      @[@"NNFourthViewController", @"我的", @"Item_fourth_N", @"Item_fourth_H",@"13",],
//                      @[@"ScrollHorizontalController", @"test", @"Item_fourth_N", @"Item_fourth_H",@"13",],
//                      @[@"LineDashViewController", @"test", @"Item_fourth_N", @"Item_fourth_H",@"13",],
//                      @[@"SearchTitleViewController", @"test", @"Item_fourth_N", @"Item_fourth_H",@"13",],
//                      @[@"TestViewController", @"test", @"Item_fourth_N", @"Item_fourth_H",@"13",],
//                      @[@"NNFileUploadController", @"test", @"Item_fourth_N", @"Item_fourth_H",@"13",],

                      
                      
                      ];
    self.viewControllers = UINavListFromList(list);
    self.selectedIndex = 4;
    
    self.delegate = self;
    self.moreNavigationController.navigationBarHidden = YES;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UINavigationController*)viewController {

//    /// 特殊处理 - 是否需要登录
//    BOOL isBaiDuService = [viewController.topViewController isKindOfClass:[MPDiscoveryViewController class]];
//    if (isBaiDuService) {
//        NSLog(@"你点击了TabBar第二个");
//    }
    return YES;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    NSInteger idx = [self.tabBar.items indexOfObject:item];
//    UIView *view = self.btnList[idx];
//    [UIView animateWithDuration:0.15 animations:^{
//        view.transform = CGAffineTransformScale(view.transform, 1.2, 1.2);
//
//    } completion:^(BOOL finished) {
//        view.transform = CGAffineTransformIdentity;
//
//    }];
}

-(NSArray *)btnList {
    if (!_btnList){
        _btnList = [self.tabBar findSubview:kUITabBarButton];
    }
    return _btnList;
}



@end
