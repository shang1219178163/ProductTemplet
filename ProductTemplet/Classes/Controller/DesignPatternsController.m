//
//  DesignPatternsController.m
//  BINAlertView
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "DesignPatternsController.h"

#import "UIViewController+Helper.h"

@interface DesignPatternsController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation DesignPatternsController

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
                          kItem_title       :   @"抽象工厂模式",
                          kItem_controller  :   @"AbstractFactoryController",
                          
                          },
                      @{
                          kItem_title       :   @"Strategy/策略",
                          kItem_controller  :   @"StrategyViewController",
                          
                          },
                      @{
                          kItem_title       :   @"Adapter/适配器",
                          kItem_controller  :   @"AdapterViewController",
                          
                          },
                      @{
                          kItem_title       :   @"Facade/外观",
                          kItem_controller  :   @"FacadeViewController",
                          
                          },
                      @{
                          kItem_title       :   @"Mediator/中介者",
                          kItem_controller  :   @"MediatorViewController",
                          
                          },
                      @{
                          kItem_title       :   @"Composite/组合",
                          kItem_controller  :   @"CompositeViewController",
                          
                          },
                      @{
                          kItem_title       :   @"Flyweight/享元",
                          kItem_controller  :   @"FlyweightViewController",
                          
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
    
//    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
    static NSString * identifer = @"identifer";
    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView identifier:identifer style:UITableViewCellStyleSubtitle];

    cell.textLabel.text = dict[kItem_title];
    cell.textLabel.textColor = UIColor.themeColor;
    cell.detailTextLabel.text = dict[kItem_controller];
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
