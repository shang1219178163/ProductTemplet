//
//  CATransaction+Helper.h
//  VCTransitioning
//
//  Created by hsf on 2018/8/10.
//  Copyright © 2018年 Baymax. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

CA_EXTERN NSString * const kCATransitionCube;
CA_EXTERN NSString * const kCATransitionSuckEffect;
CA_EXTERN NSString * const kCATransitionOglFlip;
CA_EXTERN NSString * const kCATransitionRippleEffect;
CA_EXTERN NSString * const kCATransitionPageCurl;
CA_EXTERN NSString * const kCATransitionPageUnCurl;
CA_EXTERN NSString * const kCATransitionCameraIrisHollowOpen;
CA_EXTERN NSString * const kCATransitionCameraIrisHollowClose;

@interface CATransaction (Helper)

+ (CATransition *)animationType:(NSString *)type subType:(id)subType;

@end
