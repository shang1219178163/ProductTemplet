//
//  UITableViewEightyOneCell.h
//  
//
//  Created by BIN on 2018/5/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"

/**
 icon+数量 | icon+数量 | icon+数量
 */
@interface UITableViewEightyOneCell : UITableViewCell

@property (nonatomic, strong) NSArray *itemManger;

@property (nonatomic, copy) void(^block)(UITableViewEightyOneCell * view, UIImageView * obj, UILabel * item, NSInteger idx);

@end
