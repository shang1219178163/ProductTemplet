//
//  BNListChooseView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BNPickerListView.h"

@interface BNListChooseView : UIView

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) BN_TextField * textField;

@property (nonatomic, strong) BNPickerListView * pickerView;

@end


