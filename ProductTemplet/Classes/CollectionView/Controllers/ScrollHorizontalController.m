//
//  ZYTempViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "ScrollHorizontalController.h"

@interface ScrollHorizontalController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ScrollHorizontalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenWidth);
        layout.minimumLineSpacing = 0;
        // 每一列cell之间的间距
        // flowLayout.minimumInteritemSpacing = 10;
        // 设置第一个cell和最后一个cell,与父控件之间的间距
        //    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
 
        layout;
    });
   
    self.collectionView = ({
        CGRect rect = CGRectMake(0, 20, kScreenWidth, kScreenWidth);
        UICollectionView *ctView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        ctView.backgroundColor = [UIColor redColor];
        ctView.dataSource = self;
        ctView.delegate = self;
        [ctView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
        ctView;
    });
    [self.view addSubview:self.collectionView];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (!cell ) {
        NSLog(@"cell为空,创建cell");
        cell = [[UICollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

@end
