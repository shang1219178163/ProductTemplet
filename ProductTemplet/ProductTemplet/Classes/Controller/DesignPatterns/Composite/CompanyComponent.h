//
//  CompanyComponent.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyProtocol.h"

@interface CompanyComponent : NSObject<CompanyProtocol>

@property (nonatomic, copy) NSString *companyName;

- (instancetype)initWithCompanyName:(NSString *)companyName;


@end
