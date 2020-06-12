//
//  NSObject+KVO.m
//  Xcode11Project
//
//  Created by Bin Shang on 2020/6/11.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>

@interface KVOTarget : NSObject

@property(nonatomic, strong) NSObject *observer;
@property(nonatomic, strong) NSMutableArray <KVODeallocBlock>*blockArr;

@end


@implementation KVOTarget

- (void)dealloc {
    NSLog(@"kvoController dealloc");
    [_blockArr enumerateObjectsUsingBlock:^(KVODeallocBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
        block();
    }];
}
#pragma mark - getter/setter

-(NSMutableArray<KVODeallocBlock> *)blockArr {
    if (!_blockArr) {
        _blockArr = [NSMutableArray array];
    }
    return _blockArr;
}

@end


@interface NSObject ()

@property(nonatomic, strong) NSMutableDictionary <NSString *, KVOBlock>*dict;
@property(nonatomic, strong) KVOTarget *target;

@end


@implementation NSObject (KVO)

- (void)addKVOObserver:(NSObject *)observer keyPath:(NSString *)keyPath block:(KVOBlock)block {
    self.dict[keyPath] = block;

    ///self持有
    self.target.observer = observer;

    __unsafe_unretained typeof(self)weakSelf = self;
    [self.target.blockArr addObject:^{
        [weakSelf removeObserver:weakSelf forKeyPath:keyPath];
    }];

    //监听
    [observer addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    NSLog(@"%@_%@_%@", NSStringFromClass(self.class), self.dict, self.target.blockArr);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@_%@_%@", NSStringFromClass(self.class), self.dict, self.target.blockArr);
    KVOBlock block = self.dict[keyPath];
    if (block) {
        block(keyPath, change);
    }
}

#pragma mark - getter/setter
- (NSMutableDictionary<NSString *, KVOBlock> *)dict {
    NSMutableDictionary *tmpDict = objc_getAssociatedObject(self, @selector(dict));
    if (!tmpDict) {
        tmpDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(dict), tmpDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpDict;
}

- (KVOTarget *)target {
    KVOTarget *controller = objc_getAssociatedObject(self, @selector(target));
    if (!controller) {
        controller = [[KVOTarget alloc] init];
        objc_setAssociatedObject(self, @selector(target), controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return controller;
}

@end

