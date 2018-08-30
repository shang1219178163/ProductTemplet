//
//  CompanyProtocol.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompanyProtocol <NSObject>

- (void)addCompany:(id<CompanyProtocol>)company;
- (void)removeCompany:(id<CompanyProtocol>)company;

- (void)display; //展示总公司以及子公司

@end
