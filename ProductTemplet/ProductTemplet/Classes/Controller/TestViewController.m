//
//  TestViewController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/4.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "TestViewController.h"

#import "BN_Globle.h"
#import "UIView+Helper.h"
#import "UIViewController+Helper.h"
#import "UIColor+Helper.h"

#import "WHKTableViewZeroCell.h"
#import "WHKTableViewOneCell.h"
#import "WHKTableViewTwoCell.h"

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataList;
@property (nonatomic, strong) UIScrollView * scrollView;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"test";
    [self createBarBtnItemWithTitle:@"Timer" imageName:nil isLeft:NO isHidden:NO handler:^(id obj, id item, NSInteger idx) {
        [self goController:@"TimerViewController" title:@"Timer"];
    }];
    
    [self createBarBtnItemWithTitle:@"Next" imageName:nil isLeft:YES isHidden:NO handler:^(id obj, id item, NSInteger idx) {

        DDLog(@"asdfadsf");
    }];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"tim" style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBtn:)];
    
    
    self.dataList = [NSMutableArray arrayWithCapacity:0];
    self.dataList = @[@"",@"",@"",].mutableCopy;

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
}

- (void)handleActionBtn:(UIBarButtonItem *)sender{
    [self goController:@"TimerViewController" title:@"Timer"];

    
}

#pragma mark - -UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    switch (indexPath.row) {
        case 0:
        {
            WHKTableViewZeroCell *cell = [WHKTableViewZeroCell cellWithTableView:tableView];
            //    cell.imgView.image = [UIImage imageNamed:@"bug.png"];
            //    cell.label.text = [NSString stringWithFormat:@"row_%@",@(indexPath.row)];
            
            UILabel * label = [[UILabel alloc]init];
            label.backgroundColor = UIColor.yellowColor;
            label.numberOfLines = 0;
            [cell.contentView addSubview:label];
            
            label.text = @"label.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.text";
            [label makeConstraints:^(MASConstraintMaker *make) {

                make.top.equalTo(cell.contentView.top).offset(0);
                make.left.equalTo(cell.contentView.left).offset(0);
                make.right.equalTo(cell.contentView.right).offset(0);
                make.bottom.equalTo(cell.contentView.bottom).offset(0);
                
                make.width.equalTo(cell.contentView).offset(0);
                
            }];
            
            [cell.contentView getViewLayer];

            return cell;
        }
            break;
        case 1:
        {
            WHKTableViewOneCell *cell = [WHKTableViewOneCell cellWithTableView:tableView];
            cell.contentView.backgroundColor = UIColor.randomColor;
            //
            UIView * backView = [[UIView alloc]init];
            [cell.contentView addSubview:backView];
            
            UILabel * labLast;
            for (NSInteger i = 0; i < 3; i++) {
                UILabel * label = [[UILabel alloc]init];
                label.text = [self ramdomText];
                label.textAlignment = NSTextAlignmentLeft;
                
                label.numberOfLines = 0;
                label.backgroundColor = UIColor.randomColor;
                [backView addSubview:label];
                
                [label makeConstraints:^(MASConstraintMaker *make) {
                    if (labLast) {
                        make.top.equalTo(labLast.bottom).offset(15);
                    }
                    else{
                        make.top.equalTo(backView.top).offset(15);
                        
                    }
                    make.left.equalTo(cell.contentView.left).offset(15);
                    make.right.equalTo(cell.contentView.right).offset(-15);
                }];
                labLast = label;
                
            }
            
            [backView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
                make.bottom.equalTo(labLast.bottom).offset(15);
                
            }];
            [cell getViewLayer];
            return cell;

        }
            break;
        case 2:
        {
            WHKTableViewTwoCell *cell = [WHKTableViewTwoCell cellWithTableView:tableView];
            [cell getViewLayer];
            return cell;

        }
            break;
        default:
            break;
    }
    return nil;
}


#pragma mark - - others funtion

- (NSString *)ramdomText{
    CGFloat length = arc4random()%30 + 5;
    NSMutableString * mstr = [NSMutableString stringWithCapacity:0];
    for (NSUInteger i = 0; i < length; i++) {
        [mstr appendString:@"测试数据,"];
    }
    return mstr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
