//
//  UITableViewSliderCell.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+Helper.h"
#import "NNSliderView.h"

@interface UITableViewSliderCell : UITableViewCell

@property (nonatomic, assign) BOOL hasAsterisk;

@property (nonatomic, strong) NNSliderView * sliderView;


@end


