//
//  NSObject+Request.m
//  HuiZhuBang
//
//  Created by hsf on 2018/8/3.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NSObject+Request.h"

@implementation NSObject (Request)


- (void)printCookieStorage:(NSHTTPCookieStorage *)cookieStorage{
    
    DDLog(@"cookieStorage: %@",cookieStorage);
    
    for(NSHTTPCookie *cookie in cookieStorage.cookies){
        
        DDLog(@"-----cookie: %@_%@",cookie, cookie.value);
        
//        if ([cookie.name isEqualToString:@"JSESSIONID"]) {
//
//        }
    }
    
}

- (void)printCookieStorage{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];

    [self printCookieStorage:cookieStorage];
    
}

@end
