//
//  FileParseController.m
//  NNCollectionView
//
//  Created by hsf on 2018/9/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FileParseController.h"


@interface FileParseController ()

@property(nonatomic, strong) NNTablePlainView *plainView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation FileParseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tbView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:self.plainView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self handleDataList];
    
}

- (void)handleDataList{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray * marr = [NSFileManager paserJsonFile:@"excel.geojson"];
        [marr enumerateObjectsUsingBlock:^(NSMutableArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeObjectAtIndex:0];
            if (![obj.lastObject isEqualToString:@""]) {
                [obj replaceObjectAtIndex:(obj.count - 2) withObject:obj.lastObject];
            }
            [obj removeLastObject];
            
            DDLog(@"'%@' = '%@';\n",obj.firstObject,obj.lastObject);
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataList = marr.copy;
//            [self.tableView reloadData];
            self.plainView.list = self.dataList;
            [self.plainView.tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -lazy

- (NNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[NNTablePlainView alloc]initWithFrame:self.view.bounds];
        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSString * identifier = @"cell";
            UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView identifier:identifier ];
            
            cell.textLabel.text = [self.dataList[indexPath.row] componentsJoinedByString:@","];
            cell.textLabel.numberOfLines = 3;
            return cell;
        };
        _plainView.blockDidSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
            NSLog(@"%ld",(long)indexPath.row);

        };
    }
    return _plainView;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}



@end
