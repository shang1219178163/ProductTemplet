
//
//  NNCenterViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NNCenterViewController.h"
#import "PopoverViewExampleController.h"
#import "RoutePageSearchHelper.h"

@interface NNCenterViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *filterList;
@property (nonatomic, strong) NNTablePlainView *plainView;
@property (nonatomic, strong) NSMutableArray *dataList;
/// 全量控制器类名（扫描一次缓存，搜索过滤基于此）
@property (nonatomic, strong) NSArray *allList;

@end

@implementation NNCenterViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem customViewWithButton:@"弹窗"
                                                                          handler:^(UIButton * _Nonnull sender) {
        PopoverViewExampleController *vc = [[PopoverViewExampleController alloc]init];
        [self.navigationController pushViewController:vc animated:true];
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem customViewWithButton:@"筛选"
                                                                           handler:^(UIButton * _Nonnull sender) {
        NNFilterView * view = [[NNFilterView alloc]init];
        view.dataList = self.filterList;
        //            view.direction = @1;
        [view show];
        view.block = ^(NNFilterView *view, NSIndexPath *indexPath, NSInteger idx) {
            DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row));
        };
    }];
    
    
    self.tbView.backgroundColor = UIColor.whiteColor;
//    [self.view addSubview:self.tableView];
    [self.view addSubview:self.plainView];
    
//    self.dataList = @[@[@"EntryViewController", @"录入类界面封装",],
//                      @[@"NNUploadImagesController", @"选择照片",],
//                      @[@"NNTagViewController", @"TagView",],
//                      @[@"SystemIconController", @"系统图标 SF Symbols",],
//                      @[@"SwiftHigherOrderController", @"Swift 高阶函数",],
//                      @[@"ObjCHigherOrderController", @"ObjC 高阶函数",],
//                      @[@"SystemAboutController", @"系统相关",],
//                      @[@"NNSearchController", @"复合搜索🔍",],
//                      @[@"RuntimeController", @"字符串映射研究",],
//                      @[@"NNButtonDispalyController", @"NNButtonDispaly",],
//                      @[@"LoginViewController", @"直播拉流",],
//                      @[@"AnimationListController", @"动画研究",],
//                      @[@"UICTViewMainController", @"CollectionView封装",],
//                      @[@"FMBDViewController", @"FMDB",],
//                      @[@"LockCompareController", @"iOS锁性能对比",],
//                      @[@"DesignPatternsController", @"DesignPatterns",],
//                      @[@"MultithreadingViewController", @"Multithreading",],
//                      @[@"BlockViewController", @"block循环引用完美解决方案",],
//                      @[@"ShowListController", @"通用列表类展示封装", ],
//                      @[@"CustomViewController", @"View自定义",],
//                      @[@"NNTabBarController", @"嵌套TabBar,实现类UITabBarController功能",],
//                      @[@"SubTabBarController", @"NNTabBarController子类化",],
//                      @[@"SortViewController", @"Sort",],
//                      @[@"NotificationTreadController", @"(不同线程)广播重定向",],
//                      @[@"CountDownListController", @"定时器列表",],
//                      @[@"SugerAlertController", @"SugerAlert",],
//                      @[@"MutiRequestController", @"同一界面多网络请求",],
//                      @[@"NumberViewController", @"NSNumberFormatter(金额小数点处理)",],
////                      @[@"FriendListController", @"FriendList", ],
//                      @[@"MoneyDisplayController", @"金额跳动",],
//                      @[@"ScrollViewCycleController", @"ScrollViewCycle",],
//                      @[@"TestViewController", @"Test",],
//                      
//                      ].mutableCopy;


    self.allList = [RoutePageSearchHelper scanControllerList];
    self.dataList = self.allList.mutableCopy;
    self.plainView.list = self.dataList;
    [self.plainView.tableView reloadData];

    [self setupSearchBar];
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
#pragma mark -funtions
- (void)setupSearchBar {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [UIApplication setupAppearanceSearchbarCancellButton];
    self.searchBar = ({
        UISearchBar *searchBar = [UISearchBar createRect:CGRectMake(0, 0, kScreenWidth - 150, 30)];
        searchBar.placeholder = @"请输入流水号、商品信息或会员信息";
        searchBar.delegate = self;
        searchBar.showsCancelButton = NO;
        // 放大镜左侧加8间距：把放大镜包进左边距8pt的容器
        UITextField *textField = searchBar.textField;
        UIView *iconView = textField.leftView;
        if (iconView) {
            UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconView.bounds.size.width + 8, iconView.bounds.size.height)];
            iconView.frame = CGRectMake(8, 0, iconView.bounds.size.width, iconView.bounds.size.height);
            [container addSubview:iconView];
            textField.leftView = container;
        }
//        searchBar.scopeButtonTitles = @[@"111", @"22", @"333"];
//        searchBar.showsScopeBar = true;
//        searchBar.showsBookmarkButton = true;
        searchBar;
    });
    
    //Set to titleView
    self.navigationItem.titleView = ({
        UIView *titleView = [[UIView alloc]initWithFrame:self.searchBar.bounds];
        //UIColor *color =  self.navigationController.navigationBar.tintColor;
        //[titleView setBackgroundColor:color];
        [titleView addSubview:self.searchBar];
        
        titleView;
    });
}

