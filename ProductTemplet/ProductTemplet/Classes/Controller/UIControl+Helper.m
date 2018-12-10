//
//  UIControl+Helper.m
//  ProductTemplet
//
//  Created by dev on 2018/12/10.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UIControl+Helper.h"
#import <objc/runtime.h>

@implementation UIControl (Helper)

- (void)addActionHandler:(void(^)(UIControl *obj))handler forControlEvents:(UIControlEvents)controlEvents{
    [self addTarget:self action:@selector(handleActionBtn:) forControlEvents:controlEvents];
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)handleActionBtn:(id)sender{
    void(^block)(UIControl *obj) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
    if (block) block(sender);

}


@end
