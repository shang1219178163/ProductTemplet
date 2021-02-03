//
//  NNCellDefaultView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
 
/**
图片+文字+文字+图片
*/
@interface NNCellDefaultView : UIView

@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UIImageView * imgViewRight;
@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelRight;
///0 labelRight右对齐;1 左对齐
@property (nonatomic, strong) NSNumber * type;

@end

NS_ASSUME_NONNULL_END
