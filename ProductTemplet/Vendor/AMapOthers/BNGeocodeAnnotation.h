//
//  BNGeocodeAnnotation.h
//  
//
//  Created by BIN on 2017/9/9.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapCommonObj.h>

@interface BNGeocodeAnnotation : NSObject

@property (nonatomic, readonly, strong) AMapGeocode *geocode;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (NSString *)title;
- (NSString *)subtitle;

- (id)initWithGeocode:(AMapGeocode *)geocode;

@end
