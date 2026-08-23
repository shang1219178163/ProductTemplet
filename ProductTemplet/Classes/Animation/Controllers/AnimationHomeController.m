//
//  AnimationHomeController.m
//  ProductTemplet
//
//  Created by BIN on 2026/8/23.
//  Copyright © 2026 BN. All rights reserved.
//

#import "AnimationHomeController.h"

@interface AnimationHomeController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) NSArray<NSString *> *vcNames;
@property (nonatomic, strong) NSArray<UIViewController *> *ctlrs;

@end

@implementation AnimationHomeController

- (instancetype)init{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                  options:nil];
    if (self) {
        self.vcNames = @[
            @"AnimationController1", @"AnimationController2", @"AnimationController3",
            @"AnimationController4", @"AnimationController5", @"AnimationController6",
            @"AnimationController7", @"AnimationController8", @"AnimationController9",
            @"AnimationController10", @"AnimationController11", @"AnimationController12",
            @"AnimationController13", @"AnimationController14", @"AnimationController15",
            @"AnimationController16", @"AnimationController17", @"AnimationController18",
        ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.dataSource = self;
    self.delegate = self;

    NSMutableArray *list = [NSMutableArray arrayWithCapacity:self.vcNames.count];
    for (NSString *name in self.vcNames) {
        Class cls = NSClassFromString(name);
        if (!cls) continue;
        UIViewController *vc = [[cls alloc] init];
        vc.title = [NSString stringWithFormat:@"%ld/%ld", (long)(list.count + 1), (long)self.vcNames.count];
        [list addObject:vc];
    }
    self.ctlrs = list.copy;

    [self setViewControllers:@[self.ctlrs.firstObject]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateTitleForViewController:self.ctlrs.firstObject];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger idx = [self.ctlrs indexOfObject:viewController];
    if (idx == NSNotFound || idx == 0) return nil;
    return self.ctlrs[idx - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger idx = [self.ctlrs indexOfObject:viewController];
    if (idx == NSNotFound || idx == self.ctlrs.count - 1) return nil;
    return self.ctlrs[idx + 1];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (completed && pageViewController.viewControllers.firstObject) {
        [self updateTitleForViewController:pageViewController.viewControllers.firstObject];
    }
}

#pragma mark - funtions

/// 导航栏标题显示「当前索引/总数 + 子控制器标题」
- (void)updateTitleForViewController:(UIViewController *)vc{
    NSInteger idx = [self.ctlrs indexOfObject:vc];
    if (idx == NSNotFound) return;
    NSString *vcTitle = vc.navigationItem.title ?: vc.title ?: NSStringFromClass(vc.class);
    self.title = [NSString stringWithFormat:@"%ld/%ld %@", (long)(idx + 1), (long)self.ctlrs.count, vcTitle];
}

@end
