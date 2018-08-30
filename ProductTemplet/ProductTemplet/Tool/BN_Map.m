//
//  BN_Map.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BN_Map.h"

NSString * NSStringFromCoordinate(CLLocationCoordinate2D coordinate) {
    NSString * string = [NSString stringWithFormat:@"{%.8f,%.8f}",coordinate.latitude,coordinate.longitude];
    return string;
}

NSString * NSStringFromPlacemark(CLPlacemark *placemark) {
    NSString * string = [NSString stringWithFormat:@"{%@,%@,%@}",placemark.name,placemark.subLocality,placemark.administrativeArea];
    return string;

}

@interface BN_Map ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@property (nonatomic, assign) BOOL isSearch;

//@property (nonatomic, assign) CLLocationCoordinate2D cooCurrent;
@property (nonatomic, strong) NSString *currentLatitude ;
@property (nonatomic, strong) NSString *currentLongitude ;

@property (nonatomic, strong) AMapGeocodeSearchRequest *GeocodeRequest;

@property (nonatomic, strong) AMapPOIAroundSearchRequest *POIAroundRequest;
@property (nonatomic, strong) AMapPOIKeywordsSearchRequest *POIKeywordsRequest;
@property (nonatomic, strong) AMapInputTipsSearchRequest *InputTipsRequest;

@property (nonatomic, strong) AMapDrivingRouteSearchRequest *DrivingRequest;

@property (nonatomic, strong) MapLocationInfoModel * locationModel;
@property (nonatomic, strong) MANaviRoute * naviRoute;

@end

@implementation BN_Map

#pragma mark - - sharedInstance
+ (instancetype)sharedInstance {
    static BN_Map * _singleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[BN_Map alloc] init];
    });
    return _singleton;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static BN_Map *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

-(NSUserDefaults *)userDefaults{
    
    if (!_userDefaults) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

-(NSString *)currentLatitude{
    
    if (!_currentLatitude) {
        _currentLatitude = [self.userDefaults valueForKey:kSUserCurrentLatitude];

    }
    return _currentLatitude;
}

-(NSString *)currentLongitude{
    
    if (!_currentLongitude) {
        _currentLongitude = [self.userDefaults valueForKey:kSUserCurrentLongitude];

    }
    return _currentLongitude;
}

-(MapLocationInfoModel *)locationModel{
    if (!_locationModel) {
        _locationModel = [[MapLocationInfoModel alloc]init];
        
    }
    return _locationModel;
}

/**
 4种大头针样式,当前位置,普通大头针,起点,终点
 */
-(NSDictionary *)annViewDict{
    
    if (!_annViewDict) {
        _annViewDict = @{
                         kMapAddressUser:@"map_userLocation@2x.png",
                         kMapAddressDefault:@"map_address_Default@2x.png",
                         kMapAddressBegin:@"map_address_begin@2x.png",
                         kMapAddressEnd:@"map_address_end@2x.png"
                         };
    }
    return _annViewDict;
}

// 开始定位
- (void)startSerialLocationWithReGeocode:(BOOL)reGeocode {
    if (![self hasAccessRightOfLocation]) {
        return ;
    }
    //持续定位是否返回逆地理信息，默认NO。
    [self.locationManager setLocatingWithReGeocode:reGeocode];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;

    //开始持续定位
    [self.locationManager startUpdatingLocation];
}

// 停止定位
- (void)stopSerialLocation {
    [self.locationManager stopUpdatingLocation];
    
}

// 开始单次定位
- (void)startSingleLocationWithReGeocode:(BOOL)reGeocode handler:(MapLocationHandler)handler {
    self.locationHandler = handler;
    
    if (![self hasAccessRightOfLocation]) {
        return ;
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.locationTimeout = 2;
    self.locationManager.reGeocodeTimeout = 2;
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    kWeakSelf(self);
    [self.locationManager requestLocationWithReGeocode:reGeocode completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        kStrongSelf(weakself);
        if (strongSelf.locationHandler) strongSelf.locationHandler(location, regeocode, nil, error);
        
        if (error){
            DDLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed){
                return;
            }
        }
        
        if (regeocode){
            DDLog(@"reGeocode:%@", regeocode);
        }
    }];
}

- (void)startSerialLocationHandler:(MapLocationHandler)handler {
    self.locationHandler = handler;
    
}

- (void)didUpdateUserLocationLocationHandler:(MapLocationHandler)handler{
    self.locationHandler = handler;

}

#pragma mark - AMapLocationManager
// 定位错误
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    if (error) {
        DDLog(@"error:%@",error)
        if (self.locationHandler) self.locationHandler(nil, nil, manager, error);
        
    }
}

