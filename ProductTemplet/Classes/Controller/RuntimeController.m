//
//  RuntimeController.m
//  AddMethodDemo
//
//  Created by 孙云 on 16/4/21.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "RuntimeController.h"
#import <objc/runtime.h>

#import "Person.h"
@interface RuntimeController ()

@end

@implementation RuntimeController

bool NNClassAddMethod(NSString *_Nullable cls, NSString *_Nullable name, NSString *_Nullable impCls, NSString *_Nullable impName, const char *_Nullable types){
    return class_addMethod(NSClassFromString(cls),  NSSelectorFromString(name), class_getMethodImplementation(NSClassFromString(impCls), NSSelectorFromString(impName)), types);
}

#pragma mark -lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
//添加方法
    Person *p = [[Person alloc]init];
//    class_addMethod(NSClassFromString(@"Person"), NSSelectorFromString(@"findInSelf:"), class_getMethodImplementation(NSClassFromString(@"ViewController"), NSSelectorFromString(@"addFind:")), "v@:");
    
    NNClassAddMethod(@"Person", @"findInSelf:", @"RuntimeController", @"addFind:", "v@:");
    [p performSelector:NSSelectorFromString(@"findInSelf:") withObject:@"1234"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    NSLog(@"viewWillAppear");
}

- (void)addFind:(NSString *)txt{

    NSLog(@"Wow,find sun yun fei");
}


@end
