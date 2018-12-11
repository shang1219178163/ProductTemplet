//
//  FlowerFactory.m
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/24.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "FlowerFactory.h"
#import "FlowerView.h"

@implementation FlowerFactory

-(UIView *)flowerViewWithType:(FlowerType)type{
    //懒加载花朵池
    if (!flowerPool) {
        flowerPool = [[NSMutableDictionary alloc] initWithCapacity:kTotalNumberOfFlowerTypes];
    }
    //尝试从花朵池中取出一朵花
    __block UIView *flowerView = flowerPool[@(type)];
    
        //如果请求的类型不存在，那么就创建一个，并添加到池里
    if (!flowerView) {
        NSString * imgName = [@"flower" stringByAppendingFormat:@"%@",@(type)];
        UIImage *flowerImage = [UIImage imageNamed:imgName];
        flowerView = [[FlowerView alloc] initWithImage:flowerImage];
        [flowerPool setObject:flowerView forKey:@(type)];
        
    }
    return flowerView;
}

//-(UIView *)flowerViewWithType:(FlowerType)type{
//    //懒加载花朵池
//    if (!flowerPool) {
//        flowerPool = [[NSMutableDictionary alloc] initWithCapacity:kTotalNumberOfFlowerTypes];
//    }
//    //尝试从花朵池中取出一朵花
//    UIView *flowerView = flowerPool[@(type)];
//
//    //如果请求的类型不存在，那么就创建一个，并添加到池里
//    if (!flowerView) {
//
//        UIImage *flowerImage;
//        switch (type) {
//            case kAnemone:
//            {
//                flowerImage = [UIImage imageNamed:@"flower1"];
//            }
//                break;
//            case kCosmos:
//            {
//                flowerImage = [UIImage imageNamed:@"flower2"];
//            }
//                break;
//            case kGerberas:
//            {
//                flowerImage = [UIImage imageNamed:@"flower3"];
//            }
//                break;
//            case kHollyhock:
//            {
//                flowerImage = [UIImage imageNamed:@"flower4"];
//            }
//                break;
//            case kJasmine:
//            {
//                flowerImage = [UIImage imageNamed:@"flower5"];
//            }
//                break;
//            case kZinnia:
//            {
//                flowerImage = [UIImage imageNamed:@"flower6"];
//            }
//                break;
//
//            default:
//                break;
//        }
//
//        flowerView = [[FlowerView alloc] initWithImage:flowerImage];
//        [flowerPool setObject:flowerView forKey:@(type)];
//
//    }
//
//    return flowerView;
//}


@end
