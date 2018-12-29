//
//  Teacher.h
//  ProductTemplet
//
//  Created by BIN on 2018/6/1.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

@interface Teacher : NSObject

@property (nonatomic,copy)NSString *FLDBID;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) NSInteger age;

@property(nonatomic,assign) NSInteger teacherID;

@property(nonatomic,strong) Student *student;

@end
