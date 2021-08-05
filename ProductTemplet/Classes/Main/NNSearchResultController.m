//
//  NNSearchResultController.m
//  本地搜索
//
//  Created by Bin Shang on 2019/10/15.
//  Copyright © 2019 希爱欧科技有限公司. All rights reserved.
//

#import "NNSearchResultController.h"

@interface NNSearchResultController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation NNSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    [self.view addSubview:self.tbView];
    self.tbView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    self.tbView.tableFooterView = [[UIView alloc]init];

}

#pragma mark -UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"%@_%@", @(indexPath.section), @(indexPath.row)];
    [cell getViewLayer];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DDLog(@"%@", @(indexPath.row));
}

@end
