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
                      @[@"起止时间:", @"108", @"60.0", @"", @"recharge", ],
                      @[@"商品名称:", @"1", @"60.0", @"", @"cardName", ],
                      @[@"*商品数量:", @"105", @"60.0", @"", @"validEndTime", ],
                      @[@"*上架时间:", @"102", @"60.0", @"", @"balance", ],
                      @[@"商品价格:", @"106", @"60.0", @"", @"recharge", @"  元    "],
                      @[@"商品种类:", @"104", @"60.0", @"", @"recharge", @[@"一代", @"二代", @"三代",],],
                      @[@"库存周期:", @"109", @"60.0", @"", @"recharge", ],
                      @[@"继续生产:", @"110", @"60.0", @"", @"recharge", @[@"生产", @"不生产",],],
                      @[@"品牌列表:", @"111", @"60.0", @"", @"recharge", ],
                      @[@"生产厂家:", @"112", @"60.0", @"", @"recharge", ],
                      @[@"*备注信息:", @"107", @"160.0", @"", @"recharge", ],
                      @[@"*default:", @"150", @"60.0", @"", @"recharge", ],
                      
                      ].mutableCopy;
    
    [self.view addSubview:self.tableView];


//    UISwitch *view = [UIView createSwitchRect:CGRectMake(0, 0, 80, 30) isOn:YES];
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.frame = CGRectMake(0, 0, 80, 30);
    [view setTitle:@"BTN" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    [view addActionHandler:^(id obj, id item, NSInteger idx) {
        DDLog(@"%@",item);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *itemList = self.dataList[indexPath.section];
    return [itemList[2] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *itemList = self.dataList[indexPath.row];
    NSString *value0 = itemList[0];
    NSString *value1 = itemList[1];
    NSString *value2 = itemList[2];
    NSString *value3 = itemList[3];
    NSString *value4 = itemList[4];

    switch ([itemList[1] integerValue]) {
        case 1:
        {
            UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
            cell.labelRight.text = value4;
            [cell getViewLayer];
            return cell;
            
        }
            break;
        case 102:
        {
            UITableViewDatePickerCell * cell = [UITableViewDatePickerCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
            cell.labelLeft.attributedText = [cell.labelLeft.text toAsterisk];
            [cell getViewLayer];
            return cell;
            
        }
            break;
        case 104:
        {
            UITableViewSegmentCell * cell = [UITableViewSegmentCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
            cell.segmentCtrl.itemList = @[@"one",@"two",@"three",@"four"];
            DDLog(@"_%p,%@,%ld",cell.segmentCtrl,cell.segmentCtrl.itemList,cell.segmentCtrl.numberOfSegments);
            [cell.segmentCtrl addActionHandler:^(id obj, id item, NSInteger idx) {
                UISegmentedControl *view = item;
                DDLog(@"_____%ld,%@",view.selectedSegmentIndex,view.itemList);
                //                DDLog(@"%@,%ld,%ld",item,item.selectedSegmentIndex,idx)
                
            }];
            [cell getViewLayer];
            return cell;
        }
            break;
        case 105:
        {
            UITableViewStepCell * cell = [UITableViewStepCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;

            [cell getViewLayer];
            return cell;
        }
            break;
        case 106:
        {
            UITableViewTextFieldCell * cell = [UITableViewTextFieldCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;

            [cell getViewLayer];
            return cell;
        }
            break;
        case 107:
        {
            UITableViewTextViewCell * cell = [UITableViewTextViewCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;

            
            [cell getViewLayer];
            return cell;
        }
            break;
        case 108:
        {
            UITableViewDateRangeCell * cell = [UITableViewDateRangeCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;

            [cell getViewLayer];
            return cell;
        }
            break;
        case 109:
        {
            UITableViewSliderCell * cell = [UITableViewSliderCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;

            [cell getViewLayer];
            return cell;
        }
            break;
        case 110:
        {
            UITableViewSwitchCell* cell = [UITableViewSwitchCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
//            cell.switchCtrl.on = NO;
            [cell.switchCtrl addActionHandler:^(id obj, id item, NSInteger idx) {
                UISwitch *view = item;
                DDLog(@"_____%@",@(view.isOn));
                //                DDLog(@"%@,%ld,%ld",item,item.selectedSegmentIndex,idx)
                
            }];
              [cell getViewLayer];
            return cell;
        }
            break;
        case 111:
        {
            UITableViewSheetCell* cell = [UITableViewSheetCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;

            [cell getViewLayer];
            return cell;
        }
            break;
        case 112:
        {
            UITableViewPickerViewCell* cell = [UITableViewPickerViewCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;

            [cell getViewLayer];
            return cell;
        }
            break;
        case 200:
        {
            
            UITableViewPickerListCell * cell = [UITableViewPickerListCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
            cell.dic = self.dic;
            
              [cell getViewLayer];
            return cell;
        }
            break;
        case 201:
        {
            
            UITableViewAddressPickerCell * cell = [UITableViewAddressPickerCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;

            
              [cell getViewLayer];
            return cell;
        }
            break;
            
        default:
            break;
    }
    UITableViewZeroCell * cell = [UITableViewZeroCell cellWithTableView:tableView];
    return cell;
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
