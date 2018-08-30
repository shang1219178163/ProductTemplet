//
//  WHKPinAnnotationModel.h
//  HuiZhuBang
//
//  Created by 晁进 on 2017/8/4.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHKPinAnnotationModel : NSObject

//百度地图返回地址信息
@property (nonatomic, copy) NSString *resultProvince;
@property (nonatomic, copy) NSString *resultCity;
@property (nonatomic, copy) NSString *resultStreetName;
@property (nonatomic, copy) NSString *resultAddress;
@property (nonatomic, copy) NSString *resultBusinessCircle;

@property (nonatomic, copy) NSString * modelIndex;//第几个model

@property (nonatomic, copy) UIImage * image;

@property (nonatomic, copy) NSString * type;//0默认;1起点 ;2终点
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * titleSub;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dict;

@end
