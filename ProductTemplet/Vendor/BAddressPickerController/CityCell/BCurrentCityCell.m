//
//  BCurrentCityCell.m
//  Bee
//
//  Created by 林洁 on 16/1/12.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "BCurrentCityCell.h"
#import "BAddressHeader.h"

#import "WHKUserDataModel.h"
#import "NSUserDefaults+Helper.h"
#import "NSObject+Helper.h"

@implementation BCurrentCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BG_CELL;
        [self.contentView addSubview:self.GPSButton];
        [self.contentView addSubview:self.activityIndicatorView];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.locationManager];
        [self setUp];
    }
    return self;
}

- (void)setUp{
    if ([NSUserDefaults objectForKey:KEY_userCity]) {
        NSString * city = [NSUserDefaults objectForKey:KEY_userCity];
        NSLog(@"city_%@",city);
        [self.label setHidden:YES];
        NSString *title = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        [self.GPSButton setTitle:title forState:UIControlStateNormal];
        [self.GPSButton setHidden:NO];
        return;
    }
    
    [self.locationManager startWithBlock:^{
        [self.GPSButton setHidden:YES];
        [self.activityIndicatorView startAnimating];
    } completionBlock:^(CLLocation *location) {
        [self.searchManager startReverseGeocode:location completeionBlock:^(LNLocationGeocoder *locationGeocoder, NSError *error) {
            if (!error) {
                [self.activityIndicatorView stopAnimating];
                [self.label setHidden:YES];
                NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@",locationGeocoder.city];
                NSString *title = [mutableString stringByReplacingOccurrencesOfString:@"市" withString:@""];
                [self.GPSButton setTitle:title forState:UIControlStateNormal];
                [self.GPSButton setHidden:NO];
            }
        }];
    } failure:^(CLLocation *location, NSError *error) {
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Event Response
- (void)buttonWhenClick:(void (^)(UIButton *))block{
    self.buttonClickBlock = block;
}

- (void)buttonClick:(UIButton*)button{
    self.buttonClickBlock(button);
}

#pragma mark - Getter and Setter
- (UIButton*)GPSButton{
    if (!_GPSButton) {
        _GPSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _GPSButton.frame = CGRectMake(15, 15 , BUTTON_WIDTH, BUTTON_HEIGHT);
        [_GPSButton setTitle:@"" forState:UIControlStateNormal];
        _GPSButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _GPSButton.tintColor = UIColor.blackColor;
        _GPSButton.backgroundColor = UIColor.whiteColor;
        _GPSButton.alpha = 0.8;
        _GPSButton.layer.borderColor = [UIColorRGBA(237, 237, 237, 1.0) CGColor];
        _GPSButton.layer.borderWidth = 1;
        _GPSButton.layer.cornerRadius = 3;
        [_GPSButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _GPSButton;
}

- (UIActivityIndicatorView*)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(15, 15, BUTTON_HEIGHT, BUTTON_HEIGHT)];
        _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _activityIndicatorView.color = UIColor.grayColor;
        _activityIndicatorView.hidesWhenStopped = YES;
    }
    return _activityIndicatorView;
}

- (UILabel*)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15 + BUTTON_HEIGHT, 15, BUTTON_WIDTH, BUTTON_HEIGHT)];
        _label.text = @"定位中...";
        _label.font = [UIFont systemFontOfSize:16.0f];
    }
    return _label;
}

- (LNLocationManager*)locationManager{
    if (!_locationManager) {
        _locationManager = [[LNLocationManager alloc] init];
    }
    return _locationManager;
}

- (LNSearchManager*)searchManager{
    if (_searchManager == nil) {
        _searchManager = [[LNSearchManager alloc] init];
    }
    return _searchManager;
}

@end
