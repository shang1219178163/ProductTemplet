//
//  UINavigationController+Hook.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import "UINavigationController+HookNew.h"
#import <NNCategoryPro/NNCategoryPro.h>


@implementation UINavigationController (HookNew)
 
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hookInstanceMethod(self.class, @selector(pushViewController:animated:), @selector(hook_pushViewController:animated:));
    });
}

- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.viewControllers containsObject:viewController]) return;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIView *customView = [viewController createBackItem:[UIImage imageNamed:@"icon_delete"]];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
    }
    [self hook_pushViewController:viewController animated:animated];
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
//        return  self.navigationController.viewControllers.count > 1;
//    }
//    return YES;
//}

@end
