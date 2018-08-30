//
//  WHKTableViewTenCell.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/22.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

@interface WHKTableViewTenCell : UITableViewCell

@property (nonatomic, strong) BN_TextField * textField;

@property (nonatomic, assign) CGFloat cellGapX;
@property (nonatomic, assign) CGFloat cellGapY;


@end
