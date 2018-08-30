//
//  BN_AlertViewTwo.h
//  BINAlertView
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kAlert_Title = @"kAlert_Title";
static NSString * const kAlert_Msg = @"kAlert_Msg";
static NSString * const kAlert_Img = @"kAlert_Img";
static NSString * const kAlert_Btns = @"kAlert_Btns";

@interface BN_AlertViewTwo : UIView

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UILabel * labelSub;

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) NSDictionary * params;

@property (nonatomic, copy) void (^block)(BN_AlertViewTwo * view,NSInteger idx);

+(instancetype)viewWithParams:(NSDictionary *)params;

- (void)show;
- (void)dismiss;

@end
