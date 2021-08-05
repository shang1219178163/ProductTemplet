//
//  UITableViewSheetCell.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNSheetView.h"


NS_ASSUME_NONNULL_BEGIN

@interface UITableViewSheetCell : UITableViewCell

@property (nonatomic, assign) BOOL hasAsterisk;

@property (nonatomic, strong) NNSheetView * sheetView;

@end

NS_ASSUME_NONNULL_END