#pragma mark -UISearchBar

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return true;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return true;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *key = [searchText stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (key.length == 0) {
        self.dataList = self.allList.mutableCopy;
    } else {
        self.dataList = [[self.allList filteredArrayUsingPredicate:
                          [NSPredicate predicateWithBlock:^BOOL(id  _Nullable obj, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [obj localizedCaseInsensitiveContainsString:key];
        }]] mutableCopy];
    }
    self.plainView.list = self.dataList;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    DDLog(@"%@", searchBar.text);
    
    return true;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    DDLog(@"%@", searchBar.text);
    
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    DDLog(@"%@", searchBar.text);
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    DDLog(@"%@", searchBar.text);
    
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    DDLog(@"%@", searchBar.text);
    
}


#pragma mark -lazy

- (NNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[NNTablePlainView alloc]initWithFrame:self.view.bounds];
        _plainView.tableView.rowHeight = 50;
        
        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSString *className = self.dataList[indexPath.row];

            static NSString * identifier = @"UITableViewCell1";
            //    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
            UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];
            cell.textLabel.textColor = UIColor.themeColor;
            cell.textLabel.font = [UIFont systemFontOfSize:13];

            cell.detailTextLabel.textColor = UIColor.grayColor;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            cell.textLabel.text = className;
            cell.detailTextLabel.text = nil;

            return cell;
        };

        _plainView.blockDidSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSString *className = self.dataList[indexPath.row];

            UIViewController *vc = [[NSClassFromString(className) alloc]init];
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

-(NSArray *)filterList{
    if (!_filterList) {
        _filterList = @[
                        @{kItemHeader: @"时间",
//                            kItemFooter: @"footer_0",
                            kItemObj: @[@"天数",],
                            kItemObjSeleted: @[ @(YES),].mutableCopy,
                            },
                            @{kItemHeader: @"栏位",
//                                kItemFooter: @"footer_1",
                                kItemObj: @[@"栏位",],
                                kItemObjSeleted: @[ @(YES), ].mutableCopy,
                                
                                },
                            @{kItemHeader: @"性别",
//                                kItemFooter: @"footer_2",
                                kItemObj: @[@"母猪", ],
                                kItemObjSeleted: @[ @(YES), ].mutableCopy,
                                
                                },
                            @{kItemHeader: @"状态",
//                                kItemFooter: @"footer_2",
                                kItemObj: @[@"后备", @"妊娠", @"哺乳",
                                        @"返情空怀", @"B超鉴定空怀", @"流产空怀",
                                        @"断奶空怀",
                                        
                                        ],
                                kItemObjSeleted: @[ @(YES),@(NO),@(NO),
                                        @(NO),@(NO),@(NO),
                                        @(NO),
                                        ].mutableCopy,
                                },
                        ];
    }
    return _filterList;
}

@end

