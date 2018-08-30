//
//  DBEntity.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "DBEntity.h"
#import <objc/runtime.h>

@implementation DBEntity

#pragma mark - Custom Method

+ (void)dictionaryToEntity:(NSDictionary *)dict entity:(NSObject *)entity{
    if (dict && entity) {
        for (NSString *key in [dict allKeys]) {
            [entity setValue:dict[key] forKey:key];
            
        }
    }
}

+ (NSDictionary *)entityToDictionary:(id)entity{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger i = 0; i < count; i++){
        objc_property_t prop = properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        //        const char* attributeName = property_getAttributes(prop);
        //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //        NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
        //        NSLog(@"%@",value);
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    NSLog(@"%@", returnDic);
    
    return returnDic;
}

//+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity{
//    if (dict && entity) {
//
//        for (NSString *keyName in [dict allKeys]) {
//            //构建出属性的set方法
//            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[keyName capitalizedString]]; //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
//            SEL destMethodSelector = NSSelectorFromString(destMethodName);
//
//            if ([entity respondsToSelector:destMethodSelector]) {
//                [entity performSelector:destMethodSelector withObject:[dict objectForKey:keyName]];
//            }
//
//        }//end for
//
//    }//end if
//}
//
//+ (NSDictionary *) entityToDictionary:(id)entity{
//
//    Class clazz = [entity class];
//    u_int count;
//
//    objc_property_t* properties = class_copyPropertyList(clazz, &count);
//    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
//    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
//
//    for (NSInteger i = 0; i < count ; i++){
//        objc_property_t prop=properties[i];
//        const char* propertyName = property_getName(prop);
//
//        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
//
//        //        const char* attributeName = property_getAttributes(prop);
//        //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
//        //        NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
//        
//        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
//        if(value ==nil)
//            [valueArray addObject:[NSNull null]];
//        else {
//            [valueArray addObject:value];
//        }
//        //        NSLog(@"%@",value);
//    }
//
//    free(properties);
//
//    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
//    NSLog(@"%@", returnDic);
//
//    return returnDic;
//}


+ (NSDictionary *)getObjectData:(id)obj{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
    for(NSInteger i = 0;i < propsCount; i++){
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        
        id value = [obj valueForKey:propName];//kvc读值
        if(value == nil){
            value = [NSNull null];
            
        }
        else{
            value = [self getObjectInternal:value];//自定义处理数组，字典，其他类
            
        }
        [dic setObject:value forKey:propName];
        
    }
    return dic;
}

+ (id)getObjectInternal:(id)obj{
    
    //类型
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]){
        return obj;
        
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(NSInteger i = 0;i < objarr.count; i++){
//            [arr setObject:[self getObjectInternal:objarr[i]] atIndexedSubscript:i];
            [arr addObject:[self getObjectInternal:objarr[i]]];
        }
        return arr;
        
    }
 
    if([obj isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys){
            [dic setObject:[self getObjectInternal:objdic[key]] forKey:key];
            
        }
        return dic;
        
    }
    return [self getObjectData:obj];
}

@end

