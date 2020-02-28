//
//  NNCycleScrollView.m
//  NNCycleScrollView
//
//  Created by Bin Shang on 2019/8/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNCycleScrollView.h"
#import "UICTViewCellOne.h"

@interface NNCycleScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UICollectionView *ctView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
/**网络图片地址数组 或 本地图片数组*/
@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation NNCycleScrollView

- (void)dealloc{
    _ctView.delegate = nil;
    _ctView = nil;
    
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.ctView];
        [self addSubview:self.pageControl];
        self.isinFiniteLoop = YES;
        self.isAutoScroll = YES;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
 
    self.flowLayout.itemSize = self.bounds.size;
    [self.ctView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self);
        make.height.equalTo(30);
    }];
    
    //重置起始位置
    [self setImageArray:_imageArray];

}

- (void)initTimer{
    [self invalidateTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - Setter Menthod
- (void)setDirection:(UICollectionViewScrollDirection)direction{
    _flowLayout.scrollDirection = direction;
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll{
    _isAutoScroll = isAutoScroll;
    [self invalidateTimer];
    if (_isAutoScroll) {
        [self initTimer];
    }
}

- (void)setImageArray:(NSArray *)imageArray{
    if (!imageArray || imageArray.count == 0) {
        return;
    }
    _imageArray = imageArray;
    _pageControl.numberOfPages = _imageArray.count;
    if (!_pageControl.isHidden) {
        _pageControl.hidden = _imageArray.count <= 1;
    }
    if (_imageArray.count > 1) {
        _ctView.scrollEnabled = YES;
        [self setIsAutoScroll:_isAutoScroll];
    }else{
        _ctView.scrollEnabled = NO;
        [self setIsAutoScroll:NO];
    }
    [_ctView reloadData];
    
    if (_isinFiniteLoop && _imageArray.count > 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
       [_ctView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - Private Menthod
- (void)automaticScroll{
    if (_imageArray.count == 0 || _imageArray.count == 1) return;
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:targetIndex inSection:0];
    [_ctView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (int)currentIndex{
    if (_ctView.bounds.size.width == 0 || _ctView.bounds.size.height == 0) {
        return 0;
    }
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_ctView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_ctView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    return MAX(0, index);
}

/**根据当前cell的indexPath，获取当前cell数据源的索引*/
- (NSInteger)dataSourceIndexForCurrentIndex:(NSInteger)index{
    NSInteger dataIndex = 0;
    if (self.isinFiniteLoop && self.imageArray.count > 1) {
        if (index == 0) {
            dataIndex = self.imageArray.count - 1;
        } else if (index == self.imageArray.count + 1){
            dataIndex = 0;
        } else {
            dataIndex = index - 1;
        }
    } else {
        dataIndex = index;
    }
    return dataIndex;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    /**只有是无限循环和数组个数大于1时，才能无限循环*/
    if (self.isinFiniteLoop && self.imageArray.count > 1) {
        return self.imageArray.count + 2;
    } else {
        return self.imageArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellForItem:cellForItemAtIndexPath:)]) {
        return [self.delegate cellForItem:collectionView cellForItemAtIndexPath:indexPath];
    }
    
    if (self.blockCellForItem && self.blockCellForItem(collectionView, indexPath)) {
        return self.blockCellForItem(collectionView, indexPath);
    }
    
    UICTViewCellOne *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICTViewCellOne" forIndexPath:indexPath];
    cell.label.hidden = true;
    
    NSInteger currentIndex = [self dataSourceIndexForCurrentIndex:indexPath.item];
    id obj = self.imageArray[currentIndex];

    if ([obj isKindOfClass:[UIImage class]]) {
        cell.imgView.image = obj;
        
    } else if ([obj isKindOfClass:[NSString class]]){
        if ([obj hasPrefix:@"http"]) {
            [cell.imgView loadImage:obj defaultImg:@"tmp"];

        } else {
            cell.label.hidden = false;
            cell.imgView.hidden = true;
            cell.label.text = obj;
        }
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:[self dataSourceIndexForCurrentIndex:indexPath.item]];
    }
    if (self.blockDidSelectedIndex) {
        self.blockDidSelectedIndex([self dataSourceIndexForCurrentIndex:indexPath.item]);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentIndex = [self currentIndex];
    _pageControl.currentPage = [self dataSourceIndexForCurrentIndex:currentIndex];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.isAutoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isAutoScroll) {
        [self initTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger currentIndex = [self currentIndex];
    if (self.isinFiniteLoop && self.imageArray.count > 1) {
        if (currentIndex == 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.imageArray.count inSection:0];
            [_ctView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
        } else if (currentIndex == self.imageArray.count + 1){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
            [_ctView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
        }
    }
}


#pragma mark -lazy

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.itemSize = UIScreen.mainScreen.bounds.size;
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            
            layout;
        });
    }
    return _flowLayout;
}

- (UICollectionView *)ctView{
    if (!_ctView) {
        _ctView = ({
            UICollectionView * view = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
            view.backgroundColor = [UIColor grayColor];
            view.showsHorizontalScrollIndicator = NO;
            view.showsVerticalScrollIndicator = NO;
            view.pagingEnabled = YES;
            view.delegate = self;
            view.dataSource = self;
            [view registerClass:[UICTViewCellOne class] forCellWithReuseIdentifier:@"UICTViewCellOne"];
            
            view;
        });
    }
    return _ctView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = ({
            UIPageControl *view = [[UIPageControl alloc]initWithFrame:CGRectZero];
            view.currentPageIndicatorTintColor = UIColor.redColor;
            view.pageIndicatorTintColor = UIColor.grayColor;
            view;
        });
    }
    return _pageControl;
}

@end

