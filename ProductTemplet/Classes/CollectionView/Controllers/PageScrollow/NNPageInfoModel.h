//
//  NNPageInfoModel.h
//  PageScrollow
//
//  Created by bjovov on 2017/11/8.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNPageInfoModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *tip;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
