//
//  ChannleListController.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKDeviceListRootModel.h"
#import "PKChannelListRootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChannleListController : UIViewController

@property (nonatomic, strong) PKDeviceInfoModel *deviceModel;
@property (nonatomic, strong) PKChannelInfoModel *channelModel;

@end

NS_ASSUME_NONNULL_END
