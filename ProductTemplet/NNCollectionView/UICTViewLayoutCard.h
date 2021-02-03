//
//  UICTViewLayoutCard.h
//  NNCollectionView
//
//  Created by hsf on 2018/8/9.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UICTViewLayoutCard;
@protocol UICTViewLayoutCardDelegate <NSObject>
 
@optional
-(void)scrolledToTheCurrentItemAtIndex:(NSInteger)itemIndex;

@end

@interface UICTViewLayoutCard : UICollectionViewFlowLayout

@property(nonatomic, assign) CGFloat scale;
@property(nonatomic, assign) NSInteger currentItemIndex;
@property(nonatomic, assign) id<UICTViewLayoutCardDelegate> delegate;

@end
