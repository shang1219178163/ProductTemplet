//
//  EntryViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/10/26.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "EntryViewController.h"
#import "BNSuspendBtn.h"

@interface EntryViewController ()

@property(nonatomic, strong) NSDictionary * dic;
@property(nonatomic, strong) BNSuspendBtn * suspendBtn;

@end

@implementation EntryViewController

-(BNSuspendBtn *)suspendBtn{
    if (!_suspendBtn) {
        _suspendBtn = [[BNSuspendBtn alloc]initWithFrame:CGRectMake(kScreenWidth - 60, 80, 60, 60)];
        _suspendBtn.insets = UIEdgeInsetsMake(40, 60, 80, 100);
        _suspendBtn.parController = self;
        [_suspendBtn addActionHandler:^(UIControl * _Nonnull control) {
            DDLog(@"%@",@(control.center));
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _suspendBtn;
}

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
    [self.view addSubview:self.tableView];

    [self.view addSubview: self.suspendBtn];
    
    self.dataList = @[
                      @[@"*起止时间:", @"108", @"60.0", @"", @"recharge", ],
                      @[@"*商品名称:", @"1", @"60.0", @"", @"cardName", ],
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
    

    [self createBarItemTitle:@"Next" imgName:nil isLeft:false isHidden:false handler:^(id obj, UIButton *item, NSInteger idx) {
        [self goController:@"CustomViewController" title:nil];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *itemList = self.dataList[indexPath.row];
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
            cell.imgViewRight.hidden = false;

            [cell getViewLayer];
            return cell;
            
        }
            break;
        case 102:
        {
            UITableViewDatePickerCell * cell = [UITableViewDatePickerCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
            [cell getViewLayer];
            return cell;
            
        }
            break;
        case 104:
        {
            UITableViewSegmentCell * cell = [UITableViewSegmentCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
            cell.segmentCtl.itemList = @[@"one",@"two",@"three",@"four"];
            DDLog(@"_%p,%@,%ld",cell.segmentCtl,cell.segmentCtl.itemList,cell.segmentCtl.numberOfSegments);
            [cell.segmentCtl addActionHandler:^(UIControl * _Nonnull control) {
                UISegmentedControl *view = control;
                DDLog(@"_____%ld,%@",view.selectedSegmentIndex,view.itemList);
            } forControlEvents:UIControlEventValueChanged];
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
//            cell.type = @1;
            cell.textView.placeHolderTextView.text = @"最多140字";
            
            [cell getViewLayer];
            return cell;
        }
            break;
        case 108:
        {
            UITableViewDateRangeCell * cell = [UITableViewDateRangeCell cellWithTableView:tableView];
            cell.dateRangeView.labelLeft.text = value0;
            cell.dateRangeView.block = ^(BNDateRangeView *view) {
                DDLog(@"%@至%@",view.dateStart,view.dateEnd);
            };
            [cell getViewLayer];
            return cell;
        }
            break;
        case 109:
        {
            UITableViewSliderCell * cell = [UITableViewSliderCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
            [cell.sliderView.sliderCtl addActionHandler:^(UIControl * _Nonnull control) {
                UISlider * slider = control;
                DDLog(@"%@", @(slider.value));
            } forControlEvents:UIControlEventValueChanged];
            [cell getViewLayer];
            return cell;
        }
            break;
        case 110:
        {
            UITableViewSwitchCell* cell = [UITableViewSwitchCell cellWithTableView:tableView];
            cell.labelLeft.text = value0;
//            cell.switchCtrl.on = NO;
            [cell.switchView.switchCtl addActionHandler:^(id obj, id item, NSInteger idx) {
                UISwitch *view = item;
                DDLog(@"_____%@",@(view.isOn));
                //                DDLog(@"%@,%ld,%ld",item,item.selectedSegmentIndex,idx)
                
            }];
//              [cell getViewLayer];
            return cell;
        }
            break;
        case 111:
        {
            UITableViewSheetCell* cell = [UITableViewSheetCell cellWithTableView:tableView];
            cell.sheetView.labelLeft.text = value0;

            [cell getViewLayer];
            return cell;
        }
            break;
        case 112:
        {
            UITableViewPickerViewCell* cell = [UITableViewPickerViewCell cellWithTableView:tableView];
            cell.chooseView.labelLeft.text = value0;
            
            @weakify(cell);
            cell.chooseView.pickerView.block = ^(BNPickerListView *view, NSIndexPath *indexP, NSString * text) {
                @strongify(cell);
                cell.chooseView.textField.text = text;
                
            };
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
    UITableViewCellDefault * cell = [UITableViewCellDefault cellWithTableView:tableView];
    cell.defaultView.labelLeft.text = value0;
    cell.defaultView.labelRight.text = value4;
    cell.defaultView.imgViewRight.hidden = false;
    [cell getViewLayer];
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
//    BNCTViewCellOne * cell = [BNCTViewCellOne viewWithCollectionView:collectionView indexPath:indexPath];
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
