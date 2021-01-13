//
//  MultithreadingViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "MultithreadingViewController.h"

#import "UIViewController+Helper.h"

@interface MultithreadingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation MultithreadingViewController

- (void)configureTableView{
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self.view addSubview:self.tbView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTableView];
    
    self.dataList = @[
                      @{
                          kItemTitle:   @"ThreadNormol",
                          kItemController:   @"ThreadNormolController",
                          
                          },
                      @{
                          kItemTitle:   @"Thread",
                          kItemController:   @"ThreadViewController",
                          
                          },
                      @{
                          kItemTitle:   @"ThreadCommunication",
                          kItemController:   @"ThreadCommunicationController",
                          
                          },
                      @{
                          kItemTitle:   @"GCD",
                          kItemController:   @"GCDViewController",
                          
                          },
                      @{
                          kItemTitle:   @"Operation",
                          kItemController:   @"OperationViewController",
                          
                          },
                      @{
                          kItemTitle:   @"item3",
                          kItemController:   @"",
                          
                          },
                      
                      ].mutableCopy;
    
    
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
    
    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
    
    cell.textLabel.text = dict[kItemTitle];
    cell.textLabel.textColor = UIColor.themeColor;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict = self.dataList[indexPath.row];
    [self.navigationController pushVC:dict[kItemController] animated:true block:^(__kindof UIViewController * _Nonnull vc) {
        vc.title = dict[kItemTitle];
    }];
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



#pragma mark -lazy
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


@end
