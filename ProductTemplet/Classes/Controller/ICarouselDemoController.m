//
//  ICarouselDemoController.m
//  ProductTemplet
//
//  Created by BIN on 2026/8/23.
//  Copyright © 2026 BN. All rights reserved.
//

#import "ICarouselDemoController.h"
#import "NNResourceManager.h"
#import <iCarousel/iCarousel.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@interface ICarouselDemoController ()<iCarouselDataSource, iCarouselDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) NSArray<NSString *> *imageUrls;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UITableView *tableView;

// 调节项：标题、控件、值
@property (nonatomic, strong) NSArray<NSString *> *sliderTitles;
@property (nonatomic, strong) NSArray<NSString *> *switchTitles;

@property (nonatomic, strong) UISlider *typeSlider;
@property (nonatomic, strong) UISlider *spacingSlider;
@property (nonatomic, strong) UISlider *radiusSlider;
@property (nonatomic, strong) UISlider *tiltSlider;

@property (nonatomic, strong) UISwitch *wrapSwitch;
@property (nonatomic, strong) UISwitch *verticalSwitch;
@property (nonatomic, strong) UISwitch *pagingSwitch;
@property (nonatomic, strong) UISwitch *autoscrollSwitch;

@end

@implementation ICarouselDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"iCarousel展示";

    self.imageUrls = NNResourceManager.shared.imageUrls;
    self.sliderTitles = @[@"类型", @"间距", @"半径", @"倾斜"];
    self.switchTitles = @[@"环绕", @"垂直", @"分页", @"自动滚动"];

    [self.view addSubview:self.carousel];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.tableView];

    [self setupLayout];
    [self updateInfo];
}

- (void)setupLayout {
    CGFloat margin = 16;

    [self.carousel makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(kScreenWidth * 0.6));
    }];

    [self.infoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carousel.bottom).offset(margin);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, margin, 0, margin));
    }];

    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.bottom).offset(8);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.imageUrls.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    UIImageView *imageView = (UIImageView *)view;
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.7, kScreenWidth * 0.6)];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.backgroundColor = UIColor.blackColor;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrls[index]] placeholderImage:UIImage.img_failedDefault];
    return imageView;
}

#pragma mark - iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return kScreenWidth * 0.7;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option) {
        case iCarouselOptionSpacing: return self.spacingSlider.value;
        case iCarouselOptionRadius:  return self.radiusSlider.value;
        case iCarouselOptionTilt:    return self.tiltSlider.value;
        case iCarouselOptionWrap:    return self.wrapSwitch.on ? 1.0 : 0.0;
        case iCarouselOptionShowBackfaces: return 1.0;
        default: return value;
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    [self updateInfo];
}

#pragma mark - actions

- (void)onTypeChanged:(UISlider *)slider {
    self.carousel.type = (iCarouselType)lround(slider.value);
    [self updateInfo];
    [self.tableView reloadData];
}

- (void)onPropertyChanged:(UISlider *)slider {
    [self.carousel reloadData];
    [self updateInfo];
    [self.tableView reloadData];
}

- (void)onSwitchChanged:(UISwitch *)sw {
    if (sw == self.wrapSwitch) {
        [self.carousel reloadData];
    } else if (sw == self.verticalSwitch) {
        self.carousel.vertical = sw.on;
    } else if (sw == self.pagingSwitch) {
        self.carousel.pagingEnabled = sw.on;
    } else if (sw == self.autoscrollSwitch) {
        self.carousel.autoscroll = sw.on ? 0.8 : 0.0;
    }
    [self updateInfo];
    [self.tableView reloadData];
}

- (void)updateInfo {
    NSArray *typeNames = @[
        @"Linear", @"Rotary", @"InvertedRotary", @"Cylinder", @"InvertedCylinder",
        @"Wheel", @"InvertedWheel", @"CoverFlow", @"CoverFlow2", @"TimeMachine",
        @"InvertedTimeMachine", @"Custom",
    ];
    self.infoLabel.text = [NSString stringWithFormat:@"type:%@ | idx:%ld/%ld",
                           typeNames[(NSInteger)self.carousel.type],
                           (long)(self.carousel.currentItemIndex + 1),
                           (long)self.imageUrls.count];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"Slider" : @"Switch";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    if (indexPath.section == 0) {
        NSArray *sliders = @[self.typeSlider, self.spacingSlider, self.radiusSlider, self.tiltSlider];
        UISlider *slider = sliders[indexPath.row];
        NSString *title = self.sliderTitles[indexPath.row];
        NSString *valueText = [self sliderValueTextForRow:indexPath.row];
        [self setupRowInCell:cell title:title control:slider valueText:valueText];
    } else {
        NSArray *switches = @[self.wrapSwitch, self.verticalSwitch, self.pagingSwitch, self.autoscrollSwitch];
        UISwitch *sw = switches[indexPath.row];
        NSString *title = self.switchTitles[indexPath.row];
        NSString *valueText = sw.on ? @"ON" : @"OFF";
        [self setupRowInCell:cell title:title control:sw valueText:valueText];
    }
    return cell;
}

