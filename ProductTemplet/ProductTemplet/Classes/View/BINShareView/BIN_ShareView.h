//
//  BINShareView.h
//  ShareInfo
//
//  Created by BIN on 2017/9/1.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BINShareDataModel.h"

@interface BIN_ShareView : UIView

@property (nonatomic,copy) void(^block)(NSInteger);

/*
 topTitle为@"" 空字符时会隐藏顶部;
 btnTitle为@"" 空字符时会隐藏底部;
 */
- (instancetype)initWithShareModels:(NSArray *)shareModels topTitle:(NSString *)topTitle btnTitle:(NSString *)btnTitle;
+ (BIN_ShareView *)shareViewWithShareModels:(NSArray *)shareModels topTitle:(NSString *)topTitle btnTitle:(NSString *)btnTitle;

- (void)show;

@end

