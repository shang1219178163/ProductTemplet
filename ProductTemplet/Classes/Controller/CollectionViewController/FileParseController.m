//
//  FileParseController.m
//  BN_CollectionView
//
//  Created by hsf on 2018/9/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FileParseController.h"


@interface FileParseController ()

@end

@implementation FileParseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Update" style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBtn:)];

    
    
    self.tableView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:self.tableView];
}

- (void)handleActionBtn:(UIBarButtonItem *)sender{

    [self handleDataList];
    
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
            [self.tableView reloadData];
            
//            DDLog(@"%@",marr.JSONValue);
        });
        
    });
    
}

#pragma mark - - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.text = [self.dataList[indexPath.row] componentsJoinedByString:@","];
    cell.textLabel.numberOfLines = 3;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
