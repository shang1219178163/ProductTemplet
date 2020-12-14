//
//  UISearchController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2020/12/11.
//  Copyright © 2020 BN. All rights reserved.
//

#import "UISearchController+Helper.h"

@implementation UISearchController (Helper)

+ (instancetype)createWithResultsVC:(UIViewController *)resultsController{    
    UISearchController *searchVC = [[UISearchController alloc]initWithSearchResultsController:resultsController];
//    searchVC.view.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:1];
    
    //是否添加半透明覆盖层
    searchVC.dimsBackgroundDuringPresentation = true;
    if (@available(iOS 9.1, *)) {
        searchVC.obscuresBackgroundDuringPresentation = true;
    }
//    //是否隐藏导航栏
//    searchVC.hidesNavigationBarDuringPresentation = YES;
    
    searchVC.searchBar.barStyle = UIBarStyleDefault;
    searchVC.searchBar.translucent = YES;
    if (@available(iOS 13.0, *)) {
        
    } else {
        [searchVC.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    }
//    searchVC.searchBar.barTintColor = UIColor.brownColor;
//    searchVC.searchBar.tintColor = UIColor.redColor;
    // searchController.searchBar.layer.borderColor = [UIColor redColor].CGColor;
    //searchController.searchResultsUpdater = result;
    
    searchVC.searchBar.placeholder = @"搜索";
    return searchVC;
}

@end
