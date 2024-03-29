//
//  FacadeViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FacadeViewController.h"
#import "LH4SWaiter.h"

#import "UIView+Helper.h"

@interface FacadeViewController ()

@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) LH4SWaiter *waiter;

@end

@implementation FacadeViewController

-(LH4SWaiter *)waiter{
    if (!_waiter) {
        _waiter = [[LH4SWaiter alloc]init];
    }
    return _waiter;
    
}

-(NSArray *)itemList{
    if (!_itemList) {
        _itemList = @[@"payCash",@"payLoad",];
    }
    return _itemList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    CGRect rect = CGRectMake(20, 20, kScreenWidth - 20*2, 0);
    UIView * containView = [UIView createViewRect:rect items:self.itemList numberOfRow:4 itemHeight:30 padding:10 handler:^(UIButton *sender) {
        [self handleActionBtn:sender];
        
    }];
    containView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:containView];

    
    [self.view getViewLayer];
    
    DDLog(@"%@",containView.subviews);
    
}

- (void)handleActionBtn:(UIButton *)sender{
    DDLog(@"__%@",@(sender.tag));
    switch (sender.tag) {
        case 0:
        {
            [self.waiter buyCarWithCash];
            
        }
            break;
        case 1:
        {
            [self.waiter buyCarWithLoad];
            
        }
            break;
        default:
            break;
    }
    
}

@end
