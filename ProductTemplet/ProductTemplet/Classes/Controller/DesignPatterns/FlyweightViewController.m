//
//  FlyweightViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FlyweightViewController.h"

#import "BNGloble.h"

#import "FlowerView.h"
#import "FlowerFactory.h"
#import "ExtrinsicFlowerStateModel.h"
#import "FlyweightView.h"


@interface FlyweightViewController ()
{
    ExtrinsicFlowerStateModel *_extrinsicFlowerState;
}

@end

@implementation FlyweightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createFlowers];
}

#pragma mark - 创建花圃
-(void)createFlowers{

    //构造花朵列表
    FlowerFactory *factory = [[FlowerFactory alloc] init];
    NSMutableArray *flowerList = [[NSMutableArray alloc] initWithCapacity:500];
    ;
    
    for (int i = 0; i<5000; i++) {
        //使用随机花朵类型
        //从花朵工厂取得一个共享的花朵享元对象实例
        FlowerType flowerType = arc4random()%kTotalNumberOfFlowerTypes;
        UIView *flowerView = [factory flowerViewWithType:flowerType];
        
        /*
         * 由于ARC中结构体当中无法添加对象类型（可以查阅原书中的实现），
         * 考虑到本例是用来减少内存消耗的，
         * 所以将计算的本添加到了绘制图形的方法当中
         */
        
        /*
         
         //设置花朵的显示位置和大小
         CGFloat x = (arc4random()%(NSInteger)kDeviceWidth);
         CGFloat y = (arc4random()%(NSInteger)kDeviceHeight);
         NSInteger minSize = 10;
         NSInteger maxSize = 50;
         CGFloat size = (arc4random() % (maxSize - minSize + 1)) + minSize;
         
         //拔花朵的属性赋值给一个外在状态对象
         _extrinsicFlowerState = [[ExtrinsicFlowerStateModel alloc] init];
         _extrinsicFlowerState.flowerView = flowerView;
         _extrinsicFlowerState.area = CGRectMake(x, y, size, size);
         //把外在花朵状态添加到花朵列表
         [flowerList addObject:_extrinsicFlowerState];
         
         */
        
        //把内在花朵状态添加到花朵列表
        [flowerList addObject:flowerView];
    }
    FlyweightView *view = [[FlyweightView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.backgroundColor = [UIColor colorWithRed:10/255.0 green:80/255.0 blue:10/255.0 alpha:1.0];
    [view setFlowerList:flowerList];
    [self.view addSubview:view];

}

- (void)handleView:(UIView *)view{
    [self.view addSubview:view];

    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createFlowers];

        
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
