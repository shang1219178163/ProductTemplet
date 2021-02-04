//
//  UITableViewPickerViewCell.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "NNListChooseView.h"

@interface UITableViewPickerViewCell : UITableViewCell

@property (nonatomic, strong) NNListChooseView *chooseView;

@end


