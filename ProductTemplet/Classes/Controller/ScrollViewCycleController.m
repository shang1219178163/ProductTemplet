//
//  ScrollViewCycleController.m
//  CollectionViewDemo1
//
//  Created by IOS.Mac on 16/10/27.
//  Copyright © 2019年 com.elepphant.pingchuan. All rights reserved.
//

//使用CollectionView实现横向滚动

#import "ScrollViewCycleController.h"
#import "UICTViewCellCycle.h"

@interface ScrollViewCycleController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray *dataList;

@property(nonatomic, strong) NSTimer *timer;

@end

@implementation ScrollViewCycleController

- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview: self.collectionView];

    self.dataList = @[@"one", @"two", @"three", @"four", @"five"].mutableCopy;
    
    [NSRunLoop.mainRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll{
    if (0 == self.dataList.count) return;

    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    int index = 0;
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_collectionView.contentOffset.x + flowLayout.itemSize.width * 0.5) / flowLayout.itemSize.width;
    } else {
        index = (_collectionView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height;
    }
    
    NSLog(@"%@_%@", @(index), @(MAX(0, index)));
    int targetIndex = index + 1;

    if (targetIndex >= self.dataList.count) {
        targetIndex = 0;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:false];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:true];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     UICTViewCellCycle * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICTViewCellCycle.class) forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:@"postImage"];
    cell.label.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    
    return cell;
}

#pragma mark  -UIScrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%.2f,%.2f,%.2f",scrollView.contentOffset.x, CGRectGetWidth(scrollView.frame),scrollView.contentSize.width);
//
//    CGFloat width = CGRectGetWidth(scrollView.frame);
//    if (scrollView.contentOffset.x > (scrollView.contentSize.width - width)) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
//    else if (scrollView.contentOffset.x < 0) {
//        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - width,0);
//
//    }
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%.2f,%.2f,%.2f",scrollView.contentOffset.x, CGRectGetWidth(scrollView.frame),scrollView.contentSize.width);
//
//    CGFloat width = CGRectGetWidth(scrollView.frame);
//    if (scrollView.contentOffset.x > (scrollView.contentSize.width - width)) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
//    else if (scrollView.contentOffset.x < 0) {
//        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - width,0);
//
//    }
//}

#pragma mark - -lazy
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
            UICollectionViewFlowLayout *layout = ({
                UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
                layout.itemSize = CGSizeMake(130, 130);
                layout.itemSize = CGSizeMake(kScreenWidth, 130);
                
                layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                layout.minimumLineSpacing = 0;
                layout;
            });
            
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 244, kScreenWidth,130) collectionViewLayout:layout];
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.scrollsToTop = false;
            collectionView.showsVerticalScrollIndicator = false;
            collectionView.showsHorizontalScrollIndicator = false;
            [collectionView registerClass:UICTViewCellCycle.class forCellWithReuseIdentifier:NSStringFromClass(UICTViewCellCycle.class)];
            collectionView.pagingEnabled = true;

            collectionView;
        });
    }
    return _collectionView;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(automaticScroll) userInfo:nil repeats:true];

    }
    return _timer;
}

@end
