//
//  BN_SearchResultController.h
//  SearchBar
//
//  Created by BIN on 2018/2/27.
//  Copyright © 2018年 CodingFire. All rights reserved.
//
/**
 搜索结果控制器基类
 
 */

#import "BN_BaseViewController.h"



@interface BN_SearchResultController : BN_BaseViewController<UISearchResultsUpdating>

@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) UISearchBar *searchBar;

@end
