//
//  WHKTableViewAchivementCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/7/31.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BN_MonthView.h"
#import "BN_PairLabelView.h"

@interface WHKTableViewAchivementCell : UITableViewCell

@property (nonatomic, strong) NSArray * itemList;//右侧标题
@property (nonatomic, strong) NSArray * valueList;//右侧标题对应的值

@property (nonatomic, strong) BN_MonthView * monthView;
@property (nonatomic, strong) BN_PairLabelView * pairView;


@end
