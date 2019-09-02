//
//  DBManager.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "DBManager.h"

#import <FMDB/FMDB.h>

#import "Person.h"
#import "Car.h"
#import "NNGloble.h"

@interface DBManager()

@property (nonatomic, strong) FMDatabaseQueue *queue;


@end

@implementation DBManager

+(instancetype)shared{
    static DBManager *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance initDB];
    });
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static DBManager *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return [DBManager shared];
}

-(FMDatabaseQueue *)queue{
    if (!_queue) {
        _queue = [FMDatabaseQueue databaseQueueWithPath:[self dbPath]];

    }
    return _queue;
}

- (NSString *)dbPath{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"FMDB.sqlite"];
    DDLog(@"docPath__%@",docPath);
    return filePath;
}

#pragma mark -- funtions

// 表本身(创建,修改,删除)
- (void)operationTableWithSQL:(NSString *)sql type:(DBOperationType)type{
    
    NSDictionary * dic = @{
                            @(DBOperationTypeTableCreate):   @"创建",
                            @(DBOperationTypeTableDrop):   @"删除",
                            @(DBOperationTypeTableAlter):   @"修改",
                            @(DBOperationTypeTableSelect):   @"查询",

                            };
    
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL res = [db executeUpdate:sql];
        if (res) {
            NSLog(@"%@表格成功",dic[@(type)]);
        } else {
            NSLog(@"%@表格失败!!!!\n%@",dic[@(type)],sql);
        }
    }];
    
}

// 查询所有数据
- (void)queryAll {
    NSString *sql = @"select * from T_human";

    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        
        while (resultSet.next) {
            NSString *name = [resultSet stringForColumn:@"name"];
            NSInteger age = [resultSet intForColumn:@"age"];
            double height = [resultSet doubleForColumn:@"height"];
            
            NSLog(@"%@, %li, %lf", name, (long)age, height);
        }
    }];
}

// 执行多条语句
- (void)excuteStaments {
    
//    NSString *sql = @"insert into T_human(name, age, height) values('wangwu', 15, 170);insert into T_human(name, age, height) values('zhaoliu', 13, 160);";
    NSString *sql = @"insert into T_human(name, age, height) values('wangwu', 15, 170),('zhaoliu', 13, 160);";

    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeStatements:sql];
        if (result) {
            NSLog(@"执行多条语句成功");
        } else {
            NSLog(@"执行多条语句失败!!!!\n%@",sql);
        }
    }];
    [self.queue close];
}

// 开启事务执行语句
- (void)transaction {
    
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"insert into T_human(name, age, height) values('wangwu', 15, 170);insert into T_human(name, age, height) values('zhaoliu', 13, 160);";
        NSString *sql2 = @"insert into T_human(name, age, height) values('zhaoliu', 13, 160);insert into T_human(name, age, height) values('wangwu', 15, 170);";
        
        BOOL result1 = [db executeUpdate:sql];
        BOOL result2 = [db executeUpdate:sql2];
        
        if (result1 && result2) {
            NSLog(@"执行成功");
        } else {
            [db rollback];
        }
    }];
}

#pragma mark - - 数据库初始化
- (void)initDB{
    // 初始化数据表
    NSString *personSql = @"CREATE TABLE 'person' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'person_id' VARCHAR(255),'person_name' VARCHAR(255),'person_age' VARCHAR(255),'person_number' VARCHAR(255)) ";
    NSString *carSql = @"CREATE TABLE 'car' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'own_id' VARCHAR(255),'car_id' VARCHAR(255),'car_brand' VARCHAR(255),'car_price'VARCHAR(255)) ";
    
    [self operationTableWithSQL:personSql type:DBOperationTypeTableCreate];
    [self operationTableWithSQL:carSql type:DBOperationTypeTableCreate];
    
}

#pragma mark - -SQL语句

