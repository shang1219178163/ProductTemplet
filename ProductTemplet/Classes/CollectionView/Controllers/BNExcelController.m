//
//  BNExcelController.m
//  BN_CollectionView
//
//  Created by hsf on 2018/4/13.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNExcelController.h"

#import "UIExcelView.h"

@interface BNExcelController ()

@property (nonatomic, strong) UIExcelView * excelView;

@end

@implementation BNExcelController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    self.view.backgroundColor = UIColor.greenColor;

    self.title = NSStringFromClass([self class]);

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self.navigationController setupBarClearColor:YES];
    UIView * barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0.0;
    
    
    [self setupInitData];
    
}

//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

//    [self.navigationController setupBarClearColor:NO];
    UIView * barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 1;
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.view addSubview:self.excelView];

}

- (void)setupInitData{
    
    NSMutableArray * marr = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        NSMutableArray * tmp  = [NSMutableArray array];
        [tmp addObject:[NSString stringWithFormat:@"项目%@",@(i)]];
        [tmp addObjectsFromArray:@[@10000,@0,@"3.4.5.6",@"027641081087",@"1",]];
        [tmp addObject:@(RandomInteger(1, 100))];
        [tmp addObject:@(RandomInteger(100, 10000))];
        [tmp addObject:@(RandomInteger(1000, 1999))];
        [tmp addObject:@(RandomInteger(10000000000, 19999999999))];

        [marr addObject:tmp];
    }
    
    NSArray *array = marr.copy;
//    NSArray * widthList = @[@80,@80,@80,@80,@80,@80,@80,@80,@80];
    NSArray * titleList = @[@"名称",@"总数",@"剩余",@"IP",@"状态",@"状态1",@"状态2",@"状态3",@"状态4",@"状态5"];
    NSMutableDictionary *dic  = @{
                                  //            kExcel_LockColumn:   @1,
                                  //            kExcel_WidthList:   widthList,
                                  kExcelTitles:   titleList,
                                  kExcelDatas:   array,

                                  }.mutableCopy;


    self.excelView.dict = dic;
    [self.excelView reloadData];
}

#pragma mark -lazy

-(UIExcelView *)excelView{
    if (!_excelView) {
        CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        _excelView = [[UIExcelView alloc]initWithFrame:rect];
        _excelView.block = ^(UIExcelView *view, UICTViewCellExcel *cell, NSIndexPath *indexPath) {
            DDLog(@"_%@\n%@\n%@",view,cell.label.text,NSStringFromIndexPath(indexPath));
            
        };
    }
    return _excelView;
}


@end