// 定位结果
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)newLocation reGeocode:(AMapLocationReGeocode *)reGeocode{
    if (self.locationHandler) self.locationHandler(newLocation, reGeocode, manager, nil);

}

#pragma mark - MapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    DDLog(@"didUpdateUserLocation\n___%f->%f->%@",userLocation.coordinate.latitude,userLocation.coordinate.longitude,userLocation.title);
    if (self.didUpdateUserHandler) self.didUpdateUserHandler(mapView, userLocation, updatingLocation, nil);

}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    if (error) {
        DDLog(@"error:%@",error)
        if (self.didUpdateUserHandler) self.didUpdateUserHandler(mapView, nil, nil, error);
        
    }
}

- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error{
    if (error) {
        DDLog(@"error:%@",error)
        if (self.didUpdateUserHandler) self.didUpdateUserHandler(mapView, nil, nil, error);
        
    }
}

#pragma mark - MAMapView展示元素
/* 大头针 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIdentifier = @"pointReuseIdentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIdentifier];
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIdentifier];
            annotationView.canShowCallout            = YES;
            annotationView.draggable                 = NO;
        }
        annotationView.animatesDrop              = YES;
        
        annotationView.pinColor = (annotation == self.mapView.annotations.firstObject ? MAPinAnnotationColorRed : MAPinAnnotationColorGreen);
        if ([self.annViewDict.allKeys containsObject:annotation.title]) {
            annotationView.image = [UIImage imageNamed:self.annViewDict[annotation.title]];
            
        }
        else{
            annotationView.image = [UIImage imageNamed:self.annViewDict[kMapAddressDefault]];
            
        }
        return annotationView;
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    // 自定义定位精度对应的MACircleView
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        accuracyCircleRenderer.lineWidth    = 2.f;
        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        //通过颜色隐藏精度圈
        accuracyCircleRenderer.strokeColor  = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        
        return accuracyCircleRenderer;
    }
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 5.f;
        polylineRenderer.lineDash = YES;
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 5.f;
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType = kMALineCapRound;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking){
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway){
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        return polylineRenderer;
    }
    //    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    //    {
    //        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
    //
    //        polylineRenderer.lineWidth = 10;
    //        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
    //        polylineRenderer.gradient = YES;
    //
    //        return polylineRenderer;
    //    }
    
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        //初始化一个路线类型的view
        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        //设置线宽颜色等
        polygonView.lineWidth = 5.f;
        polygonView.strokeColor = [UIColor colorWithRed:0.015 green:0.658 blue:0.986 alpha:1.000];
        polygonView.fillColor = [UIColor colorWithRed:0.940 green:0.771 blue:0.143 alpha:0.800];
        polygonView.lineJoinType = kMALineJoinRound;//连接类型
        //返回view，就进行了添加
        return polygonView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    //    DDLog(@"distance___%@",[BN_Map distanceBetweenBeginPoint:self.coordinateBegin endPoint:self.coordinateEnd type:@"0"]);
    //    [self addAnnotionCoordinate:coordinate title:kMapAddressEnd];
}

#pragma mark - -others
- (void)saveLocation:(CLLocation *)newLocation {
    // 纬度
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%f",
                                 newLocation.coordinate.latitude];
    
    // 经度
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%f",
                                  newLocation.coordinate.longitude];
    
    [self.userDefaults setObject:currentLatitude forKey:kSUserCurrentLatitude];
    [self.userDefaults setObject:currentLongitude forKey:kSUserCurrentLongitude];
    [self.userDefaults synchronize];
    
}

- (BOOL)hasAccessRightOfLocation{
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        return YES;
    } else {
        DDLog(@"请打开定位权限!");
        [self showAlertWithTitle:@"请打开定位权限!" msg:nil blockAction:nil];
   
        return NO;
    }
}

- (BOOL)hasLocation {
    return [self.currentLatitude length] && [self.currentLongitude length];
}

- (void)reGeocodeSearchWithRequest:(AMapReGeocodeSearchRequest *)request handler:(MapReGeocodeSearchHandler)handler{
    self.reGeocodeSearchHandler = handler;
    
    [self.searchAPI AMapReGoecodeSearch:request];

}

- (void)geocodeSearchWithAddress:(NSString *)address city:(NSString *)city handler:(MapGeocodeSearchHandler)handler{
    self.geocodeSearchHandler = handler;
    
//    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
    
    self.GeocodeRequest.address = address;
    self.GeocodeRequest.city = city;
    [self.searchAPI AMapGeocodeSearch:self.GeocodeRequest];
    
}

#pragma mark - 周边搜索

- (void)aroundSearchCoordinate:(CLLocationCoordinate2D)coordinate keywords:(NSString *)keywords pageIndex:(NSInteger)pageIndex handler:(MapPOISearchHandler)handler {
    self.POISearchHandler = handler;
    
//    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    self.POIAroundRequest.location          = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    self.POIAroundRequest.keywords          = keywords;
    /* 按照距离排序. */
    self.POIAroundRequest.sortrule          = 0;
    self.POIAroundRequest.requireExtension  = YES;
    self.POIAroundRequest.page              = pageIndex;

    [self.searchAPI AMapPOIAroundSearch:self.POIAroundRequest];
}

