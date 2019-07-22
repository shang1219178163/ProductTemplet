//
//  BNCollectionMainController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/7/15.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNCollectionMainController.h"

@interface BNCollectionMainController ()

@property (nonatomic, strong) NSArray * filterList;
@property (nonatomic, strong) BNTablePlainView * plainView;

@end

@implementation BNCollectionMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = UIColor.whiteColor;
    //    [self.view addSubview:self.tableView];
    [self.view addSubview:self.plainView];
    
    [self createBarItem:@"个人中心" isLeft:false handler:^(id obj, UIView *item, NSInteger idx) {
        BNFilterView * view = [[BNFilterView alloc]init];
        view.dataList = self.filterList;
        //            view.direction = @1;
        [view show];
        view.block = ^(BNFilterView *view, NSIndexPath *indexPath, NSInteger idx) {
            DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row));
        };
    }];
    
    self.dataList = @[
                      @[@"SphereViewController", @"空间球形效果",],
                      @[@"CircleViewController", @"圆形效果",],
                      @[@"PhotoDisplayController", @"圆圈效果",],                      
                      @[@"PickerViewController", @"picker效果",],
                      @[@"CardLineViewController", @"卡片信息展示效果",],
                      @[@"CardViewController", @"卡片信息展示效果",],
                      @[@"BNExcelController", @"Excel视图",],
                      @[@"BNShareViewController", @"分享视图",],
                      @[@"CTViewListController", @"多section效果",],
                      @[@"SectionListOneController", @"可拖拽多section效果",],
                      @[@"SectionListController", @"多section效果",],
                      @[@"UICollectionDisplayController", @"UICollectionView",],
                      @[@"TmpViewController", @"伸缩按钮",],
                      
                      ].mutableCopy;
    
    self.plainView.list = self.dataList;
    [self.plainView.tableView reloadData];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.plainView.frame = self.view.bounds;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -lazy

- (BNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[BNTablePlainView alloc]init];
        _plainView.tableView.rowHeight = 70;
        
        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSArray * list = self.dataList[indexPath.row];
            
            static NSString * identifier = @"UITableViewCell1";
            //    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
            UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];
            cell.textLabel.text = list[1];
            cell.textLabel.textColor = UIColor.themeColor;
            
            cell.detailTextLabel.text = list[0];
            cell.detailTextLabel.textColor = UIColor.grayColor;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        };
        
        _plainView.blockDidSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSArray * list = self.dataList[indexPath.row];
            //    [self goController:list.lastObject title:list.firstObject];
//            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            [self goController:list[0] title:list[1]];
        };
    }
    return _plainView;
}

@end

