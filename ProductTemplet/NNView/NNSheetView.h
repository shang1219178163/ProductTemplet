//
//  NNSheetView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NNGloble/NNGloble.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNSheetView : UIView

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) NNTextField * textField;

@property (nonatomic, strong) UIAlertController * alertCtrl;

@end

NS_ASSUME_NONNULL_END
