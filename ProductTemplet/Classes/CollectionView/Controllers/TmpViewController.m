//
//  TmpViewController.m
//  BINAlertView
//
//  Created by hsf on 2018/5/19.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "TmpViewController.h"

#import "BNExtendView.h"

@interface TmpViewController ()

@property (nonatomic, assign) BOOL isOpen;//open
@property (nonatomic, strong) UIButton * btnFront;
@property (nonatomic, strong) UIButton * btnBack;

@property (nonatomic, strong) UIView * containView;
@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) BNExtendView * extendView;

@end

@implementation TmpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendView.items = nil;
    self.extendView.isLock = NO;
    
    self.extendView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.extendView];
    self.extendView.block = ^(BNExtendView *view, id obj, UIButton *sender) {
        DDLog(@"__%@_%@",obj,@(sender.tag));
        
    };
    
    [self.view getViewLayer];
    
    [self.view addActionHandler:^(id obj, id item, NSInteger idx) {
        DDLog(@"addActionHandler");
        
    }];
        
    [self.view getViewLayer];

}

- (void)createControls{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
    
    [self.view addSubview:containerView];
    
    UIView *fromView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    fromView.backgroundColor = [UIColor blueColor];
    UIView *toView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    toView.backgroundColor = [UIColor purpleColor];
    [containerView addSubview:fromView];
    
    [self.view addSubview:fromView];
    
    [CATransaction flush];
    [fromView addActionHandler:^(id obj, id item, NSInteger idx) {
        [UIView transitionFromView:fromView toView:toView duration:0.4f options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
        
//        [self updateBtnFrameIsOpen:YES];
        
    }];
    
    [toView addActionHandler:^(id obj, id item, NSInteger idx) {
        [UIView transitionFromView:toView toView:fromView duration:0.4f options:UIViewAnimationOptionTransitionFlipFromRight completion:NULL];
//        [self updateBtnFrameIsOpen:NO];

    }];
    
    
}

- (void)updateBtnFrameIsOpen:(BOOL)isOPen{
    
    for (NSDictionary * dict in self.items) {
        UIButton * btn = dict[@"btn"];
        [UIView animateWithDuration:0.15 animations:^{
            btn.frame = isOPen == YES ? [dict[@"rect"] CGRectValue] : [dict[@"rectOrigin"] CGRectValue];

        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -lazy

-(BNExtendView *)extendView{
    if (!_extendView) {
        _extendView = [[BNExtendView alloc]initWithFrame:CGRectMake(kScreenWidth/2.0 - 20,kScreenHeight/2.0 - 20, 40, 40)];
        _extendView.direction = @0;
        NSArray * array = @[
                            @{
                                kExtendItem_img:   @"Googleplus_round",
                                kExtendItem_VC:   @"WHKMsgCommentController",
                                },
                            @{
                                kExtendItem_img:   @"Facebook_round",
                                kExtendItem_VC:   @"WHKMsgCommentController",
                                },
                            @{
                                kExtendItem_img:   @"Pinterest_round",
                                kExtendItem_VC:   @"WHKMsgCommentController",
                                },
                            ];
        _extendView.itemDictList = array;
    }
    return _extendView;
}


@end