#pragma mark - - SQLArguments
- (NSString *)getSQLArgumentsWithKeys:(NSArray *)keys dic:(NSDictionary *)dic middle:(NSString *)middle{
    
    NSString *sql = @"";
    sql = [sql stringByAppendingFormat:@"("];
    
    for (NSString * key in keys) {
        if ([key isEqualToString:[keys lastObject]]) {
            sql = [sql stringByAppendingFormat:@"%@ %@ %@",key,middle,dic[key]];
            
        } else {
            sql = [sql stringByAppendingFormat:@"%@ %@ %@,",key,middle,dic[key]];
            
        }
    }
    
    sql = [sql stringByAppendingFormat:@");"];
    return sql;
}


- (NSString *)SQLcreateTable:(NSString *)tableName params:(NSArray *)params{
    NSParameterAssert(tableName != nil);

    NSArray *keys = [params firstObject];
    NSDictionary * dic = [params lastObject];
    
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement",tableName];
    for(NSInteger i = 0; i < keys.count; i++){
        NSString * key = keys[i];
        sql = [sql stringByAppendingFormat:@",%@ %@",key,dic[key]];
        
    }
    sql = [sql stringByAppendingString:@");"];
    NSLog(@"\n(%@)",sql);
    return sql;
}

- (NSString *)SQLdropTable:(NSString *)tableName{
    NSParameterAssert(tableName != nil);
    
    NSString *sql = [NSString stringWithFormat:@"drop table %@;",tableName];
    NSLog(@"\n(%@)",sql);
    return sql;
}

- (NSString *)SQLalterTable:(NSString *)tableName params:(NSArray *)params type:(NSNumber *)type{
    NSParameterAssert(tableName != nil);
    NSArray *keys = [params firstObject];
    NSDictionary * dic = [params lastObject];
    
    NSString *sql = [NSString stringWithFormat:@"alter table %@",tableName];
    switch ([type integerValue]) {
        case 1:
        {
            //alter table test drop (c1,c2);  --正确
            sql = [sql stringByAppendingFormat:@" drop "];
            sql = [sql stringByAppendingFormat:@"("];
            
            for (NSString * key in keys) {
                if ([key isEqualToString:[keys lastObject]]) {
                    sql = [sql stringByAppendingFormat:@"%@",key];

                } else {
                    sql = [sql stringByAppendingFormat:@"%@,",key];

                }
            }
            
            sql = [sql stringByAppendingFormat:@");"];
            
        }
            break;
        case 2:
        {
            //alter table test modify (c1 int, c2 int);   -- 正确
            sql = [sql stringByAppendingFormat:@" modify "];
            sql = [sql stringByAppendingString:[self getSQLArgumentsWithKeys:keys dic:dic middle:@""]];
        }
            break;
        case 3:
        {
            //alter table test rename column c1 to c2;    -- 正确
            sql = [sql stringByAppendingFormat:@" rename "];
            sql = [sql stringByAppendingString:[self getSQLArgumentsWithKeys:keys dic:dic middle:@"to"]];

        }
            break;
        default:
        {
            //alter table test add (c1 int, c2 int);  -- 正确
            sql = [sql stringByAppendingFormat:@" add "];
            sql = [sql stringByAppendingString:[self getSQLArgumentsWithKeys:keys dic:dic middle:@""]];
        }
            break;
    }
    NSLog(@"\n(%@)",sql);
    return sql;
}

- (NSString *)SQLclearTable:(NSString *)tableName{
    NSParameterAssert(tableName != nil);
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@;",tableName];
    NSLog(@"\n(%@)",sql);
    return sql;
}

