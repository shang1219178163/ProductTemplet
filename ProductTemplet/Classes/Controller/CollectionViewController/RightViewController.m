
//
//  RightViewController.m
//  BN_CollectionView
//
//  Created by hsf on 2018/4/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "RightViewController.h"

#import "UIExcelView.h"

@interface RightViewController ()

@property (nonatomic, strong) UIExcelView * excelView;

@end

@implementation RightViewController

-(UIExcelView *)excelView{
    if (!_excelView) {
        CGRect rect = CGRectMake(20, 20, CGRectGetWidth(self.view.bounds) - 20*2, CGRectGetHeight(self.view.bounds) - 20*2);
        _excelView = [[UIExcelView alloc]initWithFrame:rect];
    }
    return _excelView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = NO;

    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor greenColor];

    [self configureReportExcelView];

}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)configureReportExcelView{
    [self.view addSubview:self.excelView];

    NSArray *array = @[
                       @[@"test1",@0,    @0,     @"3.4.5.6",@"027641081087",@"1",   @0,     @"3.4.5.6",@"027641081087"],
                       @[@"test2",@0,@0,@"3.4.5.6",@"027641081087",@"2",@0,@"3.4.5.6",@"027641081087"],
                       @[@"test3",@0,@0,@"3.4.5.6",@"027641081087",@"3",@0,@"3.4.5.6",@"027641081087"],
                       @[@"test4",@0,@0,@"3.4.5.6",@"027641081087",@"4",@0,@"3.4.5.6",@"027641081087"],
                       @[@"test5",@0,@0,@"3.4.5.6",@"027641081087",@"5",@0,@"3.4.5.6",@"027641081087"],
                       @[@"test6",@"",@0,@"3.4.5.6",@"027641081087",@"6",@0,@"3.4.5.6",@"027641081087"],
                       @[@"test7",@0,@0,@"3.4.5.6",@"027641081087",@"7",@0,@"3.4.5.6",@"027641081087"],
                       @[@"test8",@0,@0,@"3.4.5.6",@"027641081087",@"8",@0,@"3.4.5.6",@"027641081087"],
                       @[@"test9",@0,@0,@"3.4.5.6",@"027641081087",@"9",@0,@"3.4.5.6",@"027641081087"],
                       @[@"test10",@0,@0,@"3.4.5.6",@"027641081087",@"10",@0,@"3.4.5.6",@"027641081087"],
                       
                       ];
   
    NSArray * titleList = @[@"名称",@"总数",@"剩余",@"IP",@"状态",@"状态1",@"状态2",@"状态3",@"状态4"];
    
    NSArray * widthList = [NSArray  arrayWithItem:@(80) count:titleList.count];
    NSMutableDictionary *dic  = @{
                        //            kExcel_LockColumn   :   @1,
                        //            kExcel_WidthList    :   widthList,
                                    kExcelTitles    :   titleList,
                                    kExcelDatas     :   array,
                                    
                                    }.mutableCopy;
    

    self.excelView.dict = dic;
    [self.excelView reloadData];
    
    self.excelView.label.text = @"";
    self.excelView.block = ^(UIExcelView *view,UICollectionViewCell * cell, NSIndexPath *indexPath) {
        DDLog(@"_%@_%@",view,NSStringFromIndexPath(indexPath));
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
