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

    
    NSArray<NSDictionary<NSString *, NSString *> *> *list = @[
    @{
        UITabBarItem.KeyVC: @"NNFirstViewController",
        UITabBarItem.KeyTitle: @"首页",
        UITabBarItem.KeyImage: @"Item_first_N",
        UITabBarItem.KeyImageSelected: @"Item_first_H",
        UITabBarItem.KeyBadgeValue: @"0",},
    @{
        UITabBarItem.KeyVC: @"NNSecondViewController",
        UITabBarItem.KeyTitle: @"圈子",
        UITabBarItem.KeyImage: @"Item_second_N",
        UITabBarItem.KeyImageSelected: @"Item_second_H",
        UITabBarItem.KeyBadgeValue: @"11",},
    @{
        UITabBarItem.KeyVC: @"NNCenterViewController",
        UITabBarItem.KeyTitle: @"总览",
        UITabBarItem.KeyImage: @"Item_center_N",
        UITabBarItem.KeyImageSelected: @"Item_center_H",
        UITabBarItem.KeyBadgeValue: @"10",},
    @{
        UITabBarItem.KeyVC: @"NNThirdViewController",
        UITabBarItem.KeyTitle: @"消息",
        UITabBarItem.KeyImage: @"Item_third_N",
        UITabBarItem.KeyImageSelected: @"Item_third_H",
        UITabBarItem.KeyBadgeValue: @"12",},
    @{
        UITabBarItem.KeyVC: @"NNFourthViewController",
        UITabBarItem.KeyTitle: @"我的",
        UITabBarItem.KeyImage: @"Item_fourth_N",
        UITabBarItem.KeyImageSelected: @"Item_fourth_H",
        UITabBarItem.KeyBadgeValue: @"13",},
    ];
    
    self.viewControllers = [list map:^id _Nonnull(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx) {
        NSString *vcName = obj[UITabBarItem.KeyVC];
        NSString *title = obj[UITabBarItem.KeyTitle];
        NSString *imageName = obj[UITabBarItem.KeyImage];
        NSString *selectedImageName = obj[UITabBarItem.KeyImageSelected];
        NSString *badgeValue = obj[UITabBarItem.KeyBadgeValue];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        assert(vc);
        UIViewController *tabItemVC = [vc isKindOfClass: UINavigationController.class] ? vc : [[UINavigationController alloc]initWithRootViewController:vc];
//        tabItemVC.tabBarItem = [[UITabBarItem alloc]initWithTitle: title
//                                                            image: [[UIImage imageNamed: imageName] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]
//                                                    selectedImage: [[UIImage imageNamed: selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
//                                ];
//        tabItemVC.tabBarItem.badgeValue = badgeValue;
//        tabItemVC.tabBarItem.badgeColor = tabItemVC.tabBarItem.badgeValue > 0 ? UIColor.redColor : UIColor.clearColor;

        [tabItemVC reloadTabarItem:title imageName:imageName selectedImageName:selectedImageName];
        [tabItemVC updateBadgeValue:badgeValue];
        return tabItemVC;
    }];

//    self.viewControllers = UINavListFromList(list);
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
