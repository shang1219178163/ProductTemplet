//
//  InspirationModel.m
//  ParallaxCustomLayout
//
//  Created by bjovov on 2017/11/2.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "InspirationModel.h"

@implementation InspirationModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [self init];
    if (self == nil) return nil;
    
    [self setValuesForKeysWithDictionary:dictionary];
    return self;
}

@end
