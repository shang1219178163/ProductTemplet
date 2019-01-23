//
//  UITableViewSenventySevenCell.h
//  
//
//  Created by BIN on 2018/4/28.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BN_AddPictureView.h"

/**
 文字
 +图片选择器
 */
@interface UITableViewSenventySevenCell : UITableViewCell

@property (nonatomic, strong) BN_AddPictureView * pictureView;

@end
