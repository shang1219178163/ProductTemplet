//
//  NNTabBarController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/8.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNTabBarController.h"

@interface NNTabBarController ()<UITabBarDelegate>

@property (nonatomic, strong) UITabBar *tabBar;
@property (nonatomic, strong) UIView *containView;

@end

@implementation NNTabBarController

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"viewControllers"];
    [self removeObserver:self forKeyPath:@"selectedIndex"];
    [self removeObserver:self forKeyPath:@"selectedViewController"];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    NSArray *list = @[@[@"NNFirstViewController",@"首页",@"Item_first_N",@"Item_first_H",@"0",],
                      @[@"NNSecondViewController",@"圈子",@"Item_second_N",@"Item_second_H",@"11",],
                      @[@"NNCenterViewController",@"总览",@"Item_center_N",@"Item_center_H",@"10",],
                      @[@"NNThirdViewController",@"消息",@"Item_third_N",@"Item_third_H",@"12",],
                      @[@"NNFourthViewController",@"我的",@"Item_fourth_N",@"Item_fourth_H",@"13",],
                      
                      ];
    [self.view addSubview:self.tabBar];
    [self.view addSubview:self.containView];

    
    [self addObserver:self forKeyPath:@"viewControllers" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"selectedViewController" options:NSKeyValueObservingOptionNew context:nil];

//    self.viewControllers = UICtlrListFromList(list, false);
    
    self.selectedIndex = [self.viewControllers containsObject:self.selectedViewController] ? [self.viewControllers indexOfObject:self.selectedViewController] : 0;
    
    [self.view getViewLayer];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.tabBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tabBar.superview);
        make.height.equalTo(@(kTabBarHeight+30));
        make.bottom.equalTo(self.tabBar.superview).offset(0);
    }];
    
    [self.containView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containView.superview);
        make.left.right.equalTo(self.containView.superview);
        make.bottom.equalTo(self.tabBar.top);
    }];
    
    [self.containView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(obj.superview);
        }];
    }];
    
}


#pragma mark -Observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    id newValue = change[NSKeyValueChangeNewKey];
    if ([keyPath isEqualToString:@"viewControllers"]) {
        NSArray * viewControllers = (NSArray *)newValue;
        __block NSMutableArray * marr = [NSMutableArray array];
        [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIViewController * controller = obj;
            controller.view.backgroundColor = UIColor.whiteColor;
            [self addChildViewController:controller];
            [controller didMoveToParentViewController:self];
//            [controller createBackItem:[UIImage imageNamed:@"icon_arowLeft_black"]];

            [self.containView addSubview:controller.view];
            
            [marr addObject:controller.tabBarItem];

        }];
        self.tabBar.items = marr.copy;
    }
    else if ([keyPath isEqualToString:@"selectedIndex"]) {
        NSInteger selectedIndex = [(NSNumber *)newValue integerValue];

        if (selectedIndex >= self.viewControllers.count) {
            return;
        }
        
        self.tabBar.selectedItem = self.tabBar.items[selectedIndex];
        self.selectedViewController = self.viewControllers[selectedIndex];
        
        [self changeIndex:selectedIndex];
    }
    else if ([keyPath isEqualToString:@"selectedViewController"]) {
        UIViewController * selectedViewController = (UIViewController *)newValue;
        self.title = selectedViewController.title;
        self.navigationItem.leftBarButtonItem = selectedViewController.navigationItem.leftBarButtonItem;
        self.navigationItem.rightBarButtonItem = selectedViewController.navigationItem.rightBarButtonItem;
        
    }
}


#pragma mark -UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger idx = [tabBar.items indexOfObject:item];
    DDLog(@"%@",@(idx));
    self.selectedIndex = idx;

//    if (idx == 2) {
//        item.title = nil;
//    }
    if (item.title == nil || [item.title isEqualToString:@""]) {
        item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
}

#pragma mark - funtions

- (void)changeIndex:(NSInteger)idx{
    UIViewController * obj = self.selectedViewController;
    [UIView animateWithDuration:0 animations:^{
        [self.containView bringSubviewToFront:obj.view];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark -lazy

-(UITabBar *)tabBar{
    if (!_tabBar) {
        _tabBar = ({
            UITabBar * view = [[UITabBar alloc]initWithFrame:CGRectZero];            
//            view.items = @[@"one", @"two", @"three", @"four"];
            view.tintColor = UITabBar.appearance.tintColor ?  : UIColor.themeColor;
            view.barTintColor = UITabBar.appearance.barTintColor? : UIColor.whiteColor;
            view.translucent = false;
            
            view.delegate = self;
            view;
        });
    }
    return _tabBar;
}

-(UIView *)containView{
    if (!_containView) {
        _containView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containView;
}

@end
