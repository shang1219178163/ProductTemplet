//
//  WHKTableViewZeroCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewZeroCell.h"

@interface WHKTableViewZeroCell ()

@end

@implementation WHKTableViewZeroCell

//+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
//    WHKTableViewZeroCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if(!cell){
//        cell = [[WHKTableViewZeroCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.separatorInset = UIEdgeInsetsZero;
//
//    return cell;
//}
//
//+(instancetype)cellWithTableView:(UITableView *)tableView{
//    NSString *identifier = NSStringFromClass([self class]);
//    return [self cellWithTableView:tableView identifier:identifier];
//}

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
    self.textLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
