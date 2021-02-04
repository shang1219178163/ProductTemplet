//
//  UITableViewSenventyTwoCell.h
//  
//
//  Created by BIN on 2018/4/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "NNLabView.h"

/**
 文字(icon)+文字(icon)+文字(icon)+文字(icon)
 */
@interface UITableViewSenventyTwoCell : UITableViewCell

@property (nonatomic, strong) NNLabView * labViewOne;
@property (nonatomic, strong) NNLabView * labViewTwo;
@property (nonatomic, strong) NNLabView * labViewThree;
@property (nonatomic, strong) NNLabView * labViewFour;


@end
