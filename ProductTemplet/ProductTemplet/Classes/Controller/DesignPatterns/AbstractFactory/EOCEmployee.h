//
//  EOCEmployee.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

/**
 抽象工厂方法 - 类簇
 系统框架中有许多类簇，大部分collection(集合)类都是类族，如NSArray，下面这种代码：
 
 id maybeAnArray =  ... ;
if ([maybeAnArray class] == [NSArray class]) {
    // Will never be hit
}
 其中的if语句永远不可能为真。[maybeAnArray class]所返回的类绝不可能是NSArray类本身，因为由NSArray的初始化方法所返回的那个实例其类型是隐藏在类族公共接口（public facade）后面的某个内部类型（internal type）。
 
 要判断出某个实例所属的类是否位于类族之中，应该使用类型信息查询方法（introspection method），不要直接检测两个“类对象”是否等同，而应该采用下列代码：
 if ([maybeAnArray isKindOfClass:[NSArray class]]) {

 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EOCEmployeeType) {
    EOCEmployeeTypeDeveloper = 0,
    EOCEmployeeTypeDesigner,
    EOCEmployeeTypeFinance,
};

@interface EOCEmployee : NSObject

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSUInteger salary;

// Helper for creating Employee objects
+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type;

// Make Employees do their respective day's work
- (void)doADaysWork;

@end
