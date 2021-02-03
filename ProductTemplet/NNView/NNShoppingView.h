//
//  BINShoppingCartBottomView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
// 

#import <UIKit/UIKit.h>

#define kH_ShoppingCartView 64

@class NNShoppingView;
@protocol BINShoppingCartBottomViewDelegate <NSObject>

- (void)shoppingCartView:(NNShoppingView *)view sender:(UIButton *)sender;

@end


@interface NNShoppingView : UIView

@property (nonatomic, strong) UIButton * btnRadio;

@property (nonatomic, strong) UILabel * labPriceAll;
@property (nonatomic, strong) UIButton * btnDoIt;

@property (nonatomic, weak) id<BINShoppingCartBottomViewDelegate> delegate;/**< 代理 */

@property (nonatomic, copy) void (^block)(NNShoppingView *view, UIButton *sender);

@end
