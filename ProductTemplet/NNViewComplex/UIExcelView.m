//
//  UIExcelView.m
//  ChildViewControllers
//
//  Created by hsf on 2018/4/10.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UIExcelView.h"

static NSString * const kTips = @"👈左滑查看更多信息";

@interface UIExcelView()<UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) NSDictionary *dictClass;

@property (nonatomic, assign) CGFloat lockOffsetX;

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSArray * testList;

@end

@implementation UIExcelView

#pragma mark - -viewCycle

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.label.text = kTips;
        self.itemSize = CGSizeMake(80, 50);

        [self addSubview:self.label];
        [self addSubview:self.collectionView];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat xGap = 15;
    CGFloat labHeight = [self.label.text isEqualToString:@""] ? 0.0 :30;
    self.label.frame = CGRectMake(xGap, 0, CGRectGetWidth(self.bounds) - xGap*2, labHeight);
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetMaxY(self.label.frame));

}

- (void)reloadData{
    if (![self.dict.allKeys containsObject:kExcelDatas] || [self.dict[kExcelDatas]count] <= 0) {
        self.label.text = @"暂无数据,请稍后重试";
        return;
    }
    self.label.text = kTips;
    
    NSAssert([self.dict.allKeys containsObject:kExcelDatas], @"必须包含展示数据");
    
    NSInteger lockColumn = [self.dict[kExcelLockColumn] integerValue];
    NSArray * titleList = self.dict[kExcelTitles];
    NSArray * widthList = self.dict[kExcelWidths];
    NSArray * dataList = self.dict[kExcelDatas];
    if (lockColumn <= 1) lockColumn = 1;
    //
    if (dataList.count <= 0) {
        NSAssert(dataList.count > 0, @"数据列表不能为空");
        return;
    }
    
    if (!widthList) {
        CGFloat itemWidth = self.itemSize.width;
        NSInteger count = titleList ? titleList.count : [[dataList firstObject]count];
        widthList = [self arrayWithItem:@(itemWidth) count:count];
        
    }
    
    self.collectionView.collectionViewLayout = self.layout;
    self.layout.lockColumn = lockColumn;
    self.layout.itemHeight = self.itemSize.height;
    [self.layout reset];
    
    self.dataList = [NSMutableArray arrayWithArray:dataList];
    //    self.dataList = [[NSMutableArray alloc]initWithArray:dataList copyItems:YES];
    if (titleList) [self.dataList insertObject:titleList atIndex:0];
    
    
    for (NSArray * itemList in self.dataList) {
        if (itemList.count != widthList.count) {
            DDLog(@"第%@行item宽度数组个数和数组元素个数不相同",@([self.dataList indexOfObject:itemList]));
            NSParameterAssert(itemList.count == widthList.count);
        }
    }
    
    self.layout.columnWidths = widthList.copy;
    self.layout.columnCount = self.layout.columnWidths.count;
    
    //锁定偏移量
    NSArray * arraySub = [self.layout.columnWidths subarrayWithRange:NSMakeRange(0, self.layout.lockColumn - 1)];
    _lockOffsetX = [[arraySub valueForKeyPath:@"@sum.floatValue"] floatValue];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView 的代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = self.dataList[section];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = self.dataList[indexPath.section];
    UICTViewCellExcel *cell = [UICTViewCellExcel dequeueReusableCell:collectionView indexPath:indexPath];
    //设置单元行颜色的间隔的控制
    if (indexPath.section == 0) {//整个报表最上面的那行
//        if (indexPath.section == 0 || indexPath.row == 0) {//整个报表最上面的那行
        cell.backgroundColor = UIColor.excelColor;
        cell.label.textColor = UIColor.themeColor;
        cell.label.textAlignment = NSTextAlignmentCenter;
        
    } else {
        cell.backgroundColor = UIColor.whiteColor;
        cell.label.textColor = UIColor.blackColor;
        cell.label.textAlignment = NSTextAlignmentLeft;

    }
    cell.label.text = [NSString stringWithFormat:@"%@", array[indexPath.row]];
//    cell.imgView.backgroundColor = [UIColor redColor];
//    [cell getViewLayer];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICTViewCellExcel *cell = (UICTViewCellExcel *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.block) {
        self.block(self, cell, indexPath);
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - - UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 禁止下拉
    if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
   
    //禁止
    if (scrollView.contentOffset.x < _lockOffsetX) {
        scrollView.contentOffset = CGPointMake(_lockOffsetX, scrollView.contentOffset.y);
    }

    // 禁止上拉
//    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height) {
//        scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.size.height
//    }
    
}

