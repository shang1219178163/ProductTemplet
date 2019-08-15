//
//  WaveController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/12.
//  Copyright © 2019 BN. All rights reserved.
//

#import "WaveController.h"
#import "WaterView.h"

@interface WaveController ()

@end

@implementation WaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView * containView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth - 40, 200)];
        view.backgroundColor = UIColor.blueColor;
        
        view;
    });
    [self.view addSubview:containView];
    self.view.backgroundColor = UIColor.lightGrayColor;
    WaterView * v = [[WaterView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth - 40, 100)];
    [containView addSubview:v];
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
