//
//  KVOViewController.m
//  Xcode11Project
//
//  Created by Bin Shang on 2020/6/11.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "KVOViewController.h"
#import "NSObject+KVO.h"
#import "NSObject+Bind.h"

#import "Person.h"

#import <NNCategoryPro.h>

@interface KVOViewController ()

@property(nonatomic, strong) Person *person;

@property(nonatomic, strong) NSString *string;

@end


@implementation KVOViewController

- (void)dealloc{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [[Person alloc] init];
    self.person.name = @"zhangsan";

//    [self.person addKVOObserver:self keyPath:@"name" block:^(NSString * _Nonnull keyPath, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
//        DDLog(@"%@_%@", keyPath, change);
//    }];
//
//
//    [self addKVOObserver:self keyPath:@"string" block:^(NSString * _Nonnull keyPath, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
//        DDLog(@"%@_%@", keyPath, change);
//    }];
//
//    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self forKeyPath:@"string" options:NSKeyValueObservingOptionNew context:nil];
    [self.person observeTarget:self keyPath:@"name" onChange:^(NSString * _Nonnull keyPath, NSDictionary * _Nonnull change) {
        DDLog(@"%@_%@", keyPath, change);
    }];
    
//    [self observeTarget:self keyPath:@"string" onChange:^(NSString * _Nonnull keyPath, NSDictionary * _Nonnull change) {
//        DDLog(@"%@_%@", keyPath, change);
//    }];
    [self addObserver:self.person forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

    self.person.name = @"lisi";
    self.string = @"788";

}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    DDLog(@"%@_%@", keyPath, change[NSKeyValueChangeNewKey]);
}

@end
