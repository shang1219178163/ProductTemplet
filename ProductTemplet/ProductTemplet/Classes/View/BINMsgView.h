//
//  BINMsgView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/10/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BINMsgView : UIView

- (UIView *)msgViewTitle:(NSString *)title message:(NSString *)message;

@property (nonatomic, strong) UILabel * labTitle;
@property (nonatomic, strong) UILabel * labContent;

@property (nonatomic, assign, readonly)CGFloat height;

@end
