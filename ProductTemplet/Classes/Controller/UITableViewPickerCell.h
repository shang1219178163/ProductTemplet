//
//  UITableViewPickerCell.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/2/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNPickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewPickerCell : UITableViewCell

@property (nonatomic, strong) BNPickerView * chooseView;

@end

NS_ASSUME_NONNULL_END
