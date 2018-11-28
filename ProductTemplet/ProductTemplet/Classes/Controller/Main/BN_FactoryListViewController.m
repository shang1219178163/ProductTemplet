//
//  BN_FactoryListViewController.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/15.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_FactoryListViewController.h"

#import "FactoryDetailInfoModel.h"

@interface BN_FactoryListViewController ()

@end

@implementation BN_FactoryListViewController

- (void)configureTableView{
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];

    self.view.backgroundColor = UIColor.yellowColor;
    
    for (NSInteger i = 0; i < 20; i++) {
        FactoryDetailInfoModel * model = [[FactoryDetailInfoModel alloc]init];
        model.title = [NSString stringWithFormat:@"伟业工厂%@%@",@(i),@(i)];
        if (i == 0) {
            model.title = @"伟业工厂伟业工厂伟业工厂";
        }
        model.number = [NSString getRandomStr:0 to:10];
        [self.dataList addObject:model];
    }
    
    [self.tableView reloadData];
    
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
    
    if (self.dataList.count > 0) {
        UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
        
        cell.textLabel.text = [self.dataList[indexPath.row] title];
        cell.textLabel.textColor = UIColor.redColor;
        
        return cell;
    }else{
        UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView identifier:@"cell"];
   
        cell.textLabel.textColor = UIColor.redColor;
        cell.textLabel.text = @"没有符合条件的数据,去看看其他内容吧!";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.blockObject(self.dataList[indexPath.row], nil, 0);
    
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
