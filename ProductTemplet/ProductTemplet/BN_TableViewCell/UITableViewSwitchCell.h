//
//  UITableViewSwitchCell.h
//  BN_TableViewCell
//
//  Created by Bin Shang on 2018/12/14.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+AddView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 cell - 开关
 */
@interface UITableViewSwitchCell : UITableViewCell

@property (nonatomic, strong) UISwitch *switchCtrl;

@end

NS_ASSUME_NONNULL_END
