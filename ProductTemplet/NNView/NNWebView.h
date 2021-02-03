//
//  NNWebView.h
//  WHWebView
//
//  Created by hsf on 2018/5/11.
//  Copyright © 2018年 魏辉. All rights reserved.
//
 
#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

@interface NNWebView : UIView

@property (nonatomic,strong) WKWebView *wkWebView;  //  WKWebView

/**
 请求的url
 */
@property (nonatomic,copy) NSString *urlString;

/**
 要注入的js方法
 */
@property (nonatomic,copy) NSString *jsString;

/**
 进度条颜色
 */
@property (nonatomic,strong) UIColor *progressColor;

- (void)loadRequest;
- (void)loadRequest:(NSString *)urlString;

@end
