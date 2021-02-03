//
//  NNDateRangeView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NNDatePicker.h"
 
@interface NNDateRangeView : UIView

@property (nonatomic, copy) NSString *dateStart;
@property (nonatomic, copy) NSString *dateEnd;
@property (nonatomic, strong) NNDatePicker * datePicker;
@property (nonatomic, strong) NNDatePicker * datePickerEnd;

@property (nonatomic, strong, readonly) UILabel * labelLeft;
@property (nonatomic, strong) void(^block)(NNDateRangeView *view);

@end

