//
//  NNProgressHUD.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/7/6.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNProgressHUD : NSObject

+ (void)showText:(NSString *)text centerY:(CGFloat)centerY;

+ (void)showText:(NSString *)text;

+ (void)showLoadingText:(NSString *)text inView:(UIView * _Nullable)inView;

+ (void)showLoadingText:(NSString *)text;

+ (void)showSuccessText:(NSString *)text inView:(UIView * _Nullable)inView;

+ (void)showSuccessText:(NSString *)text;

+ (void)showErrorText:(NSString *)text inView:(UIView * _Nullable)inView;

+ (void)showErrorText:(NSString *)text;

+ (void)dismissInView:(UIView *)view;

+ (void)dismiss;

@end

NS_ASSUME_NONNULL_END