#pragma mark - -表内层操作
- (NSString *)SQLinsertTable:(NSString *)tableName params:(NSArray *)params{
    NSParameterAssert(tableName != nil);
    NSArray *keys = [params firstObject];
    NSDictionary * dic = [params lastObject];
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@",tableName];
//    NSString *sql = @"insert into T_human(name, age, height) values('wangwu', 15, 170);insert into T_human(name, age, height) values('zhaoliu', 13, 160);";

    
    sql = [sql stringByAppendingFormat:@"("];
    for (NSString * key in keys) {
        sql = [sql stringByAppendingFormat:@" %@,",key];

    }
    sql = [sql substringToIndex:sql.length - 1];
    sql = [sql stringByAppendingFormat:@") values ("];
    
    for (NSString * key in keys) {
        id obj = dic[key];
        
        NSString * strQuotes = [obj isKindOfClass:[NSString class]] ? @"'"  :   @"";
        sql = [sql stringByAppendingFormat:@" %@%@%@,",strQuotes,obj,strQuotes];
        
    }
    sql = [sql substringToIndex:sql.length - 1];
    sql = [sql stringByAppendingString:@");"];
    NSLog(@"\n(%@)",sql);
    return sql;
}

- (NSString *)SQLDeleteTable:(NSString *)tableName wheres:(NSArray *)wheres{
    NSParameterAssert(tableName != nil);
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE ",tableName];
    //    (update student set age='44',sex='女' where age<='18' and age>'99')

    for (NSString * where in wheres) {
        if ([where isEqualToString:[wheres lastObject]]) {
            sql = [sql stringByAppendingFormat:@"%@ ",where];
            
        } else {
            sql = [sql stringByAppendingFormat:@"%@ and ",where];
            
        }
    }
    NSLog(@"\n(%@)",sql);
    return sql;
    
}

- (NSString *)SQLupdateTable:(NSString *)tableName dic:(NSDictionary *)dic wheres:(NSArray *)wheres{
    NSParameterAssert(tableName != nil);
    NSArray *keys = dic.allKeys;
    
    NSString *sql = [NSString stringWithFormat:@"update %@",tableName];
//    (update student set age='44',sex='女' where age<='18' and age>'99')
    
    sql = [sql stringByAppendingFormat:@" set"];
    for (NSString * key in keys) {
        sql = [sql stringByAppendingFormat:@" %@='%@',",key,dic[key]];
        
    }
    sql = [sql substringToIndex:sql.length - 1];
    sql = [sql stringByAppendingFormat:@" where "];
    
    for (NSString * where in wheres) {
        if ([where isEqualToString:[wheres lastObject]]) {
            sql = [sql stringByAppendingFormat:@"%@ ",where];

        } else {
            sql = [sql stringByAppendingFormat:@"%@ and ",where];
            
        }
    }
//    sql = [sql stringByAppendingString:@");"];
    NSLog(@"\n(%@)",sql);
    return sql;
    
}

- (NSString *)SQLselectTable:(NSString *)tableName params:(NSArray *)params wheres:(NSArray *)wheres{
    NSParameterAssert(tableName != nil);
//@"SELECT * FROM tableName WHERE fieldName IN ("%@")"
    NSString *sql = [NSString stringWithFormat:@"select * from %@  where ",tableName];
    for (NSString * where in wheres) {
        if ([where isEqualToString:[wheres lastObject]]) {
            sql = [sql stringByAppendingFormat:@"%@ ",where];
            
        } else {
            sql = [sql stringByAppendingFormat:@"%@ and ",where];
            
        }
    }
    sql = [sql stringByAppendingString:@");"];
    NSLog(@"\n(%@)",sql);
    return sql;
}

- (NSString *)SQLselectAllTable:(NSString *)tableName{
    NSParameterAssert(tableName != nil);
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    return sql;
}

#pragma mark - 接口

