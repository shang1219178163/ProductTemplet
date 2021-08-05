//
//  ZYTempViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "ScrollHorizontalController.h"
#import "NNScrollView.h"
#import "UICTViewCellTen.h"
#import "CardView.h"

@interface ScrollHorizontalController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *ctView;
@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) NSMutableArray *list;

@property(nonatomic, strong) NNScrollView *scrollView;
@property(nonatomic, strong) NNScrollView *scrollViewOne;
@property(nonatomic, strong) CardView *cardView;

@property(nonatomic, strong) NSTimer *timer;

@end

@implementation ScrollHorizontalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    NNScrollView.appearance.selectedColor = UIColor.redColor;
    NNScrollView.appearance.indicatorHeight = 3;
    
    self.list = @[@"", @"", @""].mutableCopy;
    
    
    [self.view addSubview:self.ctView];
    [self.view addSubview:self.pageControl];

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.scrollViewOne];

    self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.ctView.frame) + 10, kScreenWidth, 40);
    [self.scrollView.collectionView reloadData];
    
    self.scrollViewOne.frame = CGRectMake(20, CGRectGetMaxY(self.scrollView.frame) + 10, 60, kScreenWidth);
    [self.scrollViewOne.collectionView reloadData];
    
    
    [CardView appearance].leftColor = [UIColor redColor];
    [CardView appearance].rightColor = [UIColor orangeColor];
    
//    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
//    [NSRunLoop.mainRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.cardView.frame = CGRectMake(20, 100, 200, 100);
    
//    [self.view getViewLayer];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.ctView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(kScreenWidth/kRatio_IDCard);
    }];
    
    [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ctView).offset(0);
        make.right.equalTo(self.ctView).offset(0);
        make.bottom.equalTo(self.ctView.bottom).offset(0);
        make.height.equalTo(30);
    }];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
//    if (!cell ) {
//        NSLog(@"cell为空,创建cell");
//        cell = [[UICollectionViewCell alloc] init];
//    }
    UICollectionViewCell *cell = [UICollectionViewCell dequeueReusableCell:collectionView indexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.ctView) {
        self.pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
    }
}

- (void)autoScroll{
    NSInteger currentIndex = [self currentIndex];
    NSInteger nextIndex = (currentIndex == self.list.count - 1) ? 0 : (currentIndex + 1);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:nextIndex inSection:0];
    [self.ctView scrollToItemAtIndexPath:indexPath
                        atScrollPosition:UICollectionViewScrollPositionNone
                                animated:nextIndex ? YES : NO];
}

- (NSInteger)currentIndex{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.ctView.collectionViewLayout;
    int index = 0;
    if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (self.ctView.contentOffset.x + layout.itemSize.width * 0.5) / layout.itemSize.width;
    } else {
        index = (self.ctView.contentOffset.y + layout.itemSize.height * 0.5) / layout.itemSize.height;
    }
    return MAX(0, index);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CardView * cardView = [[CardView alloc]initWithFrame:CGRectMake(20, 100, 200, 100)];
    [self.view addSubview:self.cardView];
}

#pragma mark -lazy

- (UICollectionView *)ctView{
    if (!_ctView) {
        _ctView = ({
            UICollectionViewFlowLayout *layout = ({
                UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                layout.itemSize = CGSizeMake(kScreenWidth, kScreenWidth/kRatio_IDCard);
                layout.minimumLineSpacing = 0;
                // 每一列cell之间的间距
                // flowLayout.minimumInteritemSpacing = 10;
                // 设置第一个cell和最后一个cell,与父控件之间的间距
                //    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
                
                layout;
            });
            
            CGRect rect = CGRectMake(0, 20, kScreenWidth, kScreenWidth/kRatio_IDCard);
            UICollectionView *ctView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
            ctView.backgroundColor = [UIColor redColor];
            ctView.pagingEnabled = true;
            ctView.dataSource = self;
            ctView.delegate = self;
            [ctView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
            ctView;
        });
    }
    return _ctView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = ({
            UIPageControl *view = [[UIPageControl alloc] initWithFrame:CGRectZero];
            view.numberOfPages = self.list.count;
            view.currentPage = 0;
            view.hidesForSinglePage = YES;
            view.defersCurrentPageDisplay = YES;
            view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];

            view;
        });
    }
    return _pageControl;
}

