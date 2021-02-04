//
//  UITableViewCellDefault.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "NNCellDefaultView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCellDefault : UITableViewCell

@property (nonatomic, strong) NNCellDefaultView * defaultView;

@end

NS_ASSUME_NONNULL_END
