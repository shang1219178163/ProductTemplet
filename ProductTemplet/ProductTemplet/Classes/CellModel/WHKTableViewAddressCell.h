//
//  WHKTableViewAddressCell.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/21.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHKTableViewAddressCell : UITableViewCell

@property (nonatomic, strong) BN_TextField * textField;

@property (nonatomic, strong) UIView * lineTop;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
