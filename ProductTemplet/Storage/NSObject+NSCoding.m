//
//  NSObject+NSCoding.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NSObject+NSCoding.h"
#import <YYModel/YYModel.h>

@implementation NSObject (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)coder{
//    self = [super initWithCoder:coder];
//    if (self) {
        [self yy_modelInitWithCoder:coder];
//    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [self yy_modelEncodeWithCoder:coder];
    
}


@end
