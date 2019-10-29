//
//  BNURLResponse.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNURLResponse : NSObject

NNURLResponse *BNURLResponseFromParam(__kindof NSURLRequest *request,__kindof NSURLResponse *response, id _Nullable responseObject, NSError * _Nullable error);

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSError *errorOther;

@end

NS_ASSUME_NONNULL_END