#pragma mark - 关键字搜索
- (void)keywordsSearchWithKeywords:(NSString *)keywords city:(NSString *)city page:(NSInteger)page handler:(MapPOISearchHandler)handler{
    self.POISearchHandler = handler;
//    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    self.POIKeywordsRequest.keywords            = keywords;
    self.POIKeywordsRequest.city                = city;
    //    request.types               = @"高等院校";
    self.POIKeywordsRequest.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    self.POIKeywordsRequest.cityLimit           = YES;
    //    request.requireSubPOIs      = YES;
    self.POIKeywordsRequest.page = page;
    [self.searchAPI AMapPOIKeywordsSearch:self.POIKeywordsRequest];
}

#pragma mark - 提示搜索
- (void)tipsSearchWithKeywords:(NSString *)key city:(NSString *)city handler:(MapInputTipsHandler)handler{
    self.tipsHandler = handler;
    //    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    
    self.InputTipsRequest.keywords  = key;
    self.InputTipsRequest.city      = city;
    self.InputTipsRequest.cityLimit = YES;
    [self.searchAPI AMapInputTipsSearch:self.InputTipsRequest];
}

-(void)routeSearchBeginPoint:(CLLocationCoordinate2D)beginPoint endPoint:(CLLocationCoordinate2D)endPoint strategy:(NSInteger)strategy type:(NSString *)type handler:(MapRouteHandler)handler{
    self.routeHandler = handler;
//    AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];

    self.DrivingRequest.requireExtension = YES;
    self.DrivingRequest.strategy = strategy ;
    /* 出发点. */
    self.DrivingRequest.origin = [AMapGeoPoint locationWithLatitude:beginPoint.latitude
                                           longitude:beginPoint.longitude];
    /* 目的地. */
    self.DrivingRequest.destination = [AMapGeoPoint locationWithLatitude:endPoint.latitude
                                                longitude:endPoint.longitude];
    
    [self.searchAPI AMapDrivingRouteSearch:self.DrivingRequest];
    
}

#pragma mark - AMapSearchDelegate

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    NSAssert(response.geocodes, @"response.geocodes = nil");

    if (self.geocodeSearchHandler) {
        self.geocodeSearchHandler(request, response, nil);
    }
    
    if (self.locationModel.geocodeResponse) {
        self.locationModel.geocodeResponse = response;
    }
    
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSAssert(response.regeocode, @"response.regeocode = nil");

    if (self.reGeocodeSearchHandler) {
        self.reGeocodeSearchHandler(request, response, nil);
    }
    
    if (self.locationModel.reGeocodeResponse) {
        self.locationModel.reGeocodeResponse = response;
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    NSAssert(response.pois, @"response.pois = nil");
    
//    for(AMapPOI *poi in response.pois){
//        DDLog(@"%@.%@-%@-%@",poi.name,poi.district,poi.businessArea,poi.address);
//    }

    if (self.POISearchHandler) {
        self.POISearchHandler(request,response, nil);
    }
    
    if (self.locationModel.POISearchResponse) {
        self.locationModel.POISearchResponse = response;
    }
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response{
    NSAssert(response.tips, @"response.tips = nil");

    if (self.tipsHandler) {
        self.tipsHandler(request,response, nil);
    }
    
    if (self.locationModel.inputTipsResponse) {
        self.locationModel.inputTipsResponse = response;
    }
}

//实现路径搜索的回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    NSAssert(response.route, @"response.route = nil");
    
    if (self.routeHandler) {
        self.routeHandler(request, response, nil);
    }
    
    if (self.locationModel.RouteResponse) {
        self.locationModel.RouteResponse = response;
    }
    
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
    if (error) {
        if (self.geocodeSearchHandler)      self.geocodeSearchHandler(request, nil, error);
        if (self.reGeocodeSearchHandler)    self.reGeocodeSearchHandler(request, nil, error);
        if (self.POISearchHandler)          self.POISearchHandler(request,nil, error);
        if (self.tipsHandler)               self.tipsHandler(request,nil, error);
        if (self.routeHandler)              self.routeHandler(request, nil, error);
        
    }
}

