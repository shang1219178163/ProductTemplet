

//
//  BNShareView.m
//  BN_CollectionView
//
//  Created by hsf on 2018/5/18.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNShareViewController.h"

#import "BNShareView.h"

@interface BNShareViewController ()

@property (nonatomic, strong) BNShareView * shareView;

@end

@implementation BNShareViewController

-(BNShareView *)shareView{
    if (!_shareView) {
        _shareView = [[BNShareView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 400)];
        
    }
    return _shareView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBtn:)];

    
//    [self.view addSubview:self.shareView];
    [self.view getViewLayer];
    
}

- (void)handleActionBtn:(UIBarButtonItem *)sender{
    [self.shareView show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
