//
//  UIBarButtonItem+Block.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/18.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIBarButtonItem+Block.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (Block)

- (void (^)(void))actionBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)addActionBlock:(void(^)(UIBarButtonItem *reco))actionBlock {
    if (actionBlock) {
        [self willChangeValueForKey:@"actionBlock"];
        
        objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        // Sets up the action.
        self.target = self;
        self.action = @selector(invoke:);
        [self didChangeValueForKey:@"actionBlock"];
    }
}

- (void)invoke:(id)sender {
    void(^block)(UIBarButtonItem *reco) = objc_getAssociatedObject(self, @selector(actionBlock));
    if (block) {
        block(sender);
    }
}

- (void)setHidden:(BOOL)hidden{
    self.enabled = !hidden;
    self.tintColor = !hidden ? UIColor.themeColor : UIColor.clearColor;
}



@end

