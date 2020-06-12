//
//  NSObject+Bind.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NSObject+Bind.h"
#import <objc/runtime.h>

@implementation NSObject (Bind)

NSString *const runtimeKey = @"runtimeKey";

- (void)observeTarget:(id)target keyPath:(NSString *)keyPath onChange:(void(^)(NSString *keyPath, NSDictionary *change))handler{
    NSString *key = [NSString stringWithFormat:@"%@,%p,%@", NSStringFromClass(self.class), self, NSStringFromSelector(_cmd)];
    objc_setAssociatedObject(self, CFBridgingRetain(runtimeKey), handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    NSLog(@"%@", key);

//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew;
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;
    [target addObserver:self forKeyPath:keyPath options:options context:nil];
}
    
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSString *key = [NSString stringWithFormat:@"%@,%p,%@", NSStringFromClass(self.class), self, NSStringFromSelector(@selector(observeTarget:keyPath:onChange:))];
    NSLog(@"%@", key);

    void(^handlder)(NSString *keyPath, NSDictionary *change) = objc_getAssociatedObject(self, CFBridgingRetain(runtimeKey));
    if (handlder) handlder(keyPath, change);

//    if (self == object) {
//        if (handlder) handlder(keyPath, change[NSKeyValueChangeNewKey]);
//
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
}

@end
