//
//  UITableViewThirtySixCell.h
//  
//
//  Created by BIN on 2017/11/9.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "NNImgLabelView.h"

/**
 icon+文字
 文字2        图像
 文字3
 */
@interface UITableViewThirtySixCell : UITableViewCell

@property (nonatomic, strong) NNImgLabelView * imgLabView;

@end
