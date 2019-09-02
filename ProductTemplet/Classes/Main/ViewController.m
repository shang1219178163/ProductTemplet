//
//  ViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/27.
//  Copyright © 2019 BN. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDataSource>


@property(nonatomic, strong) UICollectionView *collectionView;
// </#some/#>


@end

@implementation ViewController

- (void)loadView{
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"" forState:UIControlStateNormal];
        view.titleLabel.font = [UIFont systemFontOfSize:15];
        [view setBackgroundColor:UIColor.whiteColor];
//        view addTarget:self action:@selector(<#selector#>) forControlEvents:<#(UIControlEvents)#>
        view;
    });

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)viewWillUnload {
    [super viewWillUnload];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];

    
  
}



@end
