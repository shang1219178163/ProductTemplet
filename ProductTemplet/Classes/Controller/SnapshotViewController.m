//
//  SnapshotViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/16.
//  Copyright © 2019 BN. All rights reserved.
//

#import "SnapshotViewController.h"

@interface SnapshotViewController ()

@end

@implementation SnapshotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Snapshot";
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(userDidTakeScreenshotNotification:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)userDidTakeScreenshotNotification:(NSNotification *)sender {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    UIImage *snapshotImage = [UIImage snapshotImageWithView:window];
    // TODO: 将screenshotImage进行分享，可以调用友盟SDK或自己集成第三方SDK实现，这里就不做演示了
    UIButton *btn = [window showFeedbackView:snapshotImage title:@"求助反馈"];
    [btn addActionHandler:^(UIControl * _Nonnull control) {
        DDLog(@"%@", control);
        
    } forControlEvents:UIControlEventTouchUpInside];
    
}

@end
