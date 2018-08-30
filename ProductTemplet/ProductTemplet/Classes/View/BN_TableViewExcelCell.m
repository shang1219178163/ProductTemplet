//
//  BN_TableViewExcelCell.m
//  ChildViewControllers
//
//  Created by hsf on 2018/4/11.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "BN_TableViewExcelCell.h"

@interface BN_TableViewExcelCell ()

@end

@implementation BN_TableViewExcelCell


+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    BN_TableViewExcelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[BN_TableViewExcelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass([self class]);
    return [self cellWithTableView:tableView identifier:identifier];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        //返回系统默认cell,用于cell上只有一个控件时自定义
        
    }
    return self;
}

- (void)createControls{
    //
    
    [self.contentView addSubview:self.groupView];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - - layz

-(UIView *)lineTop{
    if (!_lineTop) {
        _lineTop = [UIView createLineWithRect:CGRectMake(0, 0, kScreen_width, kH_LINE_VIEW) isDash:NO tag:kTAG_VIEW+10];
        _lineTop.hidden = YES;
    }
    return _lineTop;
}

- (BN_LabGroupView *)groupView{
    if (!_groupView) {
        _groupView = [[BN_LabGroupView alloc]initWithFrame:self.contentView.frame];
        _groupView.itemSize = CGSizeMake(80, 50);

    }
    return _groupView;
}

@end