- (void)setupRowInCell:(UITableViewCell *)cell title:(NSString *)title control:(UIView *)control valueText:(NSString *)valueText {
    CGFloat w = CGRectGetWidth(self.view.frame);

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 64, 44)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = UIColor.darkTextColor;
    [cell.contentView addSubview:titleLabel];

    CGFloat controlW = w - 16 - 64 - 12 - 60 - 16;
    control.frame = CGRectMake(16 + 64 + 12, (44 - 31) / 2.0, controlW, 31);
    [cell.contentView addSubview:control];

    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(w - 16 - 60, 0, 60, 44)];
    valueLabel.text = valueText;
    valueLabel.font = [UIFont systemFontOfSize:12];
    valueLabel.textColor = UIColor.grayColor;
    valueLabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:valueLabel];
}

- (NSString *)sliderValueTextForRow:(NSInteger)row {
    switch (row) {
        case 0: return [NSString stringWithFormat:@"%d", (int)lround(self.typeSlider.value)];
        case 1: return [NSString stringWithFormat:@"%.2f", self.spacingSlider.value];
        case 2: return [NSString stringWithFormat:@"%.0f", self.radiusSlider.value];
        case 3: return [NSString stringWithFormat:@"%.2f", self.tiltSlider.value];
        default: return @"";
    }
}

#pragma mark - lazy

- (iCarousel *)carousel {
    if (!_carousel) {
        _carousel = [[iCarousel alloc] init];
        _carousel.dataSource = self;
        _carousel.delegate = self;
        _carousel.type = iCarouselTypeCoverFlow2;
        _carousel.backgroundColor = UIColor.blackColor;
    }
    return _carousel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = [UIFont systemFontOfSize:13];
        _infoLabel.textColor = UIColor.darkTextColor;
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = 44;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UISlider *)typeSlider {
    if (!_typeSlider) {
        _typeSlider = [self makeSliderWithMin:0 max:iCarouselTypeCustom value:iCarouselTypeCoverFlow2 action:@selector(onTypeChanged:)];
    }
    return _typeSlider;
}

- (UISlider *)spacingSlider {
    if (!_spacingSlider) {
        _spacingSlider = [self makeSliderWithMin:0.1 max:2.0 value:0.35 action:@selector(onPropertyChanged:)];
    }
    return _spacingSlider;
}

- (UISlider *)radiusSlider {
    if (!_radiusSlider) {
        _radiusSlider = [self makeSliderWithMin:50 max:400 value:200 action:@selector(onPropertyChanged:)];
    }
    return _radiusSlider;
}

- (UISlider *)tiltSlider {
    if (!_tiltSlider) {
        _tiltSlider = [self makeSliderWithMin:-1.0 max:1.0 value:0.9 action:@selector(onPropertyChanged:)];
    }
    return _tiltSlider;
}

- (UISlider *)makeSliderWithMin:(float)min max:(float)max value:(float)value action:(SEL)action {
    UISlider *slider = [[UISlider alloc] init];
    slider.minimumValue = min;
    slider.maximumValue = max;
    slider.value = value;
    [slider addTarget:self action:action forControlEvents:UIControlEventValueChanged];
    return slider;
}

- (UISwitch *)wrapSwitch {
    if (!_wrapSwitch) {
        _wrapSwitch = [[UISwitch alloc] init];
        _wrapSwitch.on = YES;
        [_wrapSwitch addTarget:self action:@selector(onSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _wrapSwitch;
}

- (UISwitch *)verticalSwitch {
    if (!_verticalSwitch) {
        _verticalSwitch = [[UISwitch alloc] init];
        _verticalSwitch.on = NO;
        [_verticalSwitch addTarget:self action:@selector(onSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _verticalSwitch;
}

- (UISwitch *)pagingSwitch {
    if (!_pagingSwitch) {
        _pagingSwitch = [[UISwitch alloc] init];
        _pagingSwitch.on = NO;
        [_pagingSwitch addTarget:self action:@selector(onSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pagingSwitch;
}

- (UISwitch *)autoscrollSwitch {
    if (!_autoscrollSwitch) {
        _autoscrollSwitch = [[UISwitch alloc] init];
        _autoscrollSwitch.on = NO;
        [_autoscrollSwitch addTarget:self action:@selector(onSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _autoscrollSwitch;
}

@end
