
//
//  BNCenterViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNCenterViewController.h"

@interface BNCenterViewController ()

@property (nonatomic, strong) NSArray * filterList;
@property (nonatomic, strong) NNTablePlainView * plainView;

@end

@implementation BNCenterViewController

-(NSArray *)filterList{
    if (!_filterList) {
        _filterList = @[
                        @{
                            kItem_header:   @"时间",
//                            kItem_footer:   @"footer_0",
                            kItem_obj:   @[          @"天数",
                                    
                                    ],
                            kItem_objSeleted:   @[          @(YES),
                                    
                                    ].mutableCopy,
                            
                            },
                            @{
                                kItem_header:   @"栏位",
//                                kItem_footer:   @"footer_1",
                                kItem_obj:   @[              @"栏位",
                                        
                                        ],
                                kItem_objSeleted:   @[              @(YES),

                                        ].mutableCopy,
                                
                                },
                            @{
                                kItem_header:   @"性别",
//                                kItem_footer:   @"footer_2",
                                kItem_obj:   @[              @"母猪",
                                        
                                        ],
                                kItem_objSeleted:   @[              @(YES),

                                        ].mutableCopy,
                                
                                },
                            @{
                                kItem_header:   @"状态",
//                                kItem_footer:   @"footer_2",
                                kItem_obj:   @[              @"后备", @"妊娠", @"哺乳",
                                        @"返情空怀", @"B超鉴定空怀", @"流产空怀",
                                        @"断奶空怀",
                                        
                                        ],
                                kItem_objSeleted:   @[              @(YES),@(NO),@(NO),
                                        @(NO),@(NO),@(NO),
                                        @(NO),
                                        
                                        ].mutableCopy,
                                
                                },
        
                        ];
    }
    return _filterList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tbView.backgroundColor = UIColor.whiteColor;
//    [self.view addSubview:self.tableView];
    [self.view addSubview:self.plainView];

    self.view.backgroundColor = UIColor.yellowColor;
    
//    [self createBarItemTitle:@"Tap" imgName:nil isLeft:NO isHidden:NO handler:^(id obj, UIButton * item, NSInteger idx) {
//        NNFilterView * view = [[NNFilterView alloc]init];
//        view.dataList = self.filterList;
//        //            view.direction = @1;
//        [view show];
//        view.block = ^(NNFilterView *view, NSIndexPath *indexPath, NSInteger idx) {
//            DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row));
//        };
//    }];
    
    [self createBarItem:@"个人中心" isLeft:false handler:^(id obj, UIView *item, NSInteger idx) {
        NNFilterView * view = [[NNFilterView alloc]init];
        view.dataList = self.filterList;
        //            view.direction = @1;
        [view show];
        view.block = ^(NNFilterView *view, NSIndexPath *indexPath, NSInteger idx) {
            DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row));
        };
    }];

    self.dataList = @[
                      @[@"PKMainController", @"高德地图轨迹回溯",],
                      @[@"TrackRecordsController", @"后台二十四小时定时定位",],                      
                      @[@"TextFromSpeechController", @"语音转文字",],
                      @[@"AVSpeechViewController", @"文字转语音",],
                      @[@"RuntimeController", @"字符串映射研究",],
                      @[@"LoginViewController", @"直播拉流",],
                      @[@"AnimationListController", @"动画研究",],
                      @[@"BNCollectionMainController", @"CollectionView封装",],
                      @[@"FileShareController", @"app之间文件共享",],                      
                      @[@"FontListController", @"iOS字体大全",],
                      @[@"FMBDViewController", @"FMDB",],
                      @[@"LockCompareController", @"iOS锁性能对比",],
                      @[@"DesignPatternsController", @"DesignPatterns",],
                      @[@"MultithreadingViewController", @"Multithreading",],
                      @[@"BlockViewController", @"block循环引用完美解决方案",],
                      @[@"ShowListController", @"通用列表类展示封装", ],
                      @[@"EntryViewController", @"录入类界面封装",],
                      @[@"CustomViewController", @"View自定义",],
                      @[@"BNTabBarController", @"嵌套TabBar,实现类UITabBarController功能",],
                      @[@"SubTabBarController", @"BNTabBarController子类化",],
                      @[@"SortViewController", @"Sort",],
                      @[@"NotificationTreadController", @"(不同线程)广播重定向",],
                      @[@"CountDownListController", @"定时器列表",],
                      @[@"SugerAlertController", @"SugerAlert",],
                      @[@"MutiRequestController", @"同一界面多网络请求",],
                      @[@"NumberViewController", @"NSNumberFormatter(金额小数点处理)",],
                      @[@"UITextFieldController", @"UITextField",],
                      @[@"TextViewController", @"UITextView",],
//                      @[@"FriendListController", @"FriendList", ],
                      @[@"MoneyDisplayController", @"金额跳动",],
                      @[@"KeyboardController",@"Keyboard自定义",],
                      @[@"ScrollViewCycleController", @"ScrollViewCycle",],
                      @[@"FileParseController", @"json文件解析",],
                      @[@"BNCollectionDataController", @"集合属性KVO监听",],
                      @[@"SnapshotViewController", @"屏幕截图分享/反馈",],                      
                      @[@"TestViewController", @"Test",],
                      
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

