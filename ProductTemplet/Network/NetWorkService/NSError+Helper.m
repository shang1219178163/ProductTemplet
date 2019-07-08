//
//  NSError+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NSError+Helper.h"
#import <objc/runtime.h>

@implementation NSError (Helper)

-(id)obj{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setObj:(id)obj{
    objc_setAssociatedObject(self, @selector(obj), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)requstCode{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setRequstCode:(NSInteger)requstCode{
    objc_setAssociatedObject(self, @selector(requstCode), @(requstCode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)message{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMessage:(NSString *)message{
    objc_setAssociatedObject(self, @selector(message), message, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(instancetype)errorWithMessage:(NSString *)message code:(NSInteger)code obj:(id)obj{
    NSError * error = [[NSError alloc]init];
    error.message = message;
    error.requstCode = code;
    error.obj = obj;
    return error;
}

@end
