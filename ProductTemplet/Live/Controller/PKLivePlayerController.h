//
//  PKLivePlayerController.h
//  HuiZhuBang
//
//  Created by BIN on 2018/8/21.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKLivePlayerController : UIViewController

- (instancetype)initWithURL:(NSString *)url;

@property(atomic,strong) NSString *url;


@end
