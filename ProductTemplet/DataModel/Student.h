//
//  Student.h
//  ProductTemplet
//
//  Created by BIN on 2018/6/1.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Lesson.h"

@interface Student : NSObject

@property(nonatomic, copy) NSString *FLDBID;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) NSInteger studentID;
@property(nonatomic, strong) NSArray <Lesson *>*lessonList;

@end
