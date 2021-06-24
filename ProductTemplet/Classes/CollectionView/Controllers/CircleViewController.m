
//
//  CircleViewController.m
//  NNCollectionView
//
//  Created by hsf on 2018/4/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CircleViewController.h"

//#import "UICTViewLayoutCircle.h"
//#import "UICTViewCellOne.h"

@interface CircleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Circle";
    
    [self.view addSubview:self.collectionView];
    
    [self.view getViewLayer];
}


#pragma mark - -UICollectionView
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
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
    UICTViewCellOne * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICTViewCellOne" forIndexPath:indexPath];
    //    cell.layer.masksToBounds = YES;
    //    cell.layer.cornerRadius = 25;
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.label.text = NSStringFromIndexPath(indexPath);
    [cell getViewLayer];
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

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICTReusableViewZero * view = [UICTReusableViewZero dequeueSupplementaryView:collectionView indexPath:indexPath kind:kind];
//    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? @"headerView": @"footerView";
//    view.label.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? [UIColor greenColor] : [UIColor yellowColor];
//    return view;
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -funtions

#pragma mark -lazy
-(NSDictionary *)dictClass{
    if (!_dictClass) {
        _dictClass = @{
                       
                       UICollectionElementKindSectionItem:   @[
                               @"UICTViewCellOne"
                               ],
                       //                       UICollectionElementKindSectionHeader:   @[
                       //                                                                 @"UICTReusableViewZero",
                       //                                                                 ],
                       //                       UICollectionElementKindSectionHeader:   @[
                       //                                                                 @"UICTReusableViewZero",
                       //                                                                 ],
                       
                       };
        
    }
    return _dictClass;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
//            UICollectionViewFlowLayout *layout = ({
//                UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//                //item水平间距
//                layout.minimumLineSpacing = 10;
//                //item垂直间距
//                layout.minimumInteritemSpacing = 10;
//                //item的尺寸
//                layout.itemSize = CGSizeMake(90, 100);
//                //item的UIEdgeInsets
//                layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//                //滑动方向,默认垂直
//                layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//                //sectionView 尺寸
//                layout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
//                layout.footerReferenceSize = CGSizeMake(kScreenWidth, 20);
//
//                layout;
//            });

            UICTViewLayoutCircle * layout = [[UICTViewLayoutCircle alloc]init];
            layout.itemSize = CGSizeMake(90, 100);
            
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
            view.backgroundColor = [UIColor whiteColor];
            view.delegate = self;
            view.dataSource = self;
            view.scrollsToTop = NO;
            view.showsVerticalScrollIndicator = true;
            view.showsHorizontalScrollIndicator = true;
            
            view.dictClass = self.dictClass;
            
            view;
        });
    }
    return _collectionView;
}

@end
