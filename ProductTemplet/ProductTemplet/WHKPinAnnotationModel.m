
//
//  WHKPinAnnotationModel.m
//  HuiZhuBang
//
//  Created by 晁进 on 2017/8/4.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKPinAnnotationModel.h"

@implementation WHKPinAnnotationModel


- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if(self) {
        
        self.type = dict[@"type"];
        
        self.title = dict[@"name"];
        self.titleSub = dict[@"detail"];
        
        
        self.coordinate = CLLocationCoordinate2DMake([dict[@"coordinate"][@"latitute"] doubleValue], [dict[@"coordinate"][@"longitude"] doubleValue]);
        
    }
    return self;
}

@end
