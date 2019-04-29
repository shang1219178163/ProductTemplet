//
//  NSError+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSError (Helper)

@property (nonatomic, strong) id obj;
@property (nonatomic, assign) NSInteger requstCode;
@property (nonatomic, assign) NSString *message;

/**
 扩展方法
 */
+(instancetype)errorWithMessage:(NSString *)message code:(NSInteger)code obj:(id)obj;

@end

