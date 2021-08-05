//
//  UICTViewMainController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/7/15.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UICTViewMainController.h"

@interface UICTViewMainController ()

@property (nonatomic, strong) NSArray *filterList;
@property (nonatomic, strong) NNTablePlainView *plainView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation UICTViewMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    //    [self.view addSubview:self.tableView];
    [self.view addSubview:self.plainView];
    
    [self createBarItem:@"个人中心" isLeft:false handler:^(UIButton *sender) {
        NNFilterView * view = [[NNFilterView alloc]init];
        view.dataList = self.filterList;
        //            view.direction = @1;
        [view show];
        view.block = ^(NNFilterView *view, NSIndexPath *indexPath, NSInteger idx) {
            DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row));
        };
    }];
    
    self.dataList = @[
                      @[@"NNCycleViewController", @"完美轮播图",],
                      @[@"ScrollHorizontalController", @"水平滚动",],
                      @[@"NNPageScrollViewController", @"多页面菜单",],
                      @[@"NNSlopeShowController", @"倾斜效果",],
                      @[@"SphereViewController", @"空间球形效果",],
                      @[@"CircleViewController", @"圆形效果(多层)",],
                      @[@"PhotoDisplayController", @"圆圈效果",],
                      @[@"PickerViewController", @"picker效果",],
                      @[@"CardLineViewController", @"卡片信息展示效果",],
                      @[@"CardViewController", @"卡片信息展示效果",],
                      @[@"NNExcelController", @"Excel视图",],
                      @[@"NNShareViewController", @"分享视图",],
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

- (NNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[NNTablePlainView alloc]init];
        _plainView.tableView.rowHeight = 50;
        
        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSArray *list = self.dataList[indexPath.row];
            
            static NSString * identifier = @"UITableViewCell1";
            //    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
            UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];
            cell.textLabel.text = list[1];
            cell.textLabel.textColor = UIColor.themeColor;
            cell.textLabel.font = [UIFont systemFontOfSize:15];

            cell.detailTextLabel.text = list[0];
            cell.detailTextLabel.textColor = UIColor.grayColor;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        };
        
        _plainView.blockDidSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSArray *list = self.dataList[indexPath.row];
//            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            UIViewController *vc = [[NSClassFromString(list[0]) alloc]init];
            vc.title = list[1];
            [self.navigationController pushViewController:vc animated:true];
        };
    }
    return _plainView;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


@end

