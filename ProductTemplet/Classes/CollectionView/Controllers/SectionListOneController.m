
//
//  SectionListOneController.m
//  BN_CollectionView
//
//  Created by hsf on 2018/4/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "SectionListOneController.h"

#import "BNDataModel.h"

#import "UICTViewCellOne.h"
#import "UICTReusableViewZero.h"


@interface SectionListOneController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@end

@implementation SectionListOneController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
    

    
    BOOL isSection = YES;
    if (isSection) {
        for (NSInteger i = 0; i < 3; i++) {
            NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
            
            for (NSInteger j = 0; j < 7; j++) {
                BNDataModel * model = [[BNDataModel alloc]init];
                model.title = [NSString stringWithFormat:@"%@_%@",@(i),@(j)];
                model.imgName = [NSString stringWithFormat:@"%@",@(j)];
                
                [marr addObject:model];
                
            }
            [self.dataList addObject:marr];
        }
    }
    else{
        for (NSInteger j = 0; j < 7; j++) {
            BNDataModel * model = [[BNDataModel alloc]init];
            model.title = [NSString stringWithFormat:@"%@_",@(j)];
            model.imgName = [NSString stringWithFormat:@"%@",@(j)];
            
            [self.dataList addObject:model];
        }
    }
    
}

-(NSMutableArray *)arrayAtSection:(NSInteger)section{
    
    NSMutableArray * arraySection = self.dataList;
    if ([[self.dataList firstObject] isKindOfClass:[NSArray class]]) {
        arraySection = self.dataList[section];

    }
    return arraySection;
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *arraySection = [self arrayAtSection:indexPath.section];
    id obj = arraySection[indexPath.row];

    return obj;
    
}

#pragma mark - -UICollectionView
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSInteger count = [[self.dataList firstObject] isKindOfClass:[NSArray class]] ? self.dataList.count : 1;
    return count;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray *arraySection = [self arrayAtSection:section];
    return arraySection.count;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BNDataModel * model = [self itemAtIndexPath:indexPath];
    
    UICTViewCellOne * view = [UICTViewCellOne viewWithCollectionView:collectionView indexPath:indexPath];
    
    view.label.text = model.title;
//    view.label.text = NSStringFromIndexPath(indexPath);
    view.imgView.image = [UIImage imageNamed:model.imgName];
//    view.imgView.backgroundColor = [UIColor randomColor];

    view.backgroundColor = [UIColor cyanColor];
    
    [view getViewLayer];
    return view;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICTViewCellOne *cell = (UICTViewCellOne *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *msg = cell.label.text;
    NSLog(@"%@",msg);
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

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return NO;
    }
    return YES;
}

//当移动结束的时候会调用这个方法。
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {

    NSMutableArray *arraySection = [self arrayAtSection:sourceIndexPath.section];
    BNDataModel * model = [self itemAtIndexPath:sourceIndexPath];
    
    [arraySection removeObjectAtIndex:sourceIndexPath.row];
    [arraySection insertObject:model atIndex:destinationIndexPath.row];
    
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    CGPoint point = [longPress locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            
            if (!indexPath) {
                break;
            }
            
            BOOL canMove = [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            if (!canMove) {
                break;
            }
            break;
            
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:point];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
            
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -lazy
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
    
}

-(NSDictionary *)dictClass{
    if (!_dictClass) {
        _dictClass = @{
                       
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
        
    }
    return _dictClass;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
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
