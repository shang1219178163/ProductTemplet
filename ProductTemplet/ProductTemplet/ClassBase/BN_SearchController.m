//
//  BN_SearchController.m
//  SearchBar
//
//  Created by BIN on 2018/2/27.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

#import "BN_SearchController.h"

@interface BN_SearchController ()

//@property (strong, nonatomic) BN_SearchResultController *searchResultVC;

@end

@implementation BN_SearchController

-(UISearchController *)searchController{
    
    if (!_searchController) {
        //创建UISearchController
        _searchController = [[UISearchController alloc]initWithSearchResultsController:self.searchResultVC];
//        _searchController.delegate = self;
//        _searchController.searchResultsUpdater = self.searchResultVC;
//        _searchController.searchBar.delegate = self;
        
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.placeholder = @"搜索";
//        _searchController.searchBar.text = @"默认搜索内容";
        
        //包着搜索框外层的颜色
        _searchController.searchBar.tintColor = [UIColor colorWithRed:22.0/255 green:161.0/255 blue:1.0/255 alpha:1];
//        _searchController.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
//        _searchController.searchBar.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        
        //设置UISearchController的显示属性，以下3个属性默认为YES
        //搜索时，背景变暗色
        _searchController.dimsBackgroundDuringPresentation = NO;
//        _searchController.obscuresBackgroundDuringPresentation = NO;
//        //点击搜索的时候,是否隐藏导航栏
//        _searchController.hidesNavigationBarDuringPresentation = NO;
        
    }
    return _searchController;
}

-(instancetype)initWithResultController:(BN_SearchResultController *)resultController{
    self = [super init];
    if (self) {
        self.searchResultVC = resultController;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"搜索";
   
#warning 如果进入预编辑状态,searchBar消失(UISearchController套到TabBarController可能会出现这个情况),请添加下边这句话
    self.definesPresentationContext = YES;
    
    self.searchResultVC.searchBar = self.searchController.searchBar;
    //
    self.searchResultVC.dataList = self.dataList;
    
    //背景色修改
//    [self.searchResultVC.searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
