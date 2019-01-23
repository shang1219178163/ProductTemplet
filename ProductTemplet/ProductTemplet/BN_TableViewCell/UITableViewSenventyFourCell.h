//
//  UITableViewSenventyFourCell.h
//  
//
//  Created by BIN on 2018/4/25.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BN_LabView.h"
 
/**
 文字(icon)+文字(icon)
 */
@interface UITableViewSenventyFourCell : UITableViewCell

@property (nonatomic, strong) BN_LabView * labViewOne;
@property (nonatomic, strong) BN_LabView * labViewTwo;


@end
