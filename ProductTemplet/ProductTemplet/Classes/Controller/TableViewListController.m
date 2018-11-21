//
//  TableViewListController.m
//  ProductTemplet
//
//  Created by hsf on 2018/11/20.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "TableViewListController.h"

@interface TableViewListController ()

@end

@implementation TableViewListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];

    for (NSInteger i = 0; i < 50; i++) {
        [self.dataList addObject:@(1)];
        
    }
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
    
    // 3.绑定tag
    cell.textLabel.text = [NSString stringWithFormat:@"{%@,%@}",@(indexPath.section),@(indexPath.row)];
    
    
    
    return cell;
}

@end