- (void)addPerson:(Person *)person{
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSNumber *maxID = @(0);
        
        FMResultSet *res = [db  executeQuery:[self SQLselectAllTable:@"person"]];
        //获取数据库中最大的ID
        while ([res next]) {
            if ([maxID integerValue] < [[res stringForColumn:@"person_id"] integerValue]) {
                maxID = @([[res stringForColumn:@"person_id"] integerValue] ) ;
            }
            
        }
        maxID = @([maxID integerValue] + 1);
        
        NSArray * params = @[
                             @[@"person_id",@"person_name",@"person_age",@"person_number"],
                             @{
                                 @"person_id" :   maxID,
                                 @"person_name":   person.name,
                                 @"person_age":   @(person.age),
                                 @"person_number":  @(person.number),
                                 },
                             ];
        
        NSString * sql = [self SQLinsertTable:@"person" params:params];
        [db executeUpdate:sql];
        
    }];
    
}


- (void)deletePerson:(Person *)person{
    
    NSString * where = [NSString stringWithFormat:@"person_id = '%@'",person.ID];
    NSString * sql = [self SQLDeleteTable:@"person" wheres:@[where]];

    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
//        [db executeUpdate:@"DELETE FROM person WHERE person_id = ?",person.ID];
        [db executeUpdate:sql];

    }];
    
}

- (void)updatePerson:(Person *)person{
    
    NSDictionary * dic = @{
                             @"person_name":   person.name,
                             @"person_age":   @(person.age),
                             @"person_number":  @(person.number + 1),
                             
                             };
    
    NSString * where = [NSString stringWithFormat:@"person_id = '%@'",person.ID];
    NSString * sql = [self SQLupdateTable:@"person" dic:dic wheres:@[where]];
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:sql];
    }];
    
}


- (NSMutableArray *)getAllPerson{
    [Person mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":   @"person_id",
                 @"name":   @"person_name",
                 @"age":   @"person_age",
                 @"number":   @"person_number",
                 
                 };
        
    }];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *res = [db executeQuery:@"SELECT * FROM person"];
        while ([res next]) {
            Person *personNew = [Person mj_objectWithKeyValues:res.resultDictionary];
            [dataArray addObject:personNew];

        }
    }];
    return dataArray;
}

/**
 *  给person添加车辆
 *
 */
- (void)addCar:(Car *)car toPerson:(Person *)person{
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        //根据person是否拥有car来添加car_id
        NSNumber *maxID = @(0);
        FMResultSet *res = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM car where own_id = %@ ",person.ID]];
        
        while ([res next]) {
            if ([maxID integerValue] < [[res stringForColumn:@"car_id"] integerValue]) {
                maxID = @([[res stringForColumn:@"car_id"] integerValue]);
            }
            
        }
        maxID = @([maxID integerValue] + 1);
        
        
        NSArray * params = @[
                             @[@"own_id",@"car_id",@"car_brand",@"car_price"],
                             @{
                                 @"own_id":   person.ID,
                                 @"car_id":   maxID,
                                 @"car_brand":   car.brand,
                                 @"car_price":  @(car.price),
                                 },
                             ];
        
        NSString * sql = [self SQLinsertTable:@"person" params:params];
        [db executeUpdate:sql];
        
    }];
}

/**
 *  给person删除车辆
 *
 */
- (void)deleteCar:(Car *)car fromPerson:(Person *)person{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        [db executeUpdate:@"DELETE FROM car WHERE own_id = ?  and car_id = ? ",person.ID,car.car_id];
        
    }];
  
}
/**
 *  获取person的所有车辆
 *
 */
- (NSMutableArray *)getAllCarsFromPerson:(Person *)person{
    

    NSMutableArray  *carArray = [[NSMutableArray alloc] init];

    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet * res = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM car where own_id = %@",person.ID]];
        while ([res next]) {
            Car *car = [[Car alloc] init];
            car.own_id = person.ID;
            car.car_id = @([[res stringForColumn:@"car_id"] integerValue]);
            car.brand = [res stringForColumn:@"car_brand"];
            car.price = [[res stringForColumn:@"car_price"] integerValue];
            
            [carArray addObject:car];
        }
    }];
    
    return carArray;
    
}
- (void)deleteAllCarsFromPerson:(Person *)person{

    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:@"DELETE FROM car WHERE own_id = ?",person.ID];

    }];

}



@end
