//
//  KVC_Controller.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/14.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "KVC_Controller.h"

@interface KVC_Controller ()

@end

@implementation KVC_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    数组合并(去重合并:distinctUnionOfArrays.self、直接合并:unionOfArrays.self)
    NSArray *temp1 = @[@3, @2, @2, @1];
    NSArray *temp2 = @[@3, @4, @5];
//    输出两个数组:( 5, 1, 2, 3, 4 ), ( 3, 2, 2, 1, 3, 4, 5 )。
    NSArray * list_unionDist = [@[temp1, temp2] valueForKeyPath:kArrs_unionDist_list];
    NSArray * list_union = [[@[temp1, temp2] valueForKeyPath:kArrs_union_list] copy];
    NSLog(@"/n%@",list_unionDist);
    NSLog(@"/n%@",list_union);
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
