//
//  WHKGroupViewViewController.m
//  
//
//  Created by BIN on 2018/4/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "WHKGroupViewViewController.h"
#import <NNGloble/NNGloble.h>

@interface WHKGroupViewViewController ()

@property (nonatomic ,strong) NSMutableArray * elementList;

@end

@implementation WHKGroupViewViewController

-(NSMutableArray *)elementList{
    if (!_elementList) {
        _elementList = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i< 15; i++) {
            NSString * title = [NSString stringWithFormat:@"点我%@",@(i)];
            [_elementList addObject:title];
            
        }
    }
    return _elementList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //
    CGRect rect = CGRectMake(20, 20, kScreenWidth - 20*2, 0);
    UIView * containView = [self createViewRect:rect elements:self.elementList numberOfRow:4 viewHeight:30 padding:15];
    containView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:containView];
    
    [self.view getViewLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createViewRect:(CGRect)rect elements:(NSArray *)elements numberOfRow:(NSInteger)numberOfRow viewHeight:(CGFloat)viewHeight padding:(CGFloat)padding{
    
    //    CGFloat padding = 15;
    //    CGFloat viewHeight = 30;
    //    NSInteger numberOfRow = 4;
    NSInteger rowCount = elements.count % numberOfRow == 0 ? elements.count/numberOfRow : elements.count/numberOfRow + 1;
    //
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * viewHeight + (rowCount - 1) * padding)];
    backgroudView.backgroundColor = UIColor.greenColor;
    
    CGSize viewSize = CGSizeMake((CGRectGetWidth(backgroudView.frame) - (numberOfRow-1)*padding)/numberOfRow, viewHeight);
    for (NSInteger i = 0; i< elements.count; i++) {
        
        CGFloat w = viewSize.width;
        CGFloat h = viewSize.height;
        CGFloat x = (w + padding) * (i % numberOfRow);
        CGFloat y = (h + padding) * (i / numberOfRow);
        
        NSString *title = elements[i];
        CGRect btnRect = CGRectMake(x, y, w, h);
//        UIButton *btn = [UIButton createRect:btnRect title:title image:nil+i type:@0];
//
        NNButton *view = [[NNButton alloc]initWithFrame:CGRectZero];
        [view setTitle:title forState:UIControlStateNormal];
        view.titleLabel.adjustsFontSizeToFitWidth = YES;
        view.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view setImage:[UIImage imageNamed:@"icon_selected_no_default"] forState:UIControlStateNormal];
        [view setImage:[UIImage imageNamed:@"icon_selected_yes_green"] forState:UIControlStateSelected];
        
        view.frame = btnRect;
        view.selected = true;
        view.tag = kTAG_VIEW + i;
        [view addActionHandler:^(UIButton * _Nonnull sender) {
            sender.selected = !sender.isSelected;

        } forControlEvents:UIControlEventTouchUpInside];
        
        [backgroudView addSubview:view];
    }
    return backgroudView;
}

@end
