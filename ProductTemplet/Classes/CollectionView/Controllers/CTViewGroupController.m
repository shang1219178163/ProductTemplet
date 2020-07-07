//
//  GroupViewController.m
//  BNCollectionView
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CTViewGroupController.h"

#import "NNAlertView.h"
#import "NNAlertViewOne.h"
#import "NNAlertViewTwo.h"

#import "NNFilterView.h"

#import "NNPickerViewAddress.h"
#import "NNPickerViewAddress.h"

@interface CTViewGroupController ()

@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) NSString *address;

@end

@implementation CTViewGroupController

-(NSArray *)itemList{
    if (!_itemList) {
        _itemList = @[@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight"];
    }
    return _itemList;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"group";
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    CGRect rect = CGRectMake(20, 20, kScreenWidth - 20*2, 0);
    UIView * containView = [UIView createViewRect:rect elements:self.itemList numberOfRow:4 viewHeight:30 padding:10];
    [containView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addActionHandler:^(UIControl * _Nonnull control) {
            [self handleActionBtn:(UIButton *)control];

        } forControlEvents:UIControlEventTouchUpInside];
    }];
    
    containView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:containView];
    
    [self.view getViewLayer];
    
}

- (void)handleActionBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
        {
            UIAlertController * alerController = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
            
            [alerController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alerController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alerController animated:YES completion:nil];
        }
            break;
        case 1:
        {
            NNAlertView * alertView = [[NNAlertView alloc]init];
            alertView.dataList = [NSArray repeating:@"测试_" count:3];

            [alertView show];
            
        }
            break;
        case 2:
        {
            
            NSDictionary * dic = @{
//                                   kItemHeader:   @"header_0",
//                                   kItemFooter:   @"footer_0",
                                   kItemObj:   @[
                                           @"去模型_00",
                                           @"去模型_01",
                                           @"去模型_02",],
                                   };

            NNAlertViewOne * alertView = [[NNAlertViewOne alloc]init];
//            alertView.dataList = [NSArray arrayWithItemPrefix:@"数据_" startIndex:1 count:22 type:@0];
            alertView.data = dic;
            alertView.label.text = @"选择死淘原因";

            [alertView show];
            alertView.block = ^(NNAlertViewOne *view, NSIndexPath *indexPath) {
                DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row))
            };
            
        }
            break;
        case 3:
        {
            NNAlertViewTwo * alertView = [[NNAlertViewTwo alloc]init];
            alertView.label.text = nil;
            alertView.imgView.image = [UIImage imageNamed:@"bug"];
            alertView.labelSub.text = @"只用了两年时间，天津东边的一片盐碱地，就让创造了蛇口神话的袁庚都为之紧张。……";
            alertView.items = @[@"取消",@"确定"];
            [alertView show];
            alertView.block = ^(NNAlertViewTwo *view, NSInteger idx) {
                DDLog(@"%@",@(idx))
            };
            [alertView getViewLayer];
            
        }
            break;
        case 4:
        {
//            NNFilterView * view = [[NNFilterView alloc]init];
            NNFilterView * view = [NNFilterView shared];
//            view.direction = @1;
            [view show];
            view.block = ^(NNFilterView *view, NSIndexPath *indexPath, NSInteger idx) {
                DDLog(@"%@,%@",@(indexPath.section),@(indexPath.row))
            };
        }
            break;
        case 5:
        {
            [self createPickerViewTag:5 address:self.address];
        }
            break;
        case 6:
        {
            [self createPickerViewAddress:6 address:self.address];
        }
            break;
        case 7:
        {
            NSDictionary * dict = @{
                                    kAlert_Title:   @"提示信息",
                                    kAlert_Img:   @"bug",
//                                    kAlert_Msg:   @"只用了两年时间，天津东边的一片盐碱地，就让创造了蛇口神话的袁庚都为之紧张。……",
                                    kAlert_Btns:   @[@"取消",@"确定"],
                                    
                                    };
            NNAlertViewTwo * view = [NNAlertViewTwo viewWithParams:dict];
            [view show];
            view.block = ^(NNAlertViewTwo *view, NSInteger idx) {
                NSLog(@"%@",@(idx));
                
            };
        }
            break;
        case 8:
        {
            
        }
            break;
        case 9:
        {
            
        }
            break;
        default:
            break;
    }
    
    
}


#pragma mark - - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //    cell.backgroundColor = [UIColor orangeColor];
    
    cell.imageView.image = [UIImage imageNamed:@"dragon"];
    cell.textLabel.text = @"title";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"row__%ld",indexPath.row];
    
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame),  CGRectGetHeight(cell.frame))];
    backgroudView.backgroundColor = [UIColor cyanColor];
    cell.selectedBackgroundView = backgroudView;
    
    //    NSLog(@"cell-%ld",(long)indexPath.row);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -UIPickerView

- (void)createPickerViewAddress:(NSInteger)tag address:(NSString *)address{
    [self.view endEditing:YES];
    NNPickerViewAddress * view = [[NNPickerViewAddress alloc]initWithCancelTitle:@"取消" confirmTitle:@"确定"];
    view.title = @"请选择";
    view.tag = tag;
    
    if(address.isValid) [view actionSelectAddress:address];
    [self.view addSubview:view];
    
    [view show];
    view.block = ^(UIPickerView *pickerView, NSString *address, NSInteger btnIndex) {
        NSLog(@"BINPickerViewNew_%@_%ld",address,(long)btnIndex);
        if (btnIndex == 1) {
            self.address = address;

        }
    };
}

#pragma mark - -UIPickerView

- (void)createPickerViewTag:(NSInteger)tag address:(NSString *)address{
    [self.view endEditing:YES];
    
    NNPickerViewAddress * view = [[NNPickerViewAddress alloc]initWithCancelTitle:@"取消" confirmTitle:@"确定"];
    view.title = @"请选择";
    view.tag = tag;
    
    [self.view addSubview:view];
    if(address.isValid) [view actionSelectAddress:address];
    
    [view show];
    view.block = ^(UIPickerView *pickerView, NSString *address, NSInteger btnIndex) {
        NSLog(@"BINPickerViewNew_%@_%ld",address,(long)btnIndex);
        if (btnIndex == 1) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            self.address = address;
        }
    };
}


@end
