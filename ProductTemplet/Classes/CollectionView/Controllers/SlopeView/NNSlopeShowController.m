//
//  NNSlopeShowController.m
//  ParallaxEffectlayout
//
//  Created by bjovov on 2017/11/7.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "NNSlopeShowController.h"
#import "UICTViewLayoutSlope.h"
#import "UICTViewCellInspiration.h"
#import "InspirationModel.h"

@interface NNSlopeShowController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) UICollectionView *ctView;

@end

@implementation NNSlopeShowController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.ctView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InspirationModel *model = self.list[indexPath.item];
//    UICTViewCellInspiration *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICTViewCellInspiration" forIndexPath:indexPath];
    UICTViewCellInspiration *cell = [UICTViewCellInspiration dequeueReusableCell:collectionView indexPath:indexPath];

//    cell.model = model;
    
    cell.backImageView.image = [[UIImage imageNamed:model.Background] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];;
    cell.titleLabel.text = model.Title;
    cell.timeAndRoomLabel.text = [NSString stringWithFormat:@"%@ • %@",model.Time, model.Room];
    cell.speakerLabel.text = model.Speaker;
    
//    [cell parallaxOffsetForCollectionBounds:self.ctView.bounds];
    return cell;
}


#pragma mark - Setter && Getter
- (UICollectionView *)ctView{
    if (!_ctView) {
        UICTViewLayoutSlope *layout = [[UICTViewLayoutSlope alloc]init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 110);
        layout.minimumLineSpacing = 13;
        
        _ctView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _ctView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_ctView registerClass:[UICTViewCellInspiration class] forCellWithReuseIdentifier:@"UICTViewCellInspiration"];
        _ctView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _ctView.dataSource = self;
        _ctView.delegate = self;
        //解决 first cell 和 last cell 旋转时超出 top 和 bottom问题
        _ctView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
    }
    return _ctView;
}

- (NSMutableArray *)list{
    if (!_list) {
        _list = [[NSMutableArray alloc]init];
        NSString *path = [NSBundle.mainBundle pathForResource:@"Inspirations" ofType:@"plist"];
        NSArray *tmpArray = [NSArray arrayWithContentsOfFile:path];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            InspirationModel *model = [[InspirationModel alloc]initWithDictionary:dict];
            [_list addObject:model];
        }];
    }
    return _list;
}

@end

