//
//  BNURLResponse.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNURLResponse.h"

@implementation BNURLResponse

BNURLResponse *BNURLResponseFromParam(__kindof NSURLRequest *request,__kindof NSURLResponse *response, id _Nullable responseObject, NSError * _Nullable error){
    BNURLResponse * model = [[BNURLResponse alloc]init];
    model.request = request;
    model.response = (NSHTTPURLResponse *)response;
    model.responseObject = responseObject;
    model.error = error;
    return model;
}

@end
