//
//  CounterListController.m
//  BNCounterDemo
//
//  Created by FDC-iOS on 2017/4/21.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import "CounterListController.h"
#import "BNCounter.h"

@interface CounterListController ()

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) BNCounter *countDown;

@end

@implementation CounterListController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.view addSubview:self.tbView];
    // 1.初始化 传入当前视图和数据数组
    self.countDown = [[BNCounter alloc] initWithTable:self.tbView];

    
//    DDLog(@"_%p_",BNCounter.shared);
//    [BNCounter destoryShared];
//    NSInteger a = 9;
//    DDLog(@"__%p_",BNCounter.shared);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.countDown.isPlusTime = self.isPlusTime = [self.obj boolValue];
    self.countDown.dataList = self.dataList = [self dataListWithIsPlus:self.countDown.isPlusTime];
    [self.tbView reloadData];
    DDLog(@"_%@_%@_%@_",@(self.isPlusTime),@(self.countDown.isPlusTime),self.obj);

}

- (void)dealloc {
    /// 2.销毁
    [self.countDown destoryTimer];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"{%@,%@}",@(indexPath.section),@(indexPath.row)];
    /// 3.绑定tag
    cell.tag = indexPath.row;
    cell.textLabel.tag = kCounterLabTag;
    cell.textLabel.text = [self.countDown countDownWithPerSec:indexPath];
    if (self.countDown.isPlusTime) {
        cell.textLabel.textColor = UIColor.redColor;
    }
    return cell;
}

- (NSArray *)dataListWithIsPlus:(BOOL)isPlus{
    NSMutableArray * nmArr = [NSMutableArray array];
    NSArray *arr = [NSArray array];
    NSInteger nowInteger = (int)NSDate.date.timeIntervalSince1970;
    
    for (int i = 0; i < 20; i ++) {
        if (isPlus) {
            NSString *str = [NSString stringWithFormat:@"%zd",nowInteger - arc4random()%100000];
            NSString *str1 = [NSString stringWithFormat:@"%zd",nowInteger - arc4random()%1000];
            NSString *str2 = [NSString stringWithFormat:@"%zd",nowInteger + arc4random()%50];
            arr = @[str,str1,str2];
            
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%zd",arc4random()%100000 + nowInteger];
            NSString *str1 = [NSString stringWithFormat:@"%zd",arc4random()%1000 + nowInteger];
            NSString *str2 = [NSString stringWithFormat:@"%zd",arc4random()%100 + nowInteger];
            arr = @[str,str1,str2];
            
        }
        [nmArr addObjectsFromArray:arr];
    }
    return nmArr.copy;
}

@end
