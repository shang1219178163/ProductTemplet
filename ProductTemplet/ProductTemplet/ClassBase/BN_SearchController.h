//
//  BN_SearchController.h
//  SearchBar
//
//  Created by BIN on 2018/2/27.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

/**
 搜索控制器基类 
 
 */

#import "BN_BaseViewController.h"

#import "BN_SearchResultController.h"

#define  kPushToSearchController(SearchController,ResultController)\
ResultController * resultController = [[ResultController alloc]init];\
SearchController * controller = [[SearchController alloc]initWithResultController:resultController];\
[self.navigationController pushViewController:controller animated:YES];

@interface BN_SearchController : BN_BaseViewController

@property (strong, nonatomic) UISearchController *searchController;
//@property (strong, nonatomic) SearchViewController *searchVC;

@property (strong, nonatomic) BN_SearchResultController *searchResultVC;

- (instancetype)initWithResultController:(BN_SearchResultController *)resultController;


@end
