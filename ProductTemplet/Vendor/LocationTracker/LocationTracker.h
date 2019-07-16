//
//  LocationTracker.h
//  Location
//
//  Created by Rick
//  Copyright (c) 2014 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationShareModel.h"

#define kTimer_Interval  60*20
#define kTimer_Interval_Foreground  60*5

//#define kTimer_Interval  30
//#define kTimer_Interval_Foreground  30

#define kLocation_Duration  10
#define kLocation_Accuracy  2000

#define kLocation_latitude   @"kLocation_latitude"
#define kLocation_longitude  @"kLocation_longitude"
#define kLocation_accuracy   @"kLocation_accuracy"
#define kLocation_timeStamp  @"kLocation_timeStamp"

#define kNoti_locationOld @"kNoti_locationOld"
#define kNoti_locationNew @"kNoti_locationNew"

@interface LocationTracker : NSObject <CLLocationManagerDelegate>

@property (nonatomic) CLLocationCoordinate2D myLastLocation;
@property (nonatomic) CLLocationAccuracy myLastLocationAccuracy;

@property (strong,nonatomic) LocationShareModel * shareModel;

@property (nonatomic) CLLocationCoordinate2D myLocation;
@property (nonatomic) CLLocationAccuracy myLocationAccuracy;

+ (CLLocationManager *)shared;

- (void)startLocationTracking;
- (void)stopLocationTracking;
- (void)updateLocationToServer;

+(instancetype)shareInstance;

@end
