//
//  UICTViewLayoutPage.h
//  PageScrollow
//
//  Created by bjovov on 2017/11/8.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICTViewLayoutPage : UICollectionViewFlowLayout
/*每页缩进*/
@property (nonatomic,assign) UIEdgeInsets pageInset;
/*每页iterm的个数*/
@property (nonatomic,assign) NSUInteger numberOfItemsInPage;
/*每页有多少列*/
@property (nonatomic,assign) NSUInteger columnsInPage;

@end
