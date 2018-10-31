//
//  BN_FourthViewController.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_FourthViewController.h"

#import <FLAnimatedImage/FLAnimatedImage.h>

@interface BN_FourthViewController ()

@end

@implementation BN_FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//    [self BN_AddChildControllerView:@"FontListController"];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString  *filePath = [[NSBundle bundleWithPath:[NSBundle.mainBundle bundlePath]]pathForResource:@"loading" ofType:@"gif"];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:filePath]];
    FLAnimatedImageView *imgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    imgView.animatedImage = image;
    
//    imgView.animationDuration = 0.8;
//    imgView.animationRepeatCount = 0;
//    [imgView startAnimating];
    
    imgView.backgroundColor = UIColor.redColor;
    
//    [self.view addSubview:imgView];
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