- (NNScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            NNScrollView *view = [[NNScrollView alloc]initWithFrame:CGRectZero];
            view.list = @[@"1", @"2", @"3", @"4", @"5", @"6",].mutableCopy;
            view.indicatorType = 2;
            
            [view.collectionView registerClass:UICTViewCellOne.class forCellWithReuseIdentifier:@"UICTViewCellOne"];
            [view.collectionView registerClass:UICTViewCellTen.class forCellWithReuseIdentifier:@"UICTViewCellTen"];

            @weakify(view);
            view.blockCellForItem = ^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
                @strongify(view);
//                UICollectionViewCell *cell = [UICollectionViewCell dequeueReusableCell:collectionView indexPath:indexPath];
                UICTViewCellOne *cell = [UICTViewCellOne dequeueReusableCell:collectionView indexPath:indexPath];
//                UICTViewCellTen *cell = [UICTViewCellTen dequeueReusableCell:collectionView indexPath:indexPath];
                BOOL isSame = [view.selectIndexPath compare: indexPath] == NSOrderedSame;
                cell.label.textColor = isSame == true ? view.selectedColor : UIColor.grayColor;

                cell.label.text = [NSString stringWithFormat:@"标题%@", @(indexPath.row)];
                cell.imgView.image = [UIImage imageNamed:@"bug.png"];
//                cell.contentView.backgroundColor = UIColor.randomColor;
                
//                cell.label.hidden = true;
                cell.imgView.hidden = true;
                
                DDLog(@"%@_%@_%@", NSStringFromIndexPath(view.selectIndexPath), NSStringFromIndexPath(indexPath), @(isSame));

//                [cell.contentView getViewLayer];
                return cell;
            };
            
            view.blockDidSelectItem = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
//                DDLog(@"%@", @(indexPath.row));
                [collectionView reloadData];

            };
            
            view;
        });
    }
    return _scrollView;
}

- (NNScrollView *)scrollViewOne{
    if (!_scrollViewOne) {
        _scrollViewOne = ({
            NNScrollView *view = [[NNScrollView alloc]initWithFrame:CGRectZero];
            view.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            view.indicatorType = 2;

            [view.collectionView registerClass:UICTViewCellOne.class forCellWithReuseIdentifier:@"UICTViewCellOne"];
            [view.collectionView registerClass:UICTViewCellTen.class forCellWithReuseIdentifier:@"UICTViewCellTen"];

            view.list = @[@"1", @"2", @"3", @"4", @"5", @"6",].mutableCopy;
            view.blockCellForItem = ^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
//                UICollectionViewCell *cell = [UICollectionViewCell dequeueReusableCell:collectionView indexPath:indexPath];
//                cell.contentView.backgroundColor = UIColor.randomColor;
                UICTViewCellOne *cell = [UICTViewCellOne dequeueReusableCell:collectionView indexPath:indexPath];
//                UICTViewCellTen *cell = [UICTViewCellTen dequeueReusableCell:collectionView indexPath:indexPath];

                cell.label.text = [NSString stringWithFormat:@"标题%@", @(indexPath.row)];
                cell.imgView.image = [UIImage imageNamed:@"bug.png"];
                cell.label.hidden = true;
//                cell.imgView.hidden = true;
                return cell;
            };
            
            view.blockDidSelectItem = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
                DDLog(@"%@", @(indexPath.row));

            };
            
            view;
        });
    }
    return _scrollViewOne;
}

- (CardView *)cardView{
    if (!_cardView) {
        _cardView = [[CardView alloc]initWithFrame:CGRectZero];
    }
    return _cardView;
}

@end
