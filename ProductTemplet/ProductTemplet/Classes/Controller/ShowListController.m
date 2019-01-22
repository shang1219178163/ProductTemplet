//
//  ShowListController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/20.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "ShowListController.h"

@interface ShowListController ()
@property (nonatomic, strong) BNTablePlainView *plainView;

@end

@implementation ShowListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.plainView.list = self.dataList;
    [self.view addSubview:self.plainView];
}


- (BNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[BNTablePlainView alloc]initWithFrame:self.view.bounds];
        
        NSMutableArray * marr = @[@"111",@"222",@"333",@"444",].mutableCopy;
        _plainView.list = marr;
        _plainView.blockCellForRow = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            UITableViewSegmentCell * cell = [UITableViewSegmentCell cellWithTableView:tableView];
            cell.labelLeft.text = marr[indexPath.row];
            return cell;
        };
        
        _plainView.blockDidSelectRow = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            DDLog(@"223")
        };
    }
    return _plainView;
}


@end
