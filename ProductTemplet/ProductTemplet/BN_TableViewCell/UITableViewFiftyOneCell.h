//
//  UITableViewFiftyOneCell.h
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BN_TextField.h"

/**
 文字+textField+textField+textField
 */
@interface UITableViewFiftyOneCell : UITableViewCell

@property (nonatomic, strong) BN_TextField * textFieldLeft;
@property (nonatomic, strong) BN_TextField * textFieldCenter;
@property (nonatomic, strong) BN_TextField * textFieldRight;

@end
