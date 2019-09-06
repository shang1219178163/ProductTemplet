//
//  NNPageInfoModel.m
//  PageScrollow
//
//  Created by bjovov on 2017/11/8.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "NNPageInfoModel.h"

@implementation NNPageInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [self init];
    if (self == nil) return nil;
    
    [self setValuesForKeysWithDictionary:dictionary];
    return self;
}

@end

