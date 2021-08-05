//
//  NNPageScrollViewController.m
//  PageScrollow
//
//  Created by bjovov on 2017/11/8.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "NNPageScrollViewController.h"
#import "UICTViewLayoutPage.h"
#import "UICTViewCellPage.h"
#import "NNPageInfoModel.h"

@interface NNPageScrollViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *ctView;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation NNPageScrollViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"page";
    [self.view addSubview:self.ctView];
    [self.view addSubview:self.pageControl];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NNPageInfoModel *model = self.list[indexPath.item];
    UICTViewCellPage *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICTViewCellPage" forIndexPath:indexPath];
    
    cell.logoImageView.image = [UIImage imageNamed:model.imageName];
    cell.tipLabel.text = model.tip;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger curentIndex =  floor(self.ctView.contentOffset.x / CGRectGetWidth(self.view.bounds));
    self.pageControl.currentPage = curentIndex;
}

#pragma mark - Setter && Getter
- (UICollectionView *)ctView{
    if (!_ctView) {
        CGFloat width = CGRectGetWidth(self.view.bounds);
        UICTViewLayoutPage *layout = [[UICTViewLayoutPage alloc]init];
        layout.itemSize = CGSizeMake((width - 4*3)/4.0, 100);
        layout.numberOfItemsInPage = 8;
        layout.columnsInPage = 4;
        layout.minimumInteritemSpacing = 4;
        layout.minimumLineSpacing = 4;
        
        _ctView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 200 + 4) collectionViewLayout:layout];
        _ctView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_ctView registerClass:[UICTViewCellPage class] forCellWithReuseIdentifier:@"UICTViewCellPage"];
        _ctView.dataSource = self;
        _ctView.delegate = self;
        _ctView.showsHorizontalScrollIndicator = NO;
        _ctView.pagingEnabled = YES;
    }
    return _ctView;
}

- (NSMutableArray *)list{
    if (!_list) {
        _list = [[NSMutableArray alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pageScrollView" ofType:@"plist"];
        NSArray *tmpArray = [NSArray arrayWithContentsOfFile:path];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            NNPageInfoModel *model = [[NNPageInfoModel alloc] initWithDictionary:dict];
            [_list addObject:model];
        }];
    }
    return _list;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.ctView.frame), CGRectGetWidth(self.view.bounds), 25)];
        _pageControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.numberOfPages = ceil(self.list.count / 8.0);
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

@end

