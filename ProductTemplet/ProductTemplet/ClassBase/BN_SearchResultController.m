//
//  BN_SearchResultController.m
//  SearchBar
//
//  Created by BIN on 2018/2/27.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

#import "BN_SearchResultController.h"

@interface BN_SearchResultController ()

@end

@implementation BN_SearchResultController


-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.greenColor;//测试阶段区分视图
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
