//
//  PickerViewController.m
//  BN_CollectionView
//
//  Created by hsf on 2018/4/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "PickerViewController.h"

#import "UICTViewLayoutPicker.h"
#import "UICTViewCellOne.h"

@interface PickerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@end

@implementation PickerViewController

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
            //            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            UICTViewLayoutPicker * layout = [[UICTViewLayoutPicker alloc]init];
            
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.scrollsToTop = NO;
            collectionView.showsVerticalScrollIndicator = NO;
            collectionView.showsHorizontalScrollIndicator = NO;
            
            collectionView.dictClass = self.dictClass;
            
            collectionView;
        });
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"picker";
    self.edgesForExtendedLayout = NO;
    
    self.collectionView.frame = CGRectMake(10, 10, kScreenWidth - 20, kScreenWidth - 20);
    self.collectionView.contentOffset = CGPointMake(0, CGRectGetHeight(self.collectionView.frame));
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor cyanColor];
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
//    UICTReusableViewZero * view = [UICTReusableViewZero viewWithCollectionView:collectionView indexPath:indexPath kind:kind];
//    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? @"headerView": @"footerView";
//    view.label.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? [UIColor greenColor] : [UIColor yellowColor];
//    return view;
//
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    CGFloat width = CGRectGetWidth(self.collectionView.frame);
//    CGFloat height = CGRectGetHeight(self.collectionView.frame);
//    if (scrollView.contentOffset.y < 200) {
//        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y+10 * height);
//
//    }
//    else if(scrollView.contentOffset.y > 11*height){
//        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y-10 * height);
//
//    }
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat height = CGRectGetHeight(self.collectionView.frame);

    if (scrollView.contentOffset.y<200) {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y+count*height);
    }else if(scrollView.contentOffset.y>(count+1)*height){
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y-count*height);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
