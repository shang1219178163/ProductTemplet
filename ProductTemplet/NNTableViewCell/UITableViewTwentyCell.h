//
//  UITableViewTwentyCell.h
//  
//
//  Created by BIN on 2017/9/25.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "NNLabView.h"

/**
 图片+文字
 图片+文字
 图片+文字
 */
@interface UITableViewTwentyCell : UITableViewCell

@property (nonatomic, strong) NNLabView * labViewOne;
@property (nonatomic, strong) NNLabView * labViewTwo;
@property (nonatomic, strong) NNLabView * labViewThree;


@end
