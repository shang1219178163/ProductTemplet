//
//  BN_TableViewExcelCell.h
//  ChildViewControllers
//
//  Created by hsf on 2018/4/11.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BN_LabGroupView.h"

@interface BN_TableViewExcelCell : UITableViewCell

@property (nonatomic, strong) BN_LabGroupView* groupView;

@property (nonatomic, strong) UIView * lineTop;

+ (instancetype)cellWithTableView:(UITableView *)tableview;
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

@end
