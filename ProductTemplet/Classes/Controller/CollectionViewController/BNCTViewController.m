//
//  MainViewController.m
//  UIExcelView
//
//  Created by hsf on 2018/4/10.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNCTViewController.h"

#import "UICTViewCellOne.h"
#import "UICTReusableViewZero.h"

#import "UICTViewLayoutCircle.h"

#import "UICTViewCellOne.h"

@interface BNCTViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@end

@implementation BNCTViewController

-(NSDictionary *)dictClass{
    
    if (!_dictClass) {
        _dictClass = @{
                       
                       UICollectionElementKindSectionItem:   @[
                                                                   @"UICTViewCellOne"
                                                                   ],
//                       UICollectionElementKindSectionHeader:   @[
//                                                                 @"UICTReusableViewZero",
//                                                                 ],
//                       UICollectionElementKindSectionFooter:   @[
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
            UICTViewLayoutCircle * layout = [[UICTViewLayoutCircle alloc]init];
            
            //item水平间距
//            layout.minimumLineSpacing = 10;
//            //item垂直间距
//            layout.minimumInteritemSpacing = 10;
//            //item的尺寸
//            layout.itemSize = CGSizeMake(90, 100);
//            //item的UIEdgeInsets
//            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            //滑动方向,默认垂直
//            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            //sectionView 尺寸
//            layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 40);
//            layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 20);
            
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
    // Do any additional setup after loading the view.
    self.title = @"Main";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithTitle:@"list" style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBtn:)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    UIBarButtonItem * barOne = [[UIBarButtonItem alloc]initWithTitle:@"Left" style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBtn:)];
    self.navigationItem.leftBarButtonItem = barOne;

    [self.view addSubview:self.collectionView];    

}

- (void)handleActionBtn:(UIBarButtonItem *)sender{
    DDLog(@"%@",sender.title);
    
    NSDictionary * dict = @{
                            @"Left" : @"LeftViewController",
                            @"list" : @"ListViewController",
                            };
    
    for (NSString * key in dict) {
        if ([sender.title isEqualToString:key]) {
            UIViewController * controller = [NSClassFromString(dict[key]) new];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICTReusableViewZero * view = [UICTReusableViewZero viewWithCollectionView:collectionView indexPath:indexPath kind:kind];
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

#pragma mark - -funtions



@end

