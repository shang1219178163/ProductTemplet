//
//  BNSheetView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNSheetView : UIView

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) BN_TextField * textField;

@property (nonatomic, strong) UIAlertController * alertCtrl;

@end

NS_ASSUME_NONNULL_END
