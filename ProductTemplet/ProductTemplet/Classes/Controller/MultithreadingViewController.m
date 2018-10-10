//
//  MultithreadingViewController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "MultithreadingViewController.h"

#import "UIViewController+Helper.h"
#import "WHKTableViewOneCell.h"

@interface MultithreadingViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation MultithreadingViewController

- (void)configureTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTableView];
    
    self.dataList = @[
                      @{
                          kItem_title       :   @"ThreadNormol",
                          kItem_controller  :   @"ThreadNormolController",
                          
                          },
                      @{
                          kItem_title       :   @"Thread",
                          kItem_controller  :   @"ThreadViewController",
                          
                          },
                      @{
                          kItem_title       :   @"ThreadCommunication",
                          kItem_controller  :   @"ThreadCommunicationController",
                          
                          },
                      @{
                          kItem_title       :   @"GCD",
                          kItem_controller  :   @"GCDViewController",
                          
                          },
                      @{
                          kItem_title       :   @"Operation",
                          kItem_controller  :   @"OperationViewController",
                          
                          },
                      @{
                          kItem_title       :   @"item3",
                          kItem_controller  :   @"",
                          
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


#pragma mark - -layz

@end
