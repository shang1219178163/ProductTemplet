//
//  MoneyDisplayController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/17.
//  Copyright © 2018 BN. All rights reserved.
//

#import "AnimationController16.h"

@interface AnimationController16 ()

@property (nonatomic, strong) UILabel * label;

@end

@implementation AnimationController16

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.tag = kTAG_LABEL + 3;
            label.font = [UIFont systemFontOfSize:17];
            //            label.textColor = UIColor.grayColor;
            label.textAlignment = NSTextAlignmentLeft;

            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
            label;
        });
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label.frame = CGRectMake(20, 20, 100, 25);
    [self.view addSubview:self.label];
    
    NSString *str = @"188969";
    double a = [str doubleValue]/100;
//    NSString * num1 = [NSString stringWithFormat:@"%.2lf",a];
    self.label.number = @(a);
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
