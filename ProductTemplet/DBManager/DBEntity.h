//
//  DBEntity.h
//  ProductTemplet
//
//  Created by BIN on 2018/5/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBEntity : NSObject

//字典对象转为实体对象
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity;

//实体对象转为字典对象
+ (NSDictionary *) entityToDictionary:(id)entity;

@end
