//
//  DBManager.h
//  ProductTemplet
//
//  Created by BIN on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DBOperationType){
    DBOperationTypeTableCreate = 1,
    DBOperationTypeTableDrop ,
    DBOperationTypeTableAlter ,
    DBOperationTypeTableSelect ,
    
    DBOperationTypeInsert ,
    DBOperationTypeDelete ,
    DBOperationTypeUpdate ,
    
    DBOperationTypeTotal ,//总数
    DBOperationTypeSum ,//求和
    DBOperationTypeAvg ,//求平均值
    DBOperationTypeMax ,//求最大值
    DBOperationTypeMin ,//求最小值
    
};


@class Person,Car;

@interface DBManager : NSObject

+ (instancetype)shared;


// 表本身(创建,修改,删除)
- (void)operationTableWithSQL:(NSString *)sql type:(DBOperationType)type;

- (NSString *)getSQLArgumentsWithKeys:(NSArray *)keys dic:(NSDictionary *)dic middle:(NSString *)middle;

- (NSString *)SQLcreateTable:(NSString *)tableName params:(NSArray *)params;
- (NSString *)SQLalterTable:(NSString *)tableName params:(NSArray *)params type:(NSNumber *)type;
- (NSString *)SQLselectTable:(NSString *)tableName params:(NSArray *)params wheres:(NSArray *)wheres;
- (NSString *)SQLselectAllTable:(NSString *)tableName;


- (NSString *)SQLinsertTable:(NSString *)tableName params:(NSArray *)params;
- (NSString *)SQLDeleteTable:(NSString *)tableName wheres:(NSArray *)wheres;
- (NSString *)SQLupdateTable:(NSString *)tableName dic:(NSDictionary *)dic wheres:(NSArray *)wheres;

#pragma mark - Person
/**
 *  添加person
 *
 */
- (void)addPerson:(Person *)person;
/**
 *  删除person
 *
 */
- (void)deletePerson:(Person *)person;
/**
 *  更新person
 *
 */
- (void)updatePerson:(Person *)person;

/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllPerson;

#pragma mark - Car


/**
 *  给person添加车辆
 *
 */
- (void)addCar:(Car *)car toPerson:(Person *)person;
/**
 *  给person删除车辆
 *
 */
- (void)deleteCar:(Car *)car fromPerson:(Person *)person;
/**
 *  获取person的所有车辆
 *
 */
- (NSMutableArray *)getAllCarsFromPerson:(Person *)person;
/**
 *  删除person的所有车辆
 *
 */
- (void)deleteAllCarsFromPerson:(Person *)person;

@end
