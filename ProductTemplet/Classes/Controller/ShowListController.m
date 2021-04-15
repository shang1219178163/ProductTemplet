//
//  ShowListController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/20.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "ShowListController.h"
#import <MJRefresh/MJRefresh.h>

@interface ShowListController ()

@property (nonatomic, strong) NNTablePlainView *plainView;

@end

@implementation ShowListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.plainView.list = self.dataList;
    [self.view addSubview:self.plainView];
}


- (NNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[NNTablePlainView alloc]initWithFrame:self.view.bounds];
        
        NSMutableArray * marr = @[@"111",@"222",@"333",@"444",].mutableCopy;
        _plainView.list = marr;
        
//        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            UITableViewSegmentCell * cell = [UITableViewSegmentCell cellWithTableView:tableView];
            cell.labelLeft.text = marr[indexPath.row];
            return cell;
        };
        
        _plainView.blockDidSelectRow = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            DDLog(@"223");
        };
        
        _plainView.blockEditActionsForRow = ^NSArray *(UITableView *tableView, NSIndexPath *indexPath) {
//            @strongify(self);
            UITableViewRowAction *actionDelete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:kTitleDelete handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
                DDLog(@"点击了%@", action.title);
                
            }];
            return @[actionDelete];
        };
        _plainView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            @strongify(self);
      
        }];
        // 上拉刷新
        _plainView.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            @strongify(self);

        }];
    }
    return _plainView;
}


@end
