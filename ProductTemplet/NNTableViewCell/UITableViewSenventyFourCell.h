//
//  UITableViewSenventyFourCell.h
//  
//
//  Created by BIN on 2018/4/25.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "NNLabView.h"
 
/**
 文字(icon)+文字(icon)
 */
@interface UITableViewSenventyFourCell : UITableViewCell

@property (nonatomic, strong) NNLabView * labViewOne;
@property (nonatomic, strong) NNLabView * labViewTwo;


@end
