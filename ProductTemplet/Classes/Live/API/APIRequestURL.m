//
//  APIRequestURL.m
//  AccessControlSystem
//
//  Created by Bin Shang on 2019/5/22.
//  Copyright © 2019 irain. All rights reserved.
//

#import "APIRequestURL.h"

@implementation APIRequestURL

NSString * const kAPIRequestURLLogin = @"/api/v1/login";

NSString * const kAPIRequestURLLogout = @"/api/v1/logout";

NSString * const kAPIRequestURLUserInfo = @"/api/v1/userInfo";

NSString * const kAPIRequestURLModifyPwd = @"/api/v1/modifypassword";

NSString * const kAPIRequestURLServerinfo = @"/api/v1/getserverinfo";

NSString * const kAPIRequestURLRestart = @"/api/v1/restart";

NSString * const kAPIRequestURLDeviceList = @"/api/v1/device/list";

//NSString * const kAPIRequestURLChannels = @"/api/v1/getchannels";
NSString * const APIRequestURLChannels(NSString *ID){
    return [NSString stringWithFormat:@"/nvc/%@/api/v1/getchannels", ID];
}

//NSString * const kAPIRequestURLChannelstream = @"/api/v1/getchannelstream";
NSString * const APIRequestURLChannelstream(NSString *ID){
    return [NSString stringWithFormat:@"/nvc/%@/api/v1/getchannelstream", ID];
}

NSString * const APIRequestURLTouchcChannelstream(NSString *ID){
    return [NSString stringWithFormat:@"/nvc/%@/api/v1/touchchannelstream", ID];
}

+ (void)requestUrl:(NSString *)url method:(NSString *)method completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    
    DDLog(@"======request info=======")
    DDLog(@"%@",url)
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:6];
    
    NSArray *list = @[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",];
    NSString * string = [list componentsJoinedByString:@","];
    [request addValue:string forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSString *token = [NSUserDefaults objectForKey:@"token"];
    NSNumber *tokenTimeout = [NSUserDefaults objectForKey:@"tokenTimeout"];
    NSString *cookieStr = [NSHTTPCookieStorage cookieDesWithToken:token tokenTimeout:tokenTimeout];
    [request setValue:cookieStr forHTTPHeaderField:@"Set-Cookie"];
    
    [NSURLSession sendAsynRequest:request handler:completionHandler];
//    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:completionHandler];
//    //    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//    //        if (data) {
//    //            //            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    //            //            DDLog(@"%@",dic);
//    //
//    //            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    //            DDLog(@"%@",string);
//    //
//    //        }
//    //    }];
//    [dataTask resume];
}


//+ (NSString *)cookieDesWithToken:(NSString *)token tokenTimeout:(NSNumber *)tokenTimeout{
//    
//    NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:tokenTimeout.integerValue];
//    NSString *expires = [NSDateFormatter stringFromDate:expiresDate format:kFormatDate_Six];
//    
//    NSString *cookieStr = @"";
//    cookieStr = [cookieStr stringByAppendingFormat:@"token=%@;", token];
//    cookieStr = [cookieStr stringByAppendingFormat:@"Path=%@;", @"/"];
//    //    cookieStr = [cookieStr stringByAppendingFormat:@"Expires=%@;", expiresDate];
//    cookieStr = [cookieStr stringByAppendingFormat:@"Expires=%@;", expires];
//    cookieStr = [cookieStr stringByAppendingFormat:@"Max-Age=%@;", tokenTimeout.stringValue];
//    cookieStr = [cookieStr stringByAppendingFormat:@"httpOnly=%@;",@"true"];
//    return cookieStr;
//}

@end
