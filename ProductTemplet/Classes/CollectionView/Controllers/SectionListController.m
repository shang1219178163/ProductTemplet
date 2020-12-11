//
//  SectionListController.m
//  NNCollectionView
//
//  Created by hsf on 2018/4/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "SectionListController.h"

#import "UICTReusableViewZero.h"

#import "UICTViewCellTwo.h"
#import "UICTViewLayoutZero.h"
#import "UICTViewLayoutOne.h"

@interface SectionListController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@end

@implementation SectionListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;

//    self.navigationController.navigationBarHidden = YES;
    
    self.title = @"SectionList(自定义layout)";
    self.view.backgroundColor = [UIColor orangeColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Left" style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBtn:)];
    
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithTitle:@"Excel" style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBtn:)];
    self.navigationItem.rightBarButtonItem = bar;
    
    DDLog(@"self.view.bounds_%@",@(self.view.bounds));
    
    self.dataList = @[
                      @[@"公猪",@[@"D(杜洛克),2",@"L(长白),1",@"C(长),1",]],
                      @[@"母猪",@[@"LY(二元),2",@"YL(大长),1",@"C(长白),1",@"D(杜洛克),1",@"D(大白),1",@"L(长白),1",@"D(大约克),1",]],
                      @[@"其他",@[@"LY(000),2",@"LY(111),2",@"LY(2222),2",]],
                      @[@"其他",@[@"LY(111111),2",@"LY(111),2",@"LY(2222),2",]],
                      @[@"其他",@[@"LY(222222),2",@"LY(111),2",@"LY(2222),2",]],
                      @[@"其他",@[@"LY(333333),2",@"LY(111),2",@"LY(2222),2",]],
                      ].mutableCopy;

    //新布局
    UICTViewLayoutZero * layoutZero = [[UICTViewLayoutZero alloc]init];
    layoutZero.itemSize = CGSizeMake((CGRectGetWidth(self.collectionView.bounds) - 10*2 - 10)/2.0, 80);
    self.collectionView.collectionViewLayout = layoutZero;
    
    //新布局
//    UICTViewLayoutOne * layoutOne = [[UICTViewLayoutOne alloc]init];
//    layoutOne.itemSize = CGSizeMake((CGRectGetWidth(self.collectionView.bounds) - 10)/2.0, 80);
//    layoutOne.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
//    layoutOne.minimumLineSpacing = 15;
//    layoutOne.minimumInteritemSpacing = 10;
//    layoutOne.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 50);
//    layoutOne.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 15);
//    self.collectionView.collectionViewLayout = layoutOne;
    
    self.collectionView.dictClass = self.dictClass;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    DDLog(@"self.view.bounds_%@",@(self.view.bounds));
    //调整布局
    self.collectionView.frame = CGRectMake(0, 10, kScreenWidth - 10*2, CGRectGetHeight(self.view.bounds) - 20);
    self.collectionView.frame = self.view.bounds;

}

- (void)handleActionBtn:(UIBarButtonItem *)sender{
    if ([sender.title isEqualToString:@"Excel"]) {
        [self.navigationController pushVC:@"BNExcelController" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
            
        }];
    }else{
        [self.navigationController pushVC:@"NNShareViewController" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
            
        }];
    }
    
}
#pragma mark - -UICollectionView
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataList.count;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray * array = self.dataList[section];
    NSArray * arraySub = [array lastObject];
//    DDLog(@"%@",arraySub);
    return arraySub.count;
    
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeMake((CGRectGetWidth(self.collectionView.bounds) - 10)/2.0, 35);
    return itemSize;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
    return UIEdgeInsetsMake(10, 10, 10, 10);

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICTViewCellTwo * cell = [UICTViewCellTwo viewWithCollectionView:collectionView indexPath:indexPath];
    cell.label.text = NSStringFromIndexPath(indexPath);
    cell.labelSub.text = [NSString stringWithFormat:@"%@,%@",NSStringFromIndexPath(indexPath),@"sub"];
    cell.label.textAlignment = NSTextAlignmentLeft;
    cell.labelSub.textAlignment = NSTextAlignmentRight;
    
    cell.backgroundColor = [UIColor cyanColor];

    [cell getViewLayer];
    return cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICTViewCellTwo *cell = (UICTViewCellTwo *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *msg = cell.label.text;
    //    DDLog(@"%@",msg);
    
    DDLog(@"%@",indexPath);
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(100, 50);
}

//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(100, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICTReusableViewZero * view = [UICTReusableViewZero viewWithCollectionView:collectionView indexPath:indexPath kind:kind];
    NSString * titleHeader = [NSString stringWithFormat:@"HeaderView_%@",@(indexPath.section)];
    NSString * titleFooter = [NSString stringWithFormat:@"FooterView_%@",@(indexPath.section)];
    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? titleHeader: titleFooter;
    view.label.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? [UIColor greenColor] : [UIColor yellowColor];
    return view;
    
}

#pragma mark - JHCollectionViewDelegateFlowLayout
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section{
    return section % 2 == 1 ? [UIColor redColor] : [UIColor blueColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -lazy
-(NSDictionary *)dictClass{
    if (!_dictClass) {
        _dictClass = @{
                       
                       UICollectionElementKindSectionItem:   @[
                               @"UICTViewCellTwo"
                               ],
                       UICollectionElementKindSectionHeader:   @[
                               @"UICTReusableViewZero",
                               ],
                       UICollectionElementKindSectionFooter:   @[
                               @"UICTReusableViewZero",
                               ],
                       
                       };
        
    }
    return _dictClass;
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
            //默认布局
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            
            //item水平间距
            layout.minimumLineSpacing = 10;
            //item垂直间距
            layout.minimumInteritemSpacing = 10;
            //item的尺寸
            layout.itemSize = CGSizeMake(90, 100);
            //item的UIEdgeInsets
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            //滑动方向,默认垂直
            //            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            //sectionView 尺寸
            layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 40);
            layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 20);
            
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

@end
