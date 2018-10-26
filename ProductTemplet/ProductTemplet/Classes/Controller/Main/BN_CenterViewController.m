
//
//  BN_CenterViewController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/21.
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
                      @{
                          kItem_title   :   @"FMDB",
                          kItem_controller  :   @"FMBDViewController",

                          },
                      @{
                          kItem_title   :   @"iOS锁性能对比",
                          kItem_controller  :   @"LockCompareController",
                          
                          },
                      @{
                          kItem_title   :   @"DesignPatterns",
                          kItem_controller  :   @"DesignPatternsController",
                          
                          },
                      @{
                          kItem_title   :   @"Multithreading",
                          kItem_controller  :   @"MultithreadingViewController",
                          
                          },
                      @{
                          kItem_title   :   @"block循环引用完美解决方案",
                          kItem_controller  :   @"BlockViewController",
                          
                          },
                      @{
                          kItem_title   :   @"录入类界面封装",
                          kItem_controller  :   @"EntryViewController",
                          
                          },
                      
                      @{
                          kItem_title   :   @"Sort",
                          kItem_controller  :   @"SortViewController",
                          
                          },
                      @{
                          kItem_title   :   @"Test",
                          kItem_controller  :   @"TestViewController",
                          
                          },
                      
                      @{
                          kItem_title   :   @"item3",
                          kItem_controller  :   @"",
                          
                          },
                 
                      ].mutableCopy;
    
    NSLog(@"%@",[NSDate date]);

    
    NSDictionary * dic = @{
                           @1 :@"11111111",
                           @2   : @"222222222",
                           };
    DDLog(@"%@",dic[@2]);
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
    NSDictionary * dict = self.dataList[indexPath.row];
    
    WHKTableViewOneCell * cell = [WHKTableViewOneCell cellWithTableView:tableView];
    
    cell.textLabel.text = dict[kItem_title];
    cell.textLabel.textColor = UIColor.themeColor;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict = self.dataList[indexPath.row];
    [self goController:dict[kItem_controller] title:dict[kItem_title]];
    
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

