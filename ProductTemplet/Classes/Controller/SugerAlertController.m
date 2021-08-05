//
//  SugerAlertController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/15.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "SugerAlertController.h"

#import "NNActionSheet.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface SugerAlertController ()

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation SugerAlertController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self showSugerAlertView];
    
}

- (void)showSugerAlertView{
    @weakify(self);
    NNActionSheet *optionsView = [[NNActionSheet alloc]initWithTitleView:self.headView optionsArr:self.dataArr cancelTitle:@"取消" selectedBlock:^(NSInteger index) {
        @strongify(self);
        NSString *optionsStr = self.dataArr[index];
        if ([optionsStr isEqualToString:@"苹果地图"]) {
            [self openAppleMap];
        }
        else if ([optionsStr isEqualToString:@"百度地图"]) {
            
        }
        else if ([optionsStr isEqualToString:@"高德地图"]) {
            
        }
    } cancelBlock:^{
        
    }];
    
    [self.view addSubview:optionsView];
    
}

- (NSMutableArray*)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]) {
            [_dataArr addObject:@"百度地图"];
        }
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
            [_dataArr addObject:@"高德地图"];
        }
        [_dataArr addObjectsFromArray:@[@"苹果地图"]];
    }
    return _dataArr;
}

- (UIView*)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 100)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width - 20, 30)];
        titleLabel.text = @"请选择导航";
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor colorWithRed:73/255.0 green:75/255.0 blue:90/255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:titleLabel];
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        descLabel.text = @"记住我的选择，不再提示";
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.center = CGPointMake(_headView.center.x, 55);
        [_headView addSubview:descLabel];
        
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton.frame = CGRectMake(CGRectGetMinX(descLabel.frame) - 30, 45, 20, 20);
        [selectedButton setImage:[UIImage imageNamed:@"btn_selected_NO"] forState:UIControlStateNormal];
        [selectedButton setImage:[UIImage imageNamed:@"btn_selected_YES"] forState:UIControlStateSelected];
        [selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:selectedButton];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, self.view.bounds.size.width - 20, .5)];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [_headView addSubview:line];
    }
    return _headView;
}

- (void)selectedClick:(UIButton*)button {
    button.selected = !button.selected;
}

- (void)openAppleMap {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.984066, 116.307606);
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    //    endLocation = [endLocation locationMarsFromBaidu];//火星坐标转换为百度坐标
    CLLocationCoordinate2D endCoor = endLocation.coordinate;
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{
                                   MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                   MKLaunchOptionsShowsTrafficKey: @(YES),
                                   MKLaunchOptionsMapTypeKey : @(0),
                                   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

