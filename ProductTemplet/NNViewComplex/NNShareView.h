//
//  NNShareView.h
//  BINAlertView
//
//  Created by BIN on 2018/5/18.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 分享视图
 */ 
@interface NNShareView : UIView
 
@property (nonatomic, copy) void(^block)(NNShareView * view, NSIndexPath * indexPath);

- (void)show;

@end
