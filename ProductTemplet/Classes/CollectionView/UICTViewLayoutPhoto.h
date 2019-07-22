//
//  UICTViewLayoutPhoto.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/7/22.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICTViewLayoutPhoto : UICollectionViewLayout

//item尺寸
@property(nonatomic, assign) CGSize itemSize;
//内边距
@property(nonatomic, assign) UIEdgeInsets sectionInset;

@end

NS_ASSUME_NONNULL_END
