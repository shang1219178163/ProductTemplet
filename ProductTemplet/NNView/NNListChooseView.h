//
//  NNListChooseView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <NNGloble/NNGloble.h>
#import "NNPickerListView.h"

@interface NNListChooseView : UIView

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) NNTextField * textField;

@property (nonatomic, strong) NNPickerListView * pickerView;

@end


