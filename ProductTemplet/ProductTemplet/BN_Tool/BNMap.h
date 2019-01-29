//
//  BNMap.h
//  
//
//  Created by BIN on 2017/12/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>


#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import "CommonUtility.h"
#import "ErrorInfoUtility.h"
#import "MANaviRoute.h"

#define kSUserCurrentLatitude   @"kSUserCurrentLatitude"
#define kSUserCurrentLongitude  @"kSUserCurrentLongitude"

static  NSString *const kMapAddressBegin = @"起点";
static  NSString *const kMapAddressEnd = @"终点";
static  NSString *const kMapAddressDefault = @"大头针";
static  NSString *const kMapAddressUser = @"用户位置";

static  NSString *const kMapAddressCar = @"car_green";
static  NSString *const kMapAddressCarEnd = @"car_red";

UIKIT_EXTERN NSString * NSStringFromCoordinate(CLLocationCoordinate2D coordinate);
UIKIT_EXTERN NSString * NSStringFromPlacemark(CLPlacemark *placemark);

typedef void (^MapDidUpdateUserHandler)(MAMapView *mapView, MAUserLocation *userLocation, BOOL updatingLocation, NSError *error);
typedef void (^MapLocationHandler)(CLLocation *location, AMapLocationReGeocode *regeocode, AMapLocationManager *manager, NSError *error);
typedef void (^MapReGeocodeSearchHandler)(AMapReGeocodeSearchRequest *request, AMapReGeocodeSearchResponse *response, NSError *error);
typedef void (^MapGeocodeSearchHandler)(AMapGeocodeSearchRequest *request,  AMapGeocodeSearchResponse *response, NSError *error);
typedef void (^MapPOISearchHandler)(AMapPOISearchBaseRequest *request, AMapPOISearchResponse *response, NSError *error);
typedef void (^MapInputTipsHandler)(AMapInputTipsSearchRequest *request, AMapInputTipsSearchResponse *response, NSError *error);

typedef void (^MapRouteHandler)(AMapRouteSearchBaseRequest *request, AMapRouteSearchResponse *response, NSError *error);

@class MapLocationInfoModel;
@interface BNMap : NSObject<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *searchAPI;

/**mapView: didUpdateUserLocation: updatingLocation:*/
@property (nonatomic, copy) MapDidUpdateUserHandler didUpdateUserHandler;

/** amapLocationManager:didUpdateLocation: reGeocode:*/
@property (nonatomic, copy) MapLocationHandler locationHandler;
@property (nonatomic, copy) MapReGeocodeSearchHandler reGeocodeSearchHandler;
@property (nonatomic, copy) MapGeocodeSearchHandler geocodeSearchHandler;
@property (nonatomic, copy) MapPOISearchHandler POISearchHandler;
@property (nonatomic, copy) MapInputTipsHandler tipsHandler;
@property (nonatomic, copy) MapRouteHandler routeHandler;

@property (nonatomic, strong) NSDictionary * annViewDict;//起点终点信息
/** 是否有经纬度*/
@property (nonatomic, assign) BOOL hasLocation;

// 快速创建一个locationManager
+ (instancetype)sharedInstance;

/**
 定位权限
 */
- (BOOL)hasAccessRightOfLocation;

/**
 开始单次定位
 */
- (void)startSingleLocationWithReGeocode:(BOOL)reGeocode handler:(MapLocationHandler)handler;
/**
 开始持续定位
 */
- (void)startSerialLocationWithReGeocode:(BOOL)reGeocode;

/**
 根据mapview参数实时返回经纬度
 */
- (void)didUpdateUserLocationLocationHandler:(MapLocationHandler)handler;

/**
 开始周边搜索🔍
 */
- (void)aroundSearchCoordinate:(CLLocationCoordinate2D)coordinate keywords:(NSString *)keywords pageIndex:(NSInteger)pageIndex handler:(MapPOISearchHandler)handler;

/**
 逆地理编码请求
 */
- (void)reGeocodeSearchWithRequest:(AMapReGeocodeSearchRequest *)request handler:(MapReGeocodeSearchHandler)handler;

/**
 地理编码请求
 */
- (void)geocodeSearchWithAddress:(NSString *)address city:(NSString *)city handler:(MapGeocodeSearchHandler)handler;

/**
 关键字搜索
 
 @param keywords 搜索关键字 必传参数
 @param city 搜索城市
 @param page 搜索页数
 */
- (void)keywordsSearchWithKeywords:(NSString *)keywords city:(NSString *)city page:(NSInteger)page handler:(MapPOISearchHandler)handler;
/** 
 提示搜索
 */
- (void)tipsSearchWithKeywords:(NSString *)key city:(NSString *)city handler:(MapInputTipsHandler)handler;

/**
 路径搜索
 */
- (void)routeSearchBeginPoint:(CLLocationCoordinate2D)beginPoint endPoint:(CLLocationCoordinate2D)endPoint strategy:(NSInteger)strategy type:(NSString *)type handler:(MapRouteHandler)handler;

/**
 返回2点之间直线距离

 @param type 0返回米.1返回公里
 @return 返回值
 */
+ (NSString *)distanceBetweenBeginPoint:(CLLocationCoordinate2D )beginPoint endPoint:(CLLocationCoordinate2D )endPoint type:(NSString *)type;

/**
 获取指定title的针
 */
+ (MAPointAnnotation *)getPointAnnotationTitle:(NSString *)title mapView:(MAMapView *)mapView;

+ (NSArray *)polylinesForPath:(AMapPath *)path;

- (void)presentCurrentRouteBeginPoint:(CLLocationCoordinate2D )beginPoint endPoint:(CLLocationCoordinate2D )endPoint response:(AMapRouteSearchResponse *)response;


+ (NSString *)getAddressInfo:(id)obj;

- (AMapTip *)mapTipFromPoi:(AMapPOI *)mapPoi;

@end


@interface MapLocationInfoModel : NSObject

@property (nonatomic, strong) AMapLocationReGeocode *locationReGeocode;
@property (nonatomic, strong) AMapReGeocodeSearchResponse *reGeocodeResponse;
@property (nonatomic, strong) AMapGeocodeSearchResponse *geocodeResponse;

@property (nonatomic, strong) AMapInputTipsSearchResponse *inputTipsResponse;
@property (nonatomic, strong) AMapRouteSearchResponse *RouteResponse;

@property (nonatomic, strong) AMapPOISearchResponse *POISearchResponse;

@end
