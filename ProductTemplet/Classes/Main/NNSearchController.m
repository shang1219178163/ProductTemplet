//
//  NNSearchController.m
//  本地搜索
//
//  Created by Bin Shang on 2019/10/15.
//  Copyright © 2019 希爱欧科技有限公司. All rights reserved.
//

#import "NNSearchController.h"
#import "NNSearchResultController.h"
#import "UIViewController+Helper.h"



@interface NNSearchController ()<UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate>

@property(nonatomic, strong) UISearchController *searchVC;
@property(nonatomic, strong) NNSearchResultController *resultVC;

@end

@implementation NNSearchController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;tbView.dataSource = self;
    self.tbView.delegate = self;
    
    [self.view addSubview:self.tbView];
    self.tbView.tableHeaderView = self.searchVC.searchBar;
    self.tbView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];

    
    DDLog(@"%@", self.searchVC.searchBar.textField);
    DDLog(@"%@", self.searchVC.searchBar.cancellBtn);

    self.searchVC.searchBar.showsCancelButton = TRUE;
    UIButton *btn = self.searchVC.searchBar.cancellBtn;
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    DDLog(@"%@", btn);
}

#pragma mark -UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [cell getViewLayer];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DDLog(@"%@", @(indexPath.row));
}

#pragma mark -lazy
- (NNSearchResultController *)resultVC{
    if (!_resultVC) {
        _resultVC = [[NNSearchResultController alloc]init];
    }
    return _resultVC;
}

- (UISearchController *)searchVC{
    if (!_searchVC) {
        _searchVC = [self createSearchVC:self.resultVC];
        _searchVC.searchBar.delegate = self;
        _searchVC.delegate = self;
    }
    return _searchVC;
}

@end
