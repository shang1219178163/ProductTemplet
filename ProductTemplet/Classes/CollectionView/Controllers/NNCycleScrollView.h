//
//  NNCycleScrollView.h
//  NNCycleScrollView
//
//  Created by Bin Shang on 2019/8/24.
//  Copyright © 2019 BN. All rights reserved.
//

/*
 1.方案一
 N张照片把contentsSize设置为N+2个图片的宽度，例子如下，两端填充如图，当处于一端时，且即将进入循环状态的时候，如第二张图，从状态1滑动到状态2，在滑动结束的时候，将当前的位置直接转到状态3，直接setContentOffset神不知鬼不觉，视觉上是循环的。
[ABCD] - 图片数组
[D A B C D A] - UICollectionView数据源
 2 1     3
 
 */

#import <UIKit/UIKit.h>

@protocol NNCycleScrollViewDelegate <NSObject>
- (void)didSelectedIndex:(NSInteger)index;

@end

@interface NNCycleScrollView : UIView

@property (nonatomic, weak) id<NNCycleScrollViewDelegate> delegate;
/// 滚动方向，默认是横向滚动
@property (nonatomic, assign) UICollectionViewScrollDirection direction;
/// 是否无限循环，默认是YES
@property (nonatomic, assign) BOOL isinFiniteLoop;
/// 是否自动滚动，默认是YES
@property (nonatomic, assign) BOOL isAutoScroll;
/// 点击代码块回调
@property (nonatomic, copy) void(^blockDidSelectedIndex)(NSInteger index);

/**为图片数组赋值*/
- (void)setImageArray:(NSArray *)imageArray;


@end
