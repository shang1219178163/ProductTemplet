//
//  EntryViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/10/26.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()

@property(nonatomic, strong) NSDictionary * dic;

@end

@implementation EntryViewController

-(NSDictionary *)dic{
    if (!_dic) {
        _dic = @{
                 @1 :   @"分类一",
                 @2 :   @"分类二",
                 @3 :   @"分类三",
                 
                 };
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataList = @[
                      @"UITableViewDatePickerCell",
                      @"UITableViewDateRangeCell",
                      @"UITableViewSegmentCell",
                      @"UITableViewStepCell",
                      @"UITableViewPickerListCell",
                      @"UITableViewAddressPickerCell",
                      @"UITableViewTextFieldCell",
                      @"UITableViewTextViewCell",
                      
                      ].mutableCopy;
    
    [self.view addSubview:self.tableView];

    NSLog(@"\n%@",NSHomeDirectory());

//    UISwitch *view = [UIView createSwitchRect:CGRectMake(0, 0, 80, 30) isOn:YES];
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.frame = CGRectMake(0, 0, 80, 30);
    [view setTitle:@"button" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];

    [view addActionHandler:^(id obj, id item, NSInteger idx) {
       
        DDLog(@"%@",item);
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataList.count - 1) {
        return 180;
    }
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    UITableViewDatePickerCell * cell = [UITableViewDatePickerCell cellWithTableView:tableView];
    
    switch (indexPath.row) {
        case 0:
        {
            UITableViewDatePickerCell * cell = [UITableViewDatePickerCell cellWithTableView:tableView];
            cell.labelLeft.text = @"*日期选择:";
            cell.labelLeft.attributedText = [cell.labelLeft.text toAsterisk];
            return cell;
            
        }
            break;
        case 1:
        {
            UITableViewDateRangeCell * cell = [UITableViewDateRangeCell cellWithTableView:tableView];
            cell.labelLeft.text = @"日期选择:";
            
            return cell;
        }
            break;
        case 2:
        {
            UITableViewSegmentCell * cell = [UITableViewSegmentCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商品易碎:";
            cell.segmentCtrl.itemList = @[@"one",@"two",@"three",@"four"];
            DDLog(@"_%p,%@,%ld",cell.segmentCtrl,cell.segmentCtrl.itemList,cell.segmentCtrl.numberOfSegments);
            [cell.segmentCtrl addActionHandler:^(id obj, id item, NSInteger idx) {
                UISegmentedControl *view = item;
                DDLog(@"_____%ld,%@",view.selectedSegmentIndex,view.itemList);
//                DDLog(@"%@,%ld,%ld",item,item.selectedSegmentIndex,idx)
                
            }];
            return cell;
        }
            break;
        case 3:
        {
            UITableViewSwitchCell* cell = [UITableViewSwitchCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商品是够免快递费";
//            cell.switchCtrl.on = NO;
            [cell.switchCtrl addActionHandler:^(id obj, id item, NSInteger idx) {
                UISwitch *view = item;
                DDLog(@"_____%@",@(view.isOn));
                //                DDLog(@"%@,%ld,%ld",item,item.selectedSegmentIndex,idx)
                
            }];
            return cell;
        }
            break;
        case 4:
        {
            UITableViewStepCell * cell = [UITableViewStepCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商品名称:";
            
            return cell;
        }
            break;
        case 5:
        {
            
            UITableViewPickerListCell * cell = [UITableViewPickerListCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商品分类:";
            cell.dic = self.dic;
            
            return cell;
        }
            break;
        case 6:
        {
            
            UITableViewAddressPickerCell * cell = [UITableViewAddressPickerCell cellWithTableView:tableView];
            cell.labelLeft.text = @"商家地址:";
            
            
            return cell;
        }
            break;
        case 7:
        {
            UITableViewTextFieldCell * cell = [UITableViewTextFieldCell cellWithTableView:tableView];
            cell.labelLeft.text = @"输入姓名:";
            
            return cell;
        }
            break;
            
        case 8:
        {
            UITableViewTextViewCell * cell = [UITableViewTextViewCell cellWithTableView:tableView];
            cell.labelLeft.text = @"备注信息:";
            
            [cell getViewLayer];
            
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

-(void)handleActionSender:(UISegmentedControl *)sender{
    
    DDLog(@"%@",@(sender.selectedSegmentIndex));
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    BN_CTViewCellOne * cell = [BN_CTViewCellOne viewWithCollectionView:collectionView indexPath:indexPath];
//
//
//    return cell;
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
