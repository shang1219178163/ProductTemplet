//
//  NNScrollView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNScrollView.h"

@interface NNScrollView ()

@property(nonatomic, strong) UIView *indicatorView;
@property(nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation NNScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showItemNum = 4;
        self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self addSubview:self.collectionView];
        [self.collectionView addSubview:self.indicatorView];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    if (self.layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        self.layout.itemSize = CGSizeMake(self.bounds.size.width/self.showItemNum, self.bounds.size.height);
    } else {
        self.layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height/self.showItemNum);
    }
    
    [self setupIndicator];
    
}

#pragma mark -UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.blockCellForItem && self.blockCellForItem(collectionView, indexPath)) {
        return self.blockCellForItem(collectionView, indexPath);
    }

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
//    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isScrollHorizontal = self.layout.scrollDirection == UICollectionViewScrollDirectionHorizontal;
    UICollectionViewScrollPosition scrollPosition = isScrollHorizontal ? UICollectionViewScrollPositionCenteredHorizontally : UICollectionViewScrollPositionCenteredVertically;
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:true];

    self.selectIndexPath = indexPath;
    if (self.blockDidSelectItem != nil) {
        self.blockDidSelectItem(collectionView, indexPath);
    }
    
}

#pragma mark -funtions
- (void)setupIndicator{
    if (CGRectEqualToRect(CGRectZero, self.bounds) || self.list.count == 0) {
        return;
    }
    
    switch (self.indicatorType) {
        case 1:
        {
            [UIView animateWithDuration:0.35 animations:^{
                if (self.layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                    self.indicatorView.frame = CGRectMake(self.layout.itemSize.width * self.selectIndexPath.row,
                                                          0,
                                                          self.layout.itemSize.width,
                                                          self.indicatorView.layer.borderWidth);
                    
                } else {
                    self.indicatorView.frame = CGRectMake(0,
                                                          self.layout.itemSize.height * self.selectIndexPath.row,
                                                          self.indicatorView.layer.borderWidth,
                                                          self.layout.itemSize.height);
                }
            }];
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:0.35 animations:^{
                if (self.layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                    self.indicatorView.frame = CGRectMake(self.layout.itemSize.width * self.selectIndexPath.row,
                                                          self.layout.itemSize.height - self.indicatorView.layer.borderWidth,
                                                          self.layout.itemSize.width,
                                                          self.indicatorView.layer.borderWidth);
                    
                } else {
                    self.indicatorView.frame = CGRectMake(self.layout.itemSize.width - self.indicatorView.layer.borderWidth,
                                                          self.layout.itemSize.height * self.selectIndexPath.row,
                                                          self.indicatorView.layer.borderWidth,
                                                          self.layout.itemSize.height);
                }
            }];
        }
            break;
        case 3:
        {
            [UIView animateWithDuration:0.35 animations:^{
                if (self.layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                    self.indicatorView.frame = CGRectMake(self.layout.itemSize.width * self.selectIndexPath.row,
                                                          0,
                                                          self.layout.itemSize.width,
                                                          self.layout.itemSize.height);
                    
                } else {
                    self.indicatorView.frame = CGRectMake(0,
                                                          self.layout.itemSize.height * self.selectIndexPath.row,
                                                          self.layout.itemSize.width,
                                                          self.layout.itemSize.height);
                    
                }
            }];
        }
            break;
        default:
        {
            self.indicatorView.hidden = true;
        }
            break;
    }
}

#pragma mark -set

- (void)setSelectIndexPath:(NSIndexPath *)selectIndexPath{
    _selectIndexPath = selectIndexPath;
    [self setupIndicator];
}

- (UIColor *)selectedColor{
    return NNScrollView.appearance.selectedColor ? : [UIColor colorWithCGColor:self.indicatorView.layer.borderColor];
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    if (selectedColor) {
        self.indicatorView.layer.borderColor = selectedColor.CGColor;
    }
}

- (CGFloat)indicatorHeight{
    return NNScrollView.appearance.indicatorHeight > 0 ? NNScrollView.appearance.indicatorHeight : self.indicatorView.layer.borderWidth;
}

- (void)setIndicatorHeight:(CGFloat)indicatorHeight{
    if (indicatorHeight > 0) {
        self.indicatorView.layer.borderWidth = indicatorHeight;
    }
}

#pragma mark -lazy

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.itemSize = CGSizeMake(self.bounds.size.width, 70);
            layout.minimumLineSpacing = 0;
            // 每一列cell之间的间距
            // flowLayout.minimumInteritemSpacing = 10;
            // 设置第一个cell和最后一个cell,与父控件之间的间距
            //    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
            
            layout;
        });
    }
    return _layout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
            UICollectionView *ctView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
            ctView.backgroundColor = [UIColor whiteColor];
            ctView.showsVerticalScrollIndicator = false;
            ctView.showsHorizontalScrollIndicator = false;
            ctView.scrollsToTop = false;
            ctView.pagingEnabled = true;
            ctView.bounces = false;
            ctView.dataSource = self;
            ctView.delegate = self;
            [ctView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
            ctView;
        });
    }
    return _collectionView;
}

- (void)setList:(NSMutableArray *)list{
    _list = list;
    if (list.count >= 0 && list.count < self.showItemNum) {
        self.showItemNum = list.count;
    }
}

- (UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = ({
            UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
            view.layer.backgroundColor = UIColor.clearColor.CGColor;
            //        layer.opacity = 0;
             view.layer.borderColor = UIColor.themeColor.CGColor;
             view.layer.borderWidth = 2;
            
            view;
        });
    }
    return _indicatorView;
}



@end



