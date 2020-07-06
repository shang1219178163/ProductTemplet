//
//  ChannelSteamController.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKChannelListRootModel.h"
#import "PKDeviceListRootModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChannelSteamController : UIViewController

@property (nonatomic, strong) PKDeviceInfoModel *deviceModel ;
@property (nonatomic, strong) PKChannelInfoModel *channelModel ;

@end

NS_ASSUME_NONNULL_END
