//
//  WHKTableViewFiftyOneCell.h
//  HuiZhuBang
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "BN_TextField.h"

@interface WHKTableViewFiftyOneCell : UITableViewCell

@property (nonatomic, strong) BN_TextField * textFieldLeft;
@property (nonatomic, strong) BN_TextField * textFieldCenter;
@property (nonatomic, strong) BN_TextField * textFieldRight;

@end
