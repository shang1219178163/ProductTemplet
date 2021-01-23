//
//  FriendListController.m
//  ProductTemplet
//
//  Created by BIN on 2018/4/24.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FriendListController.h"

#import "NNSimpleDataModel.h"

@interface FriendListController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation FriendListController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tbView];

    [self initDataSource];
}

-(void)initDataSource{
    //操作记录
    NSArray * array = @[@"分组0",@"分组1",@"分组2",@"分组3",@"分组4",@"分组5",@"分组6",@"分组7",@"分组8",@"分组9"];
    for (NSInteger i = 0; i < array.count; i++) {
        NNFoldSectionModel * foldModel = [[NNFoldSectionModel alloc] init];
        foldModel.title = array[i];
        foldModel.isOpen = NO;
        foldModel.image = @"bug.png";
        
        for (NSInteger j = 0; j <= i; j++) {
            NSString * modelString = [NSString stringWithFormat:@"%@_%@",foldModel.title,@(j)];
            [foldModel.dataList addObject:modelString];
            
        }
        [self.dataList addObject:foldModel];
    }
    
}

#pragma mark -- talbeView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NNFoldSectionModel * foldModel = self.dataList[section];
    NSInteger count = foldModel.isOpen ? foldModel.dataList.count : 0;
    return count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NNFoldSectionModel * foldModel = self.dataList[indexPath.section];
    id obj = foldModel.dataList[indexPath.row];
    
    NSString * title = [obj isKindOfClass:[NSArray class]] ? [obj firstObject] : obj;
    NSString * textSub = [@(foldModel.dataList.count) stringValue];;
    
    UITableViewElevenCell * cell = [UITableViewElevenCell cellWithTableView:tableView];
    cell.labelLeft.text = title;
    cell.labelLeftSub.text = textSub;
    cell.labelLeftSub.textColor = UIColor.redColor;
    [cell getViewLayer];
    return cell;
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//NNFoldSectionModel * foldModel = self.dataList[indexPath.section];
//    id obj = foldModel.dataList[indexPath.row];
//
//    NSString * title = [obj isKindOfClass:[NSArray class]] ? [obj firstObject] : obj;
//    NSString * textSub = [@(foldModel.dataList.count) stringValue];;
//
//
//    UITableViewSixtyFiveCell * cell = [UITableViewSixtyFiveCell cellWithTableView:tableView];
//
//    cell.labelLeft.text = title;
//    cell.labelRight.text = textSub;
//
//    [cell getViewLayer];
//    return cell;
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *msg = NSStringFromIndexPath(indexPath);
    [self.navigationController pushVC:@"NNTempViewController" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
        vc.title = @"tmp";
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NNFoldSectionModel *foldModel = self.dataList[section];

    UITableHeaderFooterViewZero * headerView = [UITableHeaderFooterViewZero viewWithTableView:tableView];

    headerView.isCanOPen = YES;
    headerView.isOpen = foldModel.isOpen;
    headerView.labelLeft.text = foldModel.title;
    headerView.labelLeft.textColor = UIColor.themeColor;
    headerView.labelLeftSub.text = [@(foldModel.dataList.count) stringValue];
    headerView.labelLeftSub.textColor = UIColor.themeColor;
    headerView.imgViewLeft.image = [UIImage imageNamed:foldModel.image];
    //    foldHeaderView.blockView = ^(NNHeaderFooterView *foldView, NSInteger index) {
    headerView.blockView = ^(UITableViewHeaderFooterView *foldView, NSInteger index) {
        foldModel.isOpen = !foldModel.isOpen;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        
    };

    [headerView getViewLayer];
    
    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
    
}

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
