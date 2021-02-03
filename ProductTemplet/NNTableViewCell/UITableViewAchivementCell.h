//
//  UITableViewAchivementCell.h
//  
//
//  Created by BIN on 2018/7/31.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NNGloble/NNGloble.h>
#import <NNCategoryPro/NNCategoryPro.h>

#import "NNMonthView.h"
#import "NNPairLabelView.h"

/**
 生产报表(左年月+右数据)
 */
@interface UITableViewAchivementCell : UITableViewCell

@property (nonatomic, strong) NSArray * itemList;//右侧标题
@property (nonatomic, strong) NSArray * valueList;//右侧标题对应的值

@property (nonatomic, strong) NNMonthView * monthView;
@property (nonatomic, strong) NNPairLabelView * pairView;


@end
