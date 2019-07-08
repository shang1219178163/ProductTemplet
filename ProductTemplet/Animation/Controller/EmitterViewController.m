//
//  EmitterViewController.m
//  BN_Animation
//
//  Created by hsf on 2018/10/16.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import "EmitterViewController.h"

#import "CAEmitterLayer+Helper.h"
#import "UIColor+Helper.h"

@interface EmitterViewController ()

@end

@implementation EmitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.cyanColor;
    self.view.backgroundColor = UIColor.blackColor;
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layerRect:self.view.layer.bounds imgList:nil type:@2];
    [self.view.layer addSublayer:emitterLayer];
    
    return;
    
//    CGSize emitterSize = CGSizeMake(self.view.bounds.size.width, 0);//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
//    CGRect bounds = self.view.layer.bounds;
//    CGPoint emitterPosition = CGPointMake(bounds.size.width/2, 0);//发射器
//    NSArray * imgList = @[@"like1",@"like2",@"like3",];
////    imgList = @[@"leaf_0@2x",@"leaf_1@2x",@"leaf_2@2x",@"leaf_3@2x",@"leaf_4@2x",];
//
//    imgList = @[@"snow",];
//    CAEmitterLayer *emitterLayer = [CAEmitterLayer layerWithSize:emitterSize positon:emitterPosition imgList:imgList type:@0];
//    [self.view.layer addSublayer:emitterLayer];
    
//    emitterSize = CGSizeMake(bounds.size.width, 0);
//    emitterPosition = CGPointMake(bounds.size.width/2, bounds.size.height-60);
//    CAEmitterLayer *emitterLayer = [CAEmitterLayer layerWithSize:emitterSize positon:emitterPosition imgList:imgList type:@1];
//    [self.view.layer addSublayer:emitterLayer];
    
}

- (void)animation1{
    if (YES) {
        CAEmitterLayer *leafEmitter = CAEmitterLayer.layer;
        [self.view.layer addSublayer:leafEmitter];
        
        leafEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width/2, 0);//发射器中心点
        leafEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width, 0);//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
        
        leafEmitter.emitterShape = kCAEmitterLayerLine;//发射器形状为线性
        leafEmitter.emitterMode = kCAEmitterLayerOutline;//从发射器边缘发出
        
        NSMutableArray *array = [NSMutableArray array];//CAEmitterCell数组，存放不同的CAEmitterCell，我这里准备了四张不同形态的叶子图片。
        for (NSInteger i = 0; i<4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"like%ld",(long)i];
            
            CAEmitterCell *leafCell = CAEmitterCell.emitterCell;
            leafCell.birthRate = 2;//粒子产生速度
            leafCell.lifetime = 50;//粒子存活时间
            
            leafCell.velocity = 10;//初始速度
            leafCell.velocityRange = 5;//初始速度的差值区间，所以初始速度为5~15，后面属性range算法相同
            
            leafCell.yAcceleration = 2;//y轴方向的加速度，落叶下飘只需要y轴正向加速度。
            
            leafCell.spin = 1.0;//粒子旋转速度
            leafCell.spinRange = 2.0;//粒子旋转速度范围
            
            leafCell.emissionRange = M_PI;//粒子发射角度范围
            
            leafCell.contents = (id)[[UIImage imageNamed:imageName] CGImage];//粒子图片
            leafCell.color   = UIColor.randomColor.CGColor;

            leafCell.scale = 0.3;//缩放比例
            leafCell.scaleRange = 0.2;//缩放比例
            
            [array addObject:leafCell];
        }
        leafEmitter.emitterCells = array;//设置粒子组
        
    }else{
        CAEmitterLayer *fireEmitter = CAEmitterLayer.layer;
        [self.view.layer addSublayer:fireEmitter];
        
        fireEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height-60);
        fireEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width, 0);
        
        fireEmitter.emitterShape = kCAEmitterLayerLine;
        fireEmitter.emitterMode = kCAEmitterLayerOutline;
        fireEmitter.renderMode = kCAEmitterLayerAdditive;//混合渲染效果
        
        NSMutableArray *array = [NSMutableArray array];//CAEmitterCell数组，存放不同的CAEmitterCell，我这里准备了四张不同形态的叶子图片。
        for (int i = 0; i<4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"like%d",i];
            
            CAEmitterCell *fireCell = CAEmitterCell.emitterCell;
            fireCell.birthRate = 15;
            fireCell.lifetime = 6;
            
            fireCell.velocity = 10;
            fireCell.velocityRange = 10;
            
            fireCell.emissionRange = 0;
            
            fireCell.contents = (id)[[UIImage imageNamed:imageName] CGImage];
            
            fireCell.scale = 0.5;
            fireCell.scaleRange = 0.2;
            
            fireCell.alphaSpeed = -0.2;//透明度改变速度
            
            [array addObject:fireCell];
            
        }
        fireEmitter.emitterCells = array;
    }
}


