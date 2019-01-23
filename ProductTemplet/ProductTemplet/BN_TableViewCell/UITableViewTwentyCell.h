//
//  UITableViewTwentyCell.h
//  
//
//  Created by BIN on 2017/9/25.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BN_LabView.h"

/**
 图片+文字
 图片+文字
 图片+文字
 */
@interface UITableViewTwentyCell : UITableViewCell

@property (nonatomic, strong) BN_LabView * labViewOne;
@property (nonatomic, strong) BN_LabView * labViewTwo;
@property (nonatomic, strong) BN_LabView * labViewThree;


@end
