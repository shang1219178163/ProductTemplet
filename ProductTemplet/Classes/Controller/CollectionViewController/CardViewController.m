
//
//  CardViewController.m
//  BN_CollectionView
//
//  Created by hsf on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CardViewController.h"


#import "UICTViewCellOne.h"
#import "UICTViewLayoutFive.h"

@interface CardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@end

@implementation CardViewController

-(NSDictionary *)dictClass{
    
    if (!_dictClass) {
        _dictClass = @{
                       
                       UICollectionElementKindSectionItem:   @[
                               @"UICTViewCellOne"
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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //    self.navigationController.navigationBarHidden = YES;
    
    self.title = @"关卡";
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithTitle:@"Excel" style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBtn:)];
    self.navigationItem.rightBarButtonItem = bar;
    
    DDLog(@"self.view.bounds_%@",@(self.view.bounds));
    
    self.dataList = @[
                      @"LY(二元),2",@"YL(大长),1",@"C(长白),1",@"D(杜洛克),1",@"D(大白),1",@"L(长白),1",@"D(大约克),1",
                      ].mutableCopy;
    
    //新布局
    UICTViewLayoutFive * layoutZero = [[UICTViewLayoutFive alloc]init];
    self.collectionView.collectionViewLayout = layoutZero;
    
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
    
    
}
#pragma mark - -UICollectionView
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICTViewCellOne * cell = [UICTViewCellOne viewWithCollectionView:collectionView indexPath:indexPath];
    cell.label.text = NSStringFromIndexPath(indexPath);
    
    cell.backgroundColor = [UIColor cyanColor];
    
    [cell getViewLayer];
    return cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DDLog(@"%@",indexPath);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
