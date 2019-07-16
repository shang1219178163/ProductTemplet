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
    
    self.view.backgroundColor = UIColor.yellowColor;
    
    //    [self createBarItemTitle:@"Tap" imgName:nil isLeft:NO isHidden:NO handler:^(id obj, UIButton * item, NSInteger idx) {
    //        BNFilterView * view = [[BNFilterView alloc]init];
    //        view.dataList = self.filterList;
    //        //            view.direction = @1;
    //        [view show];
    //        view.block = ^(BNFilterView *view, NSIndexPath *indexPath, NSInteger idx) {
    //            DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row));
    //        };
    //    }];
    
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
                      @[@"BNCTViewController", @"",],
                      @[@"BNExcelController", @"",],
                      @[@"BNFontListShowController", @"",],
                      @[@"BNShareViewController", @"",],
                      @[@"CTViewListController", @"",],
                      @[@"CTViewListNewController", @"",],
                      @[@"CardLineViewController", @"",],
                      @[@"CardViewController", @"",],
                      @[@"CircleViewController", @"",],
                      @[@"FileParseController", @"",],
                      @[@"GroupViewController", @"",],
                      @[@"LeftViewController", @"",],
                      @[@"PickerViewController", @"",],
                      @[@"RightViewController", @"",],
                      @[@"SectionListViewController", @"",],
                      @[@"SphereViewController", @"",],
                      @[@"TmpViewController", @"",],
                      
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
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            [self pushController:list[0] title:list[1] item:cell type:@0];
        };
    }
    return _plainView;
}

@end

