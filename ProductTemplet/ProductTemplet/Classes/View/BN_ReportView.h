//
//  BN_ReportView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AAChartKit.h"
#import "BN_ExcelView.h"

typedef NS_ENUM(NSInteger,SpecialChartVCChartType) {
    SpecialChartVCChartTypeColorfulColumnChart = 0,
    SpecialChartVCChartTypeGradientColorBar ,
    SpecialChartVCChartTypeDoubleYAxisesChart,
    SpecialChartVCChartTypeDifferentDashStyleLine,
    SpecialChartVCChartTypeMixedLine,
    SpecialChartVCChartTypeArea,
    SpecialChartVCChartTypeAreaspline,
    SpecialChartVCChartTypePie,
    SpecialChartVCChartTypeBubble,
    SpecialChartVCChartTypeScatter,
    //    SpecialChartVCChartTypeTreeMap,
    SpecialChartVCChartTypeArearange,
    SpecialChartVCChartTypeColumnrange,
    SpecialChartVCChartTypeStepLine,
    SpecialChartVCChartTypeStepArea,
    SpecialChartVCChartTypeRangeAndAverage,
    SpecialChartVCChartTypeMixed,
    SpecialChartVCChartTypeNightingaleRoseChart,
    SpecialChartVCChartTypeBoxplot,
    SpecialChartVCChartTypeWaterfall,
    SpecialChartVCChartTypePyramid,
    SpecialChartVCChartTypeFunnel,
};

static NSString * const kChart_Title = @"kChart_Title";
static NSString * const kChart_Value = @"kChart_Value";
static NSString * const kChart_Sliced = @"kChart_Sliced";
static NSString * const kChart_Selected = @"kChart_Selected";

static NSString * const kChart_ValueSD = @"kChart_ValueStandard";

static NSString * const kChart_X = @"kChart_X";

//pie专用
static NSString * const kPie_Title = @"name";
static NSString * const kPie_Value = @"y";
static NSString * const kPie_Sliced = @"sliced";
static NSString * const kPie_Selected = @"selected";

@interface BN_ReportView : UIView

//@property (nonatomic, assign) SpecialChartVCChartType chartType;
@property (nonatomic, strong) AAChartType chartType;

@property (nonatomic, strong) NSArray * heightList;

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic, strong) NSArray * colorList;

@property (nonatomic, strong) BN_ExcelView * excelView;

- (void)configureTheChartView:(AAChartType)chartType;
- (void)updateChartViewWidth:(CGFloat)width;

- (void)reloadChartView;
- (void)drawChartView;


@end
