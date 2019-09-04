//
//  NNWalletView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/19.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNWalletView : UIView

@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) NSNumber *type;

@property (nonatomic, copy) void(^block)(NNWalletView *walletView, UIView *view);

@end

NS_ASSUME_NONNULL_END
