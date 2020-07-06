//
//  CounterListGroupController.m
//  BNCounterDemo
//
//  Created by FDC-iOS on 2017/4/21.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import "CounterListGroupController.h"
#import "BNCounter.h"

@interface CounterListGroupController ()

@property (nonatomic, strong) NSArray *dataListGroup;
@property (nonatomic, strong) BNCounter *countDown;

@end

@implementation CounterListGroupController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tbView];

    /// 1.初始化 传入当前视图和数据数组
    self.countDown = [[BNCounter alloc] initWithTable:self.tbView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.countDown.dataList = self.dataListGroup = [self dataListWithIsPlus:self.countDown.isPlusTime];
    
}

- (void)dealloc {
    /// 2.销毁
    [self.countDown destoryTimer];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * head = [[UILabel alloc] initWithFrame:CGRectZero];
    head.text = [NSString stringWithFormat:@"第%zd组数据",section + 1];
    head.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [head sizeToFit];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataListGroup.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * arr = self.dataListGroup[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"{%@,%@}",@(indexPath.section),@(indexPath.row)];
    
    /// 3.绑定tag
    cell.tag = indexPath.section * 100 + indexPath.row;
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
    
    NSMutableArray * groupArr = [NSMutableArray array];
    for (int i = 0; i<5; i ++) {
        NSString *str2;
        if (_isPlusTime) {
            str2 = [NSString stringWithFormat:@"%zd",nowInteger - arc4random()%50];
        } else {
            str2 = [NSString stringWithFormat:@"%zd",nowInteger + arc4random()%500];
        }
        
        arr = @[str2];
        [nmArr addObjectsFromArray:arr];
        [groupArr insertObject:nmArr atIndex:0];
    }
    return groupArr.copy;
}

@end
