//
//  FontListController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/2.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_FontListController.h"

#import "BN_SimpleDataModel.h"
#import "FactoryDetailInfoModel.h"

#import "BN_TableViewZeroCell.h"


@interface BN_FontListController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BN_FontListController

- (void)configureTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];
    
    //    NSArray *familyNames = [UIFont familyNames];
    //    for(NSString *familyName in familyNames){
    //        printf( "Family: %s \n", [familyName UTF8String] );
    //        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    //        for(NSString *fontName in fontNames){
    //            printf( "\tFont: %s \n", [fontName UTF8String] );
    //        }
    //    }
    
    NSArray *familyNames = [UIFont familyNames];
    for(NSString *familyName in familyNames){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        
        NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
        for(NSString *fontName in fontNames){
            printf( "\tFont: %s \n", [fontName UTF8String] );
            [marr addObject:fontName];
        }
        [self.dataList addObject:marr];
    }
    
    [self.tableView reloadData];
}

#pragma mark - -UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * array = self.dataList[section];
    NSInteger count = array.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array = self.dataList[indexPath.section];
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self.dataList[indexPath.row] title];
    cell.textLabel.textColor = [UIColor redColor];
    
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:array[indexPath.row] size:17];
    
    return cell;
    
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
