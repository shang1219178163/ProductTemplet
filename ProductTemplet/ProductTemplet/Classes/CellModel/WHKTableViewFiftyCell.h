//
//  WHKTableViewFiftyCell.h
//  HuiZhuBang
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

#import "PPNumberButton.h"

@interface WHKTableViewFiftyCell : UITableViewCell

@property (nonatomic, strong) PPNumberButton * numberBtnLeft;
@property (nonatomic, strong) PPNumberButton * numberBtnRight;

@end
