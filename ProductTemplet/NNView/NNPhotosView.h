//
//  NNPhotosView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/10/19.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
// 
/**
 点击任意地方,弹出全屏图片展示
 用法
 NNPhotosView * dispalyView = [[NNPhotosView alloc]initWithImages:self.images];
 [dispalyView show];
 */
#import <UIKit/UIKit.h>

@interface NNPhotosView : UIView

-(instancetype)initWithImages:(NSArray *)images;

-(void)show;

-(void)dismiss;

@end
