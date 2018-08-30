//
//  BINShoppingCartBottomView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kH_ShoppingCartView 64

@class BN_ShoppingView;
@protocol BINShoppingCartBottomViewDelegate <NSObject>

- (void)shoppingCartView:(BN_ShoppingView *)view sender:(UIButton *)sender;

@end


@interface BN_ShoppingView : UIView

@property (nonatomic, strong) UIButton * btnRadio;

@property (nonatomic, strong) UILabel * labPriceAll;
@property (nonatomic, strong) UIButton * btnDoIt;

//@property (nonatomic, strong) NSString * orderCount;
//@property (nonatomic, strong) NSString * orderPriceAll;

@property (nonatomic, weak) id<BINShoppingCartBottomViewDelegate> delegate;/**< 代理 */

@property (nonatomic, copy) void (^block)(BN_ShoppingView *view, UIButton *sender);

@end
