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

@interface ScrollHorizontalController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *ctView;
@property(nonatomic, strong) NSMutableArray *list;

@property(nonatomic, strong) NNScrollView *scrollView;
@property(nonatomic, strong) NNScrollView *scrollViewOne;

@end

@implementation ScrollHorizontalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.list = @[@"", @"", @""].mutableCopy;
    
    [self.view addSubview:self.ctView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.scrollViewOne];

    self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.ctView.frame) + 10, kScreenWidth, 40);
    [self.scrollView.collectionView reloadData];
    
    self.scrollViewOne.frame = CGRectMake(20, CGRectGetMaxY(self.scrollView.frame) + 10, 60, kScreenWidth);
    [self.scrollViewOne.collectionView reloadData];
    
//    [self.view getViewLayer];
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
    UICollectionViewCell *cell = [UICollectionViewCell viewWithCollectionView:collectionView indexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

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

- (NNScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            NNScrollView *view = [[NNScrollView alloc]initWithFrame:CGRectZero];
            view.list = @[@"1", @"2", @"3", @"4", @"5", @"6",].mutableCopy;
//            view.indicatorType = 2;
            
            [view.collectionView registerClass:UICTViewCellOne.class forCellWithReuseIdentifier:@"UICTViewCellOne"];
            [view.collectionView registerClass:UICTViewCellTen.class forCellWithReuseIdentifier:@"UICTViewCellTen"];

            view.blockCellForItem = ^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
//                UICollectionViewCell *cell = [UICollectionViewCell viewWithCollectionView:collectionView indexPath:indexPath];
                UICTViewCellOne *cell = [UICTViewCellOne viewWithCollectionView:collectionView indexPath:indexPath];
//                UICTViewCellTen *cell = [UICTViewCellTen viewWithCollectionView:collectionView indexPath:indexPath];

                cell.label.text = [NSString stringWithFormat:@"标题%@", @(indexPath.row)];
                cell.imgView.image = [UIImage imageNamed:@"bug.png"];
                cell.contentView.backgroundColor = UIColor.randomColor;
                
                cell.label.hidden = true;
//                cell.imgView.hidden = true;

                [cell.contentView getViewLayer];
                return cell;
            };
            
            view.blockDidSelectItem = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
//                DDLog(@"%@", @(indexPath.row));

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
//                UICollectionViewCell *cell = [UICollectionViewCell viewWithCollectionView:collectionView indexPath:indexPath];
//                cell.contentView.backgroundColor = UIColor.randomColor;
                UICTViewCellOne *cell = [UICTViewCellOne viewWithCollectionView:collectionView indexPath:indexPath];
//                UICTViewCellTen *cell = [UICTViewCellTen viewWithCollectionView:collectionView indexPath:indexPath];

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

@end
