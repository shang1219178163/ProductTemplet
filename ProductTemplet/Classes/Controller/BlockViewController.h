//
//  BlockViewController.h
//  ProductTemplet
//
//  Created by BIN on 2018/10/26.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockViewController : UIViewController

@property(nonatomic, copy) void(^block)(UIViewController * controller, NSString * title);

@end

NS_ASSUME_NONNULL_END
