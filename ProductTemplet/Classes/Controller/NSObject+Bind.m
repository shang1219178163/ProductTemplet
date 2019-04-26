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

- (void)observeTarget:(id)target keyPath:(NSString *)keyPath onChange:(void(^)(NSString *keyPath, id obj))handler{
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew;
    [target addObserver:self forKeyPath:keyPath options:options context:nil];
    
}
    
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    void(^handlder)(NSString *keyPath, id obj) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
    if (handlder) handlder(keyPath, change[NSKeyValueChangeNewKey]);

//    if (self == object) {
//        if (handlder) handlder(keyPath, change[NSKeyValueChangeNewKey]);
//
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
}

@end
