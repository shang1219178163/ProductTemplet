//
//  SubTabBarController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/9.
//  Copyright © 2019 BN. All rights reserved.
//

#import "SubTabBarController.h"

@implementation SubTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSArray *list = @[
                      @[@"NNFourthViewController",@"我的",@"Item_fourth_N",@"Item_fourth_H",@"13",],
                      @[@"NNFirstViewController",@"首页",@"Item_first_N",@"Item_first_H",@"0",],
                      @[@"NNSecondViewController",@"圈子",@"Item_second_N",@"Item_second_H",@"11",],
                      @[@"NNCenterViewController",@"总览",@"Item_center_N",@"Item_center_H",@"10",],
                      @[@"NNThirdViewController",@"消息",@"Item_third_N",@"Item_third_H",@"12",],
                      
                      ];
    
    self.viewControllers = UICtlrListFromList(list, false);
    self.selectedIndex = 1;
}



@end