#pragma mark - -other funtions
+ (NSString *)distanceBetweenBeginPoint:(CLLocationCoordinate2D )beginPoint endPoint:(CLLocationCoordinate2D )endPoint type:(NSString *)type{

    MAMapPoint begin = MAMapPointForCoordinate(beginPoint);
    MAMapPoint end = MAMapPointForCoordinate(endPoint);
    
    CLLocationDistance distance =  MAMetersBetweenMapPoints(begin, end);
    NSString * distanceStr = [@(distance) stringValue];
    
    switch ([type integerValue]) {//返回米
        case 0:
        {
            return distanceStr;
        }
            break;
        case 1:
        {
            distanceStr = [@(distance/1000.0) stringValue];//返回公里/千米
            return distanceStr;
        }
            break;
        default:
            break;
    }
    return nil;
}

/* 获取指定title的针 */
+ (MAPointAnnotation *)getPointAnnotationTitle:(NSString *)title mapView:(MAMapView *)mapView{
    
    if (mapView.annotations) {
        for (id obj in mapView.annotations) {
            if ([obj isKindOfClass:[MAPointAnnotation class]]) {
                
                MAPointAnnotation * pointAnnotation = (MAPointAnnotation *)obj;
                if ([pointAnnotation.title isEqualToString:title]) {
                    
                    return pointAnnotation;
                }
            }
        }
    }
    return nil;
}


//路线解析
+ (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0) return nil;
    
    NSMutableArray *polylines = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [BN_Map coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        //          MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:count];
        
        [polylines addObject:polyline];
        free(coordinates), coordinates = NULL;
    }];
    return polylines;
}

/* 展示当前路线方案. */

//在地图上显示当前选择的路径
- (void)presentCurrentRouteBeginPoint:(CLLocationCoordinate2D )beginPoint endPoint:(CLLocationCoordinate2D )endPoint response:(AMapRouteSearchResponse *)response{
    
    [self.naviRoute removeFromMapView];  //清空地图上已有的路线
    
    AMapGeoPoint *origin =      [AMapGeoPoint locationWithLatitude:beginPoint.latitude longitude:beginPoint.longitude]; //起点
    AMapGeoPoint *destination = [AMapGeoPoint locationWithLatitude:endPoint.latitude longitude:endPoint.longitude];  //终点
    
    //根据已经规划的路径，起点，终点，规划类型，是否显示实时路况，生成显示方案
    self.naviRoute = [MANaviRoute naviRouteForPath:response.route.paths[0] withNaviType:MANaviAnnotationTypeDrive showTraffic:NO startPoint:origin endPoint:destination];
    self.naviRoute.anntationVisible = NO;
    self.naviRoute.routeColor = kC_ThemeCOLOR_One;

    [self.naviRoute addToMapView:self.mapView];  //显示到地图上
    
    //缩放地图使其适应polylines的展示
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)
                           animated:YES];
}


//解析经纬度
+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil) return NULL;
    if (token == nil) token = @",";
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)  *coordinateCount = count;
    
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    for (NSInteger i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    return coordinates;
}

+ (NSString *)getAddressInfo:(id)obj{
    
    NSString *addressInfo = @"";
    if ([obj isKindOfClass:[AMapReGeocode class]]) {
        AMapReGeocode * regeocode = (AMapReGeocode *)obj;
        addressInfo = [NSString stringWithFormat:@"province:%@,city:%@,district:%@,town:%@,neighborhood:%@,building:%@,street:%@,streetNumber:%@",
                       regeocode.addressComponent.province,
                       regeocode.addressComponent.city,
                       regeocode.addressComponent.district,
                       regeocode.addressComponent.township,
                       regeocode.addressComponent.neighborhood,
                       regeocode.addressComponent.building,
                       regeocode.addressComponent.streetNumber.street,
                       regeocode.addressComponent.streetNumber.number
                       ];
        
    }else if ([obj isKindOfClass:[AMapLocationReGeocode class]]) {
        AMapLocationReGeocode *regeocode = (AMapLocationReGeocode *)obj;
        addressInfo = [NSString stringWithFormat:@"province:%@,city:%@,district:%@,street:%@,streetNumber:%@",
                       regeocode.province,
                       regeocode.city,
                       regeocode.district,
                       regeocode.street,
                       regeocode.number
                       ];
        
    }
    return addressInfo;
}

- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg blockAction:(BlockAlertController _Nullable)blockAction{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"知道了"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
                                                          
                                                      }]];
    UIViewController * rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - layz
- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height - kH_StatusAndNaviagtionBarHeight)];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _mapView.distanceFilter = kCLLocationAccuracyKilometer;
        //        _mapView.headingFilter  = 90;
        _mapView.zoomLevel = 16;
        //自定义定位经度圈样式
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
        //        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.showsCompass = YES;
        [_mapView setCompassImage:[UIImage imageNamed:@"map_address_compass@2x.png"]];
        
        //后台定位
        _mapView.pausesLocationUpdatesAutomatically = NO;
        _mapView.allowsBackgroundLocationUpdates = NO;//iOS9以上系统必须配置
        _mapView.showsUserLocation = YES;

        _mapView.delegate = self;
    }
    return _mapView;
}

- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.locationTimeout = 2;
        _locationManager.reGeocodeTimeout = 2;

        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        if (iOS(9)) {
            _locationManager.allowsBackgroundLocationUpdates = NO;

        }
        _locationManager.locatingWithReGeocode = YES;//返回地理信息
    }
    return _locationManager;
}

- (AMapSearchAPI *)searchAPI{
    if (!_searchAPI) {
        _searchAPI = [[AMapSearchAPI alloc] init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

-(AMapGeocodeSearchRequest *)GeocodeRequest{
    if (!_GeocodeRequest) {
        _GeocodeRequest = [[AMapGeocodeSearchRequest alloc]init];
    }
    return _GeocodeRequest;
}

-(AMapPOIAroundSearchRequest *)POIAroundRequest{
    if (!_POIAroundRequest) {
        _POIAroundRequest = [[AMapPOIAroundSearchRequest alloc] init];
        
    }
    return _POIAroundRequest;
}

-(AMapPOIKeywordsSearchRequest *)POIKeywordsRequest{
    if (!_POIKeywordsRequest) {
        _POIKeywordsRequest = [[AMapPOIKeywordsSearchRequest alloc]init];
    }
    return _POIKeywordsRequest;
}

-(AMapInputTipsSearchRequest *)InputTipsRequest{
    if (!_InputTipsRequest) {
        _InputTipsRequest = [[AMapInputTipsSearchRequest alloc]init];
    }
    return _InputTipsRequest;
}

-(AMapDrivingRouteSearchRequest *)DrivingRequest{
    if (!_DrivingRequest) {
        _DrivingRequest = [[AMapDrivingRouteSearchRequest alloc]init];
        
    }
    return _DrivingRequest;
}

- (NSString *)stringFromPoint:(AMapGeoPoint *)point{
    NSString * coordinateStr = [NSString stringWithFormat:@"%.8f,%.8f",point.latitude,point.longitude];
    return coordinateStr;
}


-(AMapTip *)mapTipFromPoi:(AMapPOI *)mapPoi{
    
    AMapTip * mapTip = [[AMapTip alloc]init];
    mapTip.uid = mapPoi.uid;
    mapTip.name = mapPoi.name;
    mapTip.adcode = mapPoi.adcode;
    mapTip.district = mapPoi.district;
    mapTip.address = mapPoi.address;
    mapTip.location = mapPoi.location;
    mapTip.typecode = mapPoi.typecode;

    return mapTip;
}

@end


@implementation MapLocationInfoModel

-(AMapLocationReGeocode *)locationReGeocode{
    
    if (!_locationReGeocode) {
        _locationReGeocode = [[AMapLocationReGeocode alloc]init];
        
    }
    return _locationReGeocode;
}

-(AMapReGeocodeSearchResponse *)reGeocodeResponse{
    if (!_reGeocodeResponse) {
        _reGeocodeResponse = [[AMapReGeocodeSearchResponse alloc]init];
        
    }
    return _reGeocodeResponse;
}

-(AMapGeocodeSearchResponse *)geocodeResponse{
    if (!_geocodeResponse) {
        _geocodeResponse = [[AMapGeocodeSearchResponse alloc]init];
        
    }
    return _geocodeResponse;
}

-(AMapInputTipsSearchResponse *)inputTipsResponse{
    if (!_inputTipsResponse) {
        _inputTipsResponse = [[AMapInputTipsSearchResponse alloc]init];
        
    }
    return _inputTipsResponse;
    
}

-(AMapRouteSearchResponse *)RouteResponse{
    if (!_RouteResponse) {
        _RouteResponse = [[AMapRouteSearchResponse alloc]init];
        
    }
    return _RouteResponse;
}

-(AMapPOISearchResponse *)POISearchResponse{
    if (!_POISearchResponse) {
        _POISearchResponse = [[AMapPOISearchResponse alloc]init];
    }
    return _POISearchResponse;
}

@end

