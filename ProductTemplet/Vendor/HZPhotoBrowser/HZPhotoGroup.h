//
//  HZPhotoGroup.h
//  HZPhotoBrowser
//
//  Created by aier on 15-2-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HZPhotoItem.h"

@interface HZPhotoGroup : UIView 

@property (nonatomic, strong) NSArray *photoItemArray;
@property (nonatomic, assign) CGSize photoItemSize;

@end
