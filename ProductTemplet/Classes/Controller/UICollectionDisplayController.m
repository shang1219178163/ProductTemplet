//
//  UICollectionDisplayController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/16.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UICollectionDisplayController.h"

@interface UICollectionDisplayController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@end

@implementation UICollectionDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Main";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.dictClass = @{
                                      
                                      UICollectionElementKindSectionItem:   @[
                                                                                  @"UICTViewCellOne"
                                                                                  ],
                                       UICollectionElementKindSectionHeader:   @[
                                                                                 @"UICTReusableViewZero",
                                                                                 ],
                                       UICollectionElementKindSectionFooter:   @[
                                                                                 @"UICTReusableViewZero",
                                                                                 ],

                                      };
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - -UICollectionView
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

////设置每个item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(90, 110);
//}
////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 30;
//}
////设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICTViewCellOne *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICTViewCellOne" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.label.text = NSStringFromIndexPath(indexPath);
    
//    [cell getViewLayer]
    return cell;
}


//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICTViewCellOne *cell = (UICTViewCellOne *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",cell.label.text);
}

////header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(10, 50);
//}
//
////footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(10, 30);
//}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICTReusableViewZero *view = [UICTReusableViewZero viewWithCollectionView:collectionView indexPath:indexPath kind:kind];
    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? @"headerView": @"footerView";
    view.label.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? [UIColor greenColor] : [UIColor yellowColor];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < 0) {
        
    }
}

#pragma mark -funtions


@end

