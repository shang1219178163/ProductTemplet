//
//  BN_ShareView.m
//  BINAlertView
//
//  Created by hsf on 2018/5/18.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_ShareView.h"

#import "UICollectionView+Helper.h"

#import "BN_CTReusableViewZero.h"

#import "BN_CTViewCellOne.h"
#import "BN_CTViewLayoutZero.h"
#import "BN_CTViewLayoutOne.h"

static NSInteger numberOfRow = 5;
static CGFloat padding = 10;

static NSString * const kShareIcon = @"kShareIcon";
static NSString * const kShareTitle = @"kShareTitle";

@interface BN_ShareView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) UIButton * btn;

@end

@implementation BN_ShareView

-(UIView *)backView{
    if (!_backView) {
        _backView = ({
           UIView * view = [[UIView alloc]initWithFrame:kScreen_rect];
            view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleAcionTap)];
            [view addGestureRecognizer:tap];
            
            view;
        });
    }
    return _backView;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];

            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            
            [btn addTarget:self action:@selector(handleAcionTap) forControlEvents:UIControlEventTouchUpInside];
            
            btn.layer.cornerRadius = 8;
            btn.layer.masksToBounds = YES;
            
            btn;
        });
    }
    return _btn;
}

- (void)handleAcionTap{
    [self dismiss];
    
}

-(NSDictionary *)dictClass{
    if (!_dictClass) {
        _dictClass = @{
                       UICollectionElementSectionItem       :   @[
                               @"BN_CTViewCellOne"
                               ],
                       UICollectionElementKindSectionHeader :   @[
                               @"BN_CTReusableViewZero",
                               ],
                       UICollectionElementKindSectionFooter :   @[
                               @"BN_CTReusableViewZero",
                               ],
                       
                       };
        
    }
    return _dictClass;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
            CGFloat width = (CGRectGetWidth(self.bounds) - padding*(numberOfRow + 1))/numberOfRow;

            //默认布局
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            
            //item水平间距
            layout.minimumLineSpacing = 5;
            //item垂直间距
            layout.minimumInteritemSpacing = 5;
            //item的尺寸
            layout.itemSize = CGSizeMake(55, 80);
            layout.itemSize = CGSizeMake(width, width+kH_LABEL);
            
            //item的UIEdgeInsets
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            //滑动方向,默认垂直
//            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            //sectionView 尺寸
            layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.bounds), 40);
            layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.bounds), 20);
            
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
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

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor orangeColor];

        self.frame = CGRectMake(10, kScreen_height, kScreen_width - 20, 400);
        
        self.dataList = @[
                          @[
                              @{kShareIcon:@"share_qqzone",kShareTitle:@"QQ空间"},
                              @{kShareIcon:@"share_qq",kShareTitle:@"QQ好友"},
                              @{kShareIcon:@"share_timeline",kShareTitle:@"微信朋友圈"},
                              @{kShareIcon:@"share_wechat",kShareTitle:@"微信好友"},
                              @{kShareIcon:@"share_weibo",kShareTitle:@"微博"},
                          ],
                          ];
        
        self.collectionView.layer.cornerRadius = 8;
        self.collectionView.layer.masksToBounds = YES;
        //新布局
        [self addSubview:self.collectionView];
        [self addSubview:self.btn];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
}

- (void)updateControlsFrame{
    //调整布局
    //    self.collectionView.frame = self.bounds;
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.collectionView.collectionViewLayout.collectionViewContentSize.height);
    //btn
    self.btn.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame) + padding, CGRectGetWidth(self.collectionView.frame), 35);
    
    CGRect rect = self.frame;
    rect.origin.y = kScreen_height;
    rect.size.height = (CGRectGetMaxY(self.btn.frame) + padding);
    self.frame = rect;
    
}

- (void)show{
    
    [self updateControlsFrame];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [window addSubview:self.backView];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.35f animations:^{
        self.backView.alpha = 1.0;

        CGRect temFrame = self.frame;
        temFrame.origin.y -= CGRectGetHeight(self.frame);
        self.frame = temFrame;
        
    } completion:nil];
    
    DDLog(@"__%@,%@",@(self.backView.frame),@(self.frame));

}

- (void)dismiss{
    [UIView animateWithDuration:0.35f animations:^{
        self.backView.alpha = 0.0;
        
        CGRect temFrame = self.frame;
        temFrame.origin.y += CGRectGetHeight(self.frame);
        self.frame = temFrame;
        
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

#pragma mark - -UICollectionView
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataList.count;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arraySection = self.dataList[section];
    return arraySection.count;
    
}

////设置每个item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGSize itemSize = CGSizeMake((CGRectGetWidth(self.collectionView.bounds) - 10*2)/4.0, 80);
//    return itemSize;
//}
//
////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 5;
//}
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 5;
//}
////设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsZero;
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arraySection = self.dataList[indexPath.section];
    NSDictionary *dict = arraySection[indexPath.item];
    
    BN_CTViewCellOne * cell = [BN_CTViewCellOne viewWithCollectionView:collectionView indexPath:indexPath];
    cell.label.text = NSStringFromIndexPath(indexPath);

    cell.imgView.image = [UIImage imageNamed:dict[kShareIcon]];
    cell.label.text = dict[kShareTitle];
    cell.label.font = [UIFont systemFontOfSize:12];
    cell.label.adjustsFontSizeToFitWidth = YES;
//    cell.label.numberOfLines = 0;

    [cell getViewLayer];
    return cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BN_CTViewCellOne *cell = (BN_CTViewCellOne *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *msg = cell.label.text;
    //    DDLog(@"%@",msg);
    DDLog(@"%@",indexPath);
    if (self.block) {
        self.block(self, indexPath);
    }
    
    [self handleAcionTap];
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
       return CGSizeMake(0, 30);
    }
    return CGSizeMake(0, 0.01);
}

//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0.01);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    BN_CTReusableViewZero * view = [BN_CTReusableViewZero viewWithCollectionView:collectionView indexPath:indexPath kind:kind];
    NSString * titleHeader = [NSString stringWithFormat:@"HeaderView_%@",@(indexPath.section)];
    NSString * titleFooter = [NSString stringWithFormat:@"FooterView_%@",@(indexPath.section)];
    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? titleHeader: titleFooter;
    view.label.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? [UIColor greenColor] : [UIColor yellowColor];
    
    view.label.font = [UIFont systemFontOfSize:16];
    if (indexPath.section == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            view.label.text = @"分享至";
            
        }
    }
    return view;
    
}

@end

