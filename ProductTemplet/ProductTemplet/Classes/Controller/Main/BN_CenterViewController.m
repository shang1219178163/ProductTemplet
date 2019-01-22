
//
//  BN_CenterViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_CenterViewController.h"


@interface BN_CenterViewController ()

@property (nonatomic, strong) NSArray * filterList;

@end

@implementation BN_CenterViewController

-(NSArray *)filterList{
    if (!_filterList) {
        _filterList = @[
                        @{
                            kItem_header  :   @"时间",
//                            kItem_footer  :   @"footer_0",
                            kItem_obj   :   @[
                                    @"天数",
                                    
                                    ],
                            kItem_objSeleted   :   @[
                                    @(YES),
                                    
                                    ].mutableCopy,
                            
                            },
                            @{
                                kItem_header  :   @"栏位",
//                                kItem_footer  :   @"footer_1",
                                kItem_obj   :   @[
                                        @"栏位",
                                        
                                        ],
                                kItem_objSeleted   :   @[
                                        @(YES),

                                        ].mutableCopy,
                                
                                },
                            @{
                                kItem_header  :   @"性别",
//                                kItem_footer  :   @"footer_2",
                                kItem_obj   :   @[
                                        @"母猪",
                                        
                                        ],
                                kItem_objSeleted   :   @[
                                        @(YES),

                                        ].mutableCopy,
                                
                                },
                            @{
                                kItem_header  :   @"状态",
//                                kItem_footer  :   @"footer_2",
                                kItem_obj   :   @[
                                        @"后备", @"妊娠", @"哺乳",
                                        @"返情空怀", @"B超鉴定空怀", @"流产空怀",
                                        @"断奶空怀",
                                        
                                        ],
                                kItem_objSeleted   :   @[
                                        @(YES),@(NO),@(NO),
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
    [self configureTableView];
    
    self.view.backgroundColor = UIColor.yellowColor;
    
    [self createBarItemTitle:@"Tap" imageName:nil isLeft:NO isHidden:NO handler:^(id obj, UIButton * item, NSInteger idx) {
        BN_FilterView * view = [[BN_FilterView alloc]init];
        view.dataList = self.filterList;
        //            view.direction = @1;
        [view show];
        view.block = ^(BN_FilterView *view, NSIndexPath *indexPath, NSInteger idx) {
            DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row));
        };
    }];

    self.dataList = @[
                      @[
                          @"字符串映射研究",@"RuntimeController",
                          ],
                      @[
                          @"iOS字体大全",@"FontListController",
                          ],
                      @[
                          @"FMDB",@"FMBDViewController",
                          ],
                      @[
                          @"iOS锁性能对比",@"LockCompareController",
                          ],
                      @[
                          @"DesignPatterns",@"DesignPatternsController",
                          ],
                      @[
                          @"Multithreading",@"MultithreadingViewController",
                          ],
                      @[
                          @"block循环引用完美解决方案",@"BlockViewController",
                          ],
                      @[
                          @"通用列表类展示封装",@"ShowListController",
                          
                          ],
                      @[
                          @"录入类界面封装",@"EntryViewController",
                          ],
                      @[
                          @"View自定义",@"CustomViewController",
                          ],
                      @[
                          @"UICollectionView",@"UICollectionDisplayController",
                          ],
                      @[
                          @"Sort",@"SortViewController",
                          ],
                      @[
                          @"(不同线程)广播重定向",@"NotificationTreadController",
                          ],
                      @[
                          @"定时器列表",@"CountDownListController",
                          ],
                      @[
                          @"UIViewPropertyAnimator(iOS10)",@"UIViewPropertyAnimatorController",
                          ],
                      @[
                          @"SugerAlert",@"SugerAlertController",
                          ],
                      @[
                          @"同一界面多网络请求",@"MutiRequestController",
                          ],
                      @[
                          @"NSNumberFormatter",@"NumberViewController",
                          ],
                      @[
                          @"UITextField",@"UITextFieldController",
                          ],
                      @[
                          @"UITextView",@"TextViewController",
                          ],
//                      @[
//                          @"FriendList",@"FriendListController",
//                          ],
                      @[
                          @"金额跳动",@"MoneyDisplayController",
                          ],
                      
                      @[
                          @"Test",@"TestViewController",
                          
                          ],
         
                      ].mutableCopy;
    
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)configureTableView{
    self.tableView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];    
}

#pragma mark - -UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.dataList.count > 0 ? self.dataList.count : 1;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * list = self.dataList[indexPath.row];
    
    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
    
    cell.textLabel.text = list.firstObject;
    cell.textLabel.textColor = UIColor.themeColor;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * list = self.dataList[indexPath.row];
//    [self goController:list.lastObject title:list.firstObject];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [self pushController:list.lastObject item:cell type:@0];
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//    NSString *text = [NSString stringWithFormat:@"共搜索到%@条符合条件的数据",@(self.resultList.count)];
//    return text;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
////    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
////    return label;
//
//}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    return [UIView new];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

