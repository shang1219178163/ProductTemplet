//
//  AbstractFactoryController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "AbstractFactoryController.h"

#import "EOCEmployee.h"
#import "NSObject+Helper.h"

@interface AbstractFactoryController ()

@end

@implementation AbstractFactoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSInteger randomIdx = RandomInteger(0, 2);
    EOCEmployee * employee = [EOCEmployee employeeWithType:(EOCEmployeeType)randomIdx];
    [employee doADaysWork];
    
    
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