@end

/*
CAEmitterLayer简介：
CAEmitterLayer（粒子发射器）继承自CALayer，提供了一个基于Core Animation的粒子发射系统，粒子用CAEmitterCell来初始化，一个单独的CAEmitterLayer可同时支持多个CAEmitterCell。

简单来说CAEmitterLayer就是发射器，可以设置位置、大小、形状等属性；CAEmitterCell就是发射出来的粒子，可以设置粒子图片，速度，旋转等属性。一个CAEmitterLayer可以同时发射多种不同的CAEmitterCell。

CAEmitterLayer属性：
emitterCells：CAEmitterCell对象的数组，用于把粒子投放到layer上。
birthRate：粒子产生速度，默认1个每秒。
lifetime：粒子纯在时间，默认1秒。
emitterPosition：发射器在xy平面的中心位置。
emitterZPosition：发射器在z平面的位置。
preservesDepth：是否开启三维效果。
velocity：粒子运动速度。
scale：粒子的缩放比例。
spin：自旋转速度。
seed：用于初始化随机数产生的种子。
emitterSize：发射器的尺寸。
emitterDepth：发射器的深度。
emitterShape：发射器的形状
NSString * const kCAEmitterLayerPoint;//点的形状，粒子从一个点发出
NSString * const kCAEmitterLayerLine;//线的形状，粒子从一条线发出
NSString * const kCAEmitterLayerRectangle;//矩形形状，粒子从一个矩形中发出
NSString * const kCAEmitterLayerCuboid;//立方体形状，会影响Z平面的效果
NSString * const kCAEmitterLayerCircle;//圆形，粒子会在圆形范围发射
NSString * const kCAEmitterLayerSphere;//球型
emitterMode：发射器发射模式
NSString * const kCAEmitterLayerPoints;//从发射器中发出
NSString * const kCAEmitterLayerOutline;//从发射器边缘发出
NSString * const kCAEmitterLayerSurface;//从发射器表面发出
NSString * const kCAEmitterLayerVolume;//从发射器中点发出
renderMode：发射器渲染模式
NSString * const kCAEmitterLayerUnordered;//粒子无序出现
NSString * const kCAEmitterLayerOldestFirst;//声明久的粒子会被渲染在最上层
NSString * const kCAEmitterLayerOldestLast;//年轻的粒子会被渲染在最上层
NSString * const kCAEmitterLayerBackToFront;//粒子的渲染按照Z轴的前后顺序进行
NSString * const kCAEmitterLayerAdditive;//粒子混合

CAEmitterCell属性：
emitterCell：初始化方法。
name：粒子的名字。
color：粒子的颜色。
enabled：粒子是否渲染。
contents：渲染粒子，是个CGImageRef的对象，即粒子要展示的图片。
contentsRect：渲染范围。
birthRate：粒子产生速度。
lifetime：生命周期。
lifetimeRange：生命周期增减范围。
velocity：粒子运动速度。
velocityRange：速度范围。
spin：粒子旋转速度。
spinrange：粒子旋转速度范围。
scale：缩放比例。
scaleRange：缩放比例范围。
scaleSpeed：缩放比例速度。
alphaRange:：一个粒子的颜色alpha能改变的范围。
alphaSpeed:：粒子透明度在生命周期内的改变速度。
redRange：一个粒子的颜色red能改变的范围。
redSpeed：粒子red在生命周期内的改变速度。
blueRange：一个粒子的颜色blue能改变的范围。
blueSpeed：粒子blue在生命周期内的改变速度。
greenRange：一个粒子的颜色green能改变的范围。
greenSpeed：粒子green在生命周期内的改变速度。
xAcceleration：粒子x方向的加速度分量。
yAcceleration：粒子y方向的加速度分量。
zAcceleration：粒子z方向的加速度分量。
emissionRange：粒子发射角度范围。
emissionLongitude：粒子在xy平面的发射角度。
emissionLatitude：发射的z轴方向的发射角度。

作者：ymdee
链接：https://www.jianshu.com/p/500d244b02e6
來源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
*/
