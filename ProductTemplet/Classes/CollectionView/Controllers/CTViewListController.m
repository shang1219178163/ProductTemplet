//
//  ListViewController.m
//  NNCollectionView
//
//  Created by hsf on 2018/5/24.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CTViewListController.h"

#import "UICTReusableViewZero.h"

#import "UICTViewCellZero.h"
#import "UICTViewLayoutZero.h"
#import "UICTViewLayoutOne.h"

@interface CTViewListController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *ctView;
@property (nonatomic, strong) NSDictionary *dictClass;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation CTViewListController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    //    self.navigationController.navigationBarHidden = YES;
    
    self.title = @"list";
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.dictClass = @{
                       UICollectionElementKindSectionItem:   @[
                               @"UICTViewCellZero"
                               ],
                       UICollectionElementKindSectionHeader:   @[
                               @"UICTReusableViewZero",
                               ],
                       UICollectionElementKindSectionFooter:   @[
                               @"UICTReusableViewZero",
                               ],
                       
                       };
    
    self.dataList = @[
                      @{
                          kItemHeader:   @"header不同布局",
                          kItemFooter:   @"footer不同布局",
                          kItemObj:   @[
                                  @"CircleViewController",@"SphereViewController",@"PickerViewController",
                                  @"RightViewController",@"CardViewController",@"CardLineViewController"
                                  ],
                          },
                      @{
                          kItemHeader:   @"header功能测试",
                          kItemFooter:   @"footer功能测试",
                          kItemObj:   @[
                                  @"RightViewController",@"TmpViewController",@"NNShareViewController",
                                  @"MainViewController",
                                  ],
                          },
                      @{
                          kItemHeader:   @"header其他",
                          kItemFooter:   @"footer其他",
                          kItemObj:   @[
                                  @"ListViewController",@"GroupViewController",@"",
                                  ],
                          },
                      
                      ].mutableCopy;
    
    
    //新布局
    UICTViewLayoutZero * layoutZero = [[UICTViewLayoutZero alloc]init];
    layoutZero.itemSize = CGSizeMake((CGRectGetWidth(self.ctView.bounds) - 10*2 - 10)/2.0, 80);
    self.ctView.collectionViewLayout = layoutZero;
    
    //新布局
    //    UICTViewLayoutOne * layoutOne = [[UICTViewLayoutOne alloc]init];
    //    layoutOne.itemSize = CGSizeMake((CGRectGetWidth(self.ctView.bounds) - 10)/2.0, 80);
    //    layoutOne.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    //    layoutOne.minimumLineSpacing = 15;
    //    layoutOne.minimumInteritemSpacing = 10;
    //    layoutOne.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 50);
    //    layoutOne.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 15);
    //    self.ctView.collectionViewLayout = layoutOne;
    
    self.ctView.dictClass = self.dictClass;
    self.ctView.delegate = self;
    self.ctView.dataSource = self;
    
    [self.view addSubview:self.ctView];
    
    [self.ctView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DDLog(@"%@",self.navigationController.viewControllers);
    DDLog(@"%@",NSStringFromClass([[self.navigationController.viewControllers firstObject] class]));
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    DDLog(@"self.view.bounds_%@",@(self.view.bounds));
    //调整布局
    self.ctView.frame = CGRectMake(0, 10, kScreenWidth - 10*2, CGRectGetHeight(self.view.bounds) - 20);
    self.ctView.frame = self.view.bounds;
    
}

- (void)handleActionBtn:(UIBarButtonItem *)sender{
    
    DDLog(@"%@",@(sender.tag));
    if (sender.tag == 0) {
        UIViewController *vc = [[NSClassFromString(@"FileParseController") alloc]init];
        vc.title = @"文件解析";
        [self.navigationController pushViewController:vc animated:true];
        return;
    }
    
    UIViewController *vc = [[NSClassFromString(@"NNExcelController") alloc]init];
    vc.title = @"NNExcelController";
    [self.navigationController pushViewController:vc animated:true];
}

- (NSString *)itemAtSection:(NSIndexPath *)indexPath{
    NSArray * array = self.dataList[indexPath.section][kItemObj];
    NSString * controlleName = array[indexPath.row];
    return controlleName;
}

#pragma mark - -UICollectionView
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataList.count;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray * array = self.dataList[section][kItemObj];
    return array.count;
    
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeMake((CGRectGetWidth(self.ctView.bounds) - 10)/2.0, 50);
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
    NSString * controlleName = [self itemAtSection:indexPath];
    
    NSString * name = controlleName;
    if (controlleName.length > 8) {
        name = [controlleName substringToIndex:8];

    }
    
    UICTViewCellZero * cell = [UICTViewCellZero dequeueReusableCell:collectionView indexPath:indexPath];
    cell.label.text =  [NSStringFromIndexPath(indexPath) stringByAppendingString:name];
    cell.label.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICTViewCellZero *cell = (UICTViewCellZero *)[collectionView cellForItemAtIndexPath:indexPath];
//    NSString *msg = cell.label.text;
    //    DDLog(@"%@",msg);
    
    DDLog(@"%@", NSStringFromIndexPath(indexPath));
    NSString *vcName = [self itemAtSection:indexPath];
    UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
    vc.title = vcName;
    [self.navigationController pushViewController:vc animated:true];
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
    UICTReusableViewZero * view = [UICTReusableViewZero dequeueSupplementaryView:collectionView indexPath:indexPath kind:kind];

    view.imgView.image = [UIImage imageNamed:@"bug"];
    
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
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UICollectionView *)ctView{
    if (!_ctView) {
        _ctView = ({
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:self.view.bounds
                                                       collectionViewLayout:UICollectionView.layoutDefault];
            view.backgroundColor = UIColor.whiteColor;
            view.showsVerticalScrollIndicator = false;
            view.showsHorizontalScrollIndicator = false;
            view.scrollsToTop = false;
            view.pagingEnabled = true;
            [view registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];

            view;
        });
    }
    return _ctView;
}

@end
