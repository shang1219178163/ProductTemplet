//
//  AppIconChangeController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/9/20.
//  Copyright © 2019 BN. All rights reserved.
//

#import "AppIconChangeController.h"

@interface AppIconChangeController ()

@property (nonatomic, strong) NNTablePlainView * plainView;

@end

@implementation AppIconChangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataList = @[@[@"AppIcon", @"默认",],
                      @[@"parkingOne", @"Parking",],
                      @[@"parkingWang", @"停车王",],
                      @[@"天天特价", @"天天特价",],
                      
                      ].mutableCopy;
    
    [self.view addSubview:self.plainView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.plainView.list = self.dataList;
    [self.plainView.tableView reloadData];
}


#pragma mark -lazy

- (NNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[NNTablePlainView alloc]initWithFrame:self.view.bounds];
        _plainView.tableView.rowHeight = 70;
        
        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSArray * list = self.dataList[indexPath.row];
            
            //    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
            UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView];
            cell.imageView.image = [UIImage imageNamed:list[0]];
            cell.textLabel.text = list[1];
            cell.textLabel.textColor = UIColor.themeColor;
            
            [cell getViewLayer];
            return cell;
        };
        
        _plainView.blockDidSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSArray * list = self.dataList[indexPath.row];
            [UIApplication setAppIconWithName:list[0]];
            
        };
    }
    return _plainView;
}

@end