#pragma mark - otherFuntions

//更新数据
- (NSArray *)arrayWithItem:(id)item count:(NSInteger)count{
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < count; i++) {
        [marr addObject:item];
    }
    return marr.copy;
}

- (NSArray *)widthByDataList:(NSArray *)dataList longItems:(NSArray *)items itemWidth:(CGFloat)itemWidth{
    
    NSInteger count = [[dataList firstObject]count];
    CGFloat kW_Norml = 80;
    CGFloat kW_total = itemWidth*items.count + (count - items.count)*kW_Norml;
    if (kW_total < kScreenWidth) {
        kW_Norml = (kScreenWidth - itemWidth*items.count)/(count - items.count);
        
    }
    
    NSMutableArray * widthList = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        
        if ([items containsObject:@(i)]) {
            [widthList addObject:@(itemWidth)];
        }
        else{
            [widthList addObject:@(kW_Norml)];
            
        }
    }
    return widthList.copy;
    
}

+ (NSMutableArray *)dataByList:(NSArray *)modelList propertyList:(NSArray *)propertyList{
    
    __block NSMutableArray * listArr = [NSMutableArray array];
    [modelList enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray * marr = [NSMutableArray array];
        for (NSString * key in propertyList) {
            [marr addObject:@([[obj valueForKey:key] floatValue])];
        }
        [listArr addObject:marr];
        
    }];
    return listArr;
}


- (NSArray *)testList{
    if (!_testList) {
        _testList = @[
                       @[@"名称",@"总数",@"剩余",@"IP",@"状态",@"状态1",@"状态2",@"状态3",@"状态4"],
                       @[@"ces1",@0,@0,@"3.4.5.6",@"027641081087",@"1",@0,@"3.4.5.6",@"027641081087"],
                       @[@"ces2",@0,@0,@"3.4.5.6",@"027641081087",@"2",@0,@"3.4.5.6",@"027641081087"],
                       @[@"ces3",@0,@0,@"3.4.5.6",@"027641081087",@"3",@0,@"3.4.5.6",@"027641081087"],
                       @[@"ces4",@0,@0,@"3.4.5.6",@"027641081087",@"4",@0,@"3.4.5.6",@"027641081087"],
                       @[@"ces5",@0,@0,@"3.4.5.6",@"027641081087",@"5",@0,@"3.4.5.6",@"027641081087"],
                       @[@"ces6",@"",@0,@"3.4.5.6",@"027641081087",@"6",@0,@"3.4.5.6",@"027641081087"],
                       @[@"ces7",@0,@0,@"3.4.5.6",@"027641081087",@"7",@0,@"3.4.5.6",@"027641081087"],
                       @[@"ces8",@0,@0,@"3.4.5.6",@"027641081087",@"8",@0,@"3.4.5.6",@"027641081087"],
                       @[@"ces9",@0,@0,@"3.4.5.6",@"027641081087",@"9",@0,@"3.4.5.6",@"027641081087"],
                       ];
    }
    return _testList;
}

#pragma mark -lazy

-(NSDictionary *)dictClass{
    if (!_dictClass) {
        _dictClass = @{
                       
                       UICollectionElementKindSectionItem:   @[
                               @"UICTViewCellExcel",
                               
                               ],
                       UICollectionElementKindSectionHeader:   @[
                               @"UICTReusableViewZero",
                               ],
                       //                      UICollectionElementKindSectionFooter:   @[
                       //                              @"UICollectionReusableOneView",
                       //                              ],
                       
                       };
        
    }
    return _dictClass;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            //            JHCollectionViewFlowLayout *layout = [[JHCollectionViewFlowLayout alloc] init];
            
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
            //            layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 40);
            //            layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 20);
            
            CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
            collectionView = [[NNCTView alloc]initWithFrame:rect collectionViewLayout:layout];
            
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.scrollsToTop = NO;
            collectionView.directionalLockEnabled = YES;
            collectionView.showsVerticalScrollIndicator = NO;
            collectionView.showsHorizontalScrollIndicator = NO;
            
            collectionView.dictClass = self.dictClass;
            
            collectionView;
        });
    }
    return _collectionView;
}

-(UICTViewLayoutExcel *)layout{
    if (!_layout) {
        _layout = [[UICTViewLayoutExcel alloc]init];
        //        _layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.bounds), 40);
        
    }
    return _layout;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.backgroundColor = [UIColor whiteColor];
        
        _label.numberOfLines = 1;
        
        _label.userInteractionEnabled = YES;
    }
    return _label;
}

@end
