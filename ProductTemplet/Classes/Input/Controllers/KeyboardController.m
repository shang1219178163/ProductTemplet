//
//  ViewController.m
//  KeyboardManagerDemo
//
//  Created by zhujinhui on 2018/1/29.
//  Copyright © 2018年 kyson. All rights reserved.
//

#import "KeyboardController.h"
#import "TextViewInputController.h"
#import "InputViewController.h"
#import "KeyboardCoverTextFieldViewController.h"
#import "CustomKeyboardViewController.h"
#import "IDCardKeyboardViewController.h"

@interface KeyboardController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation KeyboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
// Do any additional setup after loading the view, typically from a nib.
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            TextViewInputController *textViewController = [[TextViewInputController alloc] init];
            [self.navigationController pushViewController:textViewController animated:YES];
        }
            break;
        case 1:{
            InputViewController *inputViewController = [[InputViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:inputViewController animated:YES];
        }
            break;
        case 2:{
            KeyboardCoverTextFieldViewController *cover = [[KeyboardCoverTextFieldViewController alloc] init];
            [self.navigationController pushViewController:cover animated:YES];
        }
            break;
        case 4:{
            CustomKeyboardViewController *customKeyboardViewController = [[CustomKeyboardViewController alloc] init];
            [self.navigationController pushViewController:customKeyboardViewController animated:YES];
        }
            break;
        case 3:{
            IDCardKeyboardViewController *idCardKeyboardViewController = [[IDCardKeyboardViewController alloc] init];
            [self.navigationController pushViewController:idCardKeyboardViewController animated:YES];
        }
            break;
            
        default:
            break;
    }
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    }
    
    return _tableview;
}


-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"TextViewInputController", @"InputViewController", @"KeyboardCoverTextFieldViewController",
                    @"IDCardKeyboardViewController", @"CustomKeyboardViewController"];
    }
    return _titles;
}



@end
