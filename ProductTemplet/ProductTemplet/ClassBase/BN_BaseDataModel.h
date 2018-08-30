//
//  BN_BaseDataModel.h
//  UISearchControllerDemo
//
//  Created by BIN on 2018/3/2.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

/**
 数据模型根类
 所有数据模型均需继承此类[本地模型/net模型(网络模型)]
 
 此类会自动重写description方法
      自动实现encodeWithCoder/initWithCoder方法
 */

#import <Foundation/Foundation.h>

@interface BN_BaseDataModel : NSObject

@end
