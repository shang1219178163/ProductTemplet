//
//  KVOViewController.m
//  Xcode11Project
//
//  Created by Bin Shang on 2020/6/11.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "KVOViewController.h"
#import "Person.h"

#import <NNCategoryPro.h>
#import <YYCategories.h>

@interface KVOViewController ()

@property(nonatomic, strong) Person *person;

@property(nonatomic, strong) NSString *string;

@end


@implementation KVOViewController

- (void)dealloc{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [_person removeObserverBlocks];
    [self removeObserverBlocks];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    self.person = [[Person alloc] init];
    self.person.name = @"zhangsan";

    [self.person addObserverBlockForKeyPath:@"name" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        DDLog(@"%@_%@_%@", obj, oldVal, newVal);
    }];
    [self addObserverBlockForKeyPath:@"string" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        DDLog(@"%@_%@_%@", obj, oldVal, newVal);
    }];
    
    self.person.name = @"lisi";
    self.string = @"788";

}

@end
