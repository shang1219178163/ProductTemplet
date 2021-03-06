//
//  CompanyComponent.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CompanyComponent.h"

@interface CompanyComponent ()

@property (nonatomic, strong) NSMutableArray *childList;

@end

@implementation CompanyComponent

- (instancetype)initWithCompanyName:(NSString *)companyName {
    self = [super init];
    if (self) {
        _companyName = companyName;
        
        _childList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)addCompany:(id<CompanyProtocol>)company {
    [self.childList addObject:company];
}

- (void)removeCompany:(id<CompanyProtocol>)company {
    [self.childList removeObject:company];
}

- (void)display {
    NSLog(@"公司名称:%@", self.companyName);
    for (id<CompanyProtocol> company in self.childList) {
        [company display];
    }
}

@end
