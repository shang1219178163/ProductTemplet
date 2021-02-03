//
//  UITableViewCycleViewCell.h
//  
//
//  Created by BIN on 2018/5/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "NNCycleView.h"

/**
 文本循环往复
 */
@interface UITableViewCycleViewCell : UITableViewCell

@property (nonatomic, strong) NNCycleView *cycleView;

@end
