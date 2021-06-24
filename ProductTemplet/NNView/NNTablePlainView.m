//
//  NNTablePlainView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/22.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNTablePlainView.h"
#import "NNCategoryPro.h"

@interface NNTablePlainView ()
@property (nonatomic, strong) UIView * headerView;

@end

@implementation NNTablePlainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        
    }
    return self;
}

#pragma mark - - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.rowHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.blockCellForRow && self.blockCellForRow(tableView, indexPath)) {
        return self.blockCellForRow(tableView, indexPath);
    }
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.blockDidSelectRow != nil) {
        return self.blockDidSelectRow(tableView, indexPath);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (self.hasTips == true && self.type == 0) ? CGRectGetHeight(self.headerView.frame) : 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //    if (self.hasTips == true && self.type == 0) {
    //        self.label.text = self.list.count > 0 ? [NSString stringWithFormat:@"发现%@条符合条件的数据 👀",@(self.list.count)] : @"未发现符合条件的数据 😞";
    //    }
    return self.headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UILabel alloc]init];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isCanEdit = self.blockEditActionsForRow && self.blockEditActionsForRow(tableView, indexPath).count > 0;
    return isCanEdit;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.blockEditActionsForRow && self.blockEditActionsForRow(tableView, indexPath)) {
        return self.blockEditActionsForRow(tableView, indexPath);
    }
    return @[];
}

#pragma mark - - set

-(void)setHasTips:(BOOL)hasTips{
    _hasTips = hasTips;
    
    self.label.hidden = !hasTips;
}

-(void)setInputString:(NSString *)inputString{
    _inputString = inputString;
    if ([inputString isEqualToString:@""]) return;
    
    switch (self.type) {
        case 1:
        {
            self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 50);
            self.label.center = CGPointMake(self.center.x, 200);
            
            NSString * colorStr = [NSString stringWithFormat:@" '%@' ",inputString];
            NSString * allStr = [NSString stringWithFormat:@"没有找到与%@相关的记录",colorStr];
            self.label.attributedText = [NSAttributedString getAttString:allStr
                                                                textTaps:@[colorStr]
                                                                    font:16
                                                                   color:UIColor.blackColor
                                                                tapColor:UIColor.redColor
                                                               alignment:NSTextAlignmentCenter];
            
            //            self.label.text = allStr;
            //            self.label.textAlignment = NSTextAlignmentCenter;
            
        }
            break;
        default:
            self.label.text = self.list.count > 0 ? [NSString stringWithFormat:@"发现%@条符合条件的数据 👀",@(self.list.count)] : @"未发现符合条件的数据 😞";
            
            break;
    }
}

- (void)setList:(NSMutableArray *)list{
    _list = list;
    
    if (list == nil) _list = @[].mutableCopy;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.hidden = (self->_list.count == 0 && self.hasTips == true) ? false : true;
        [self.tableView reloadData];
    });
}

#pragma mark -lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *view = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.separatorInset = UIEdgeInsetsZero;
            view.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            view.rowHeight = 60;
            view.backgroundColor = UIColor.backgroudColor;
            view.tableFooterView = [[UIView alloc]init];
            //        table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
            [view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
            if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) view.dataSource = self;
            if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) view.delegate = self;
            view;
        });
    }
    return _tableView;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = ({
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30)];
            [view addSubview:self.label];
            view;
        });
    }
    return _headerView;
}

- (UILabel *)label {
    if (!_label) {
        _label = ({
            UILabel *view = [[UILabel alloc]init];
            view.frame = CGRectMake(15, 5, CGRectGetWidth(self.frame) - 15*2, 60);
            view.numberOfLines = 0;
            view.lineBreakMode = NSLineBreakByWordWrapping;
            view.font = [UIFont systemFontOfSize:15];
            view.textAlignment = NSTextAlignmentLeft;
            view;
        });
    }
    return _label;
}

@end
