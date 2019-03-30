//
//  BNGeocodeAnnotation.m
//  
//
//  Created by BIN on 2017/9/9.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "BNGeocodeAnnotation.h"

@interface BNGeocodeAnnotation ()

@property (nonatomic, readwrite, strong) AMapGeocode *geocode;

@end


@implementation BNGeocodeAnnotation

- (NSString *)title
{
    return self.geocode.formattedAddress;
}

- (NSString *)subtitle
{
    return [self.geocode.location description];
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.geocode.location.latitude, self.geocode.location.longitude);
}

#pragma mark - Life Cycle

- (id)initWithGeocode:(AMapGeocode *)geocode
{
    if (self = [super init])
    {
        self.geocode = geocode;
    }
    
    return self;
}


@end
