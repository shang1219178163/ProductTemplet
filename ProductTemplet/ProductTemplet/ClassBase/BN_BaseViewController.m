//
//  BN_BaseViewController.m
//  SearchBar
//
//  Created by BIN on 2018/2/27.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

#import "BN_BaseViewController.h"

#import "UITableView+Helper.h"


NSString * const kSeparateStr       = @",";
NSString * const kAsterisk          = @"*";

@interface BN_BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BN_BaseViewController

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
            collectionView.scrollsToTop = NO;
            collectionView.showsVerticalScrollIndicator = NO;
            collectionView.showsHorizontalScrollIndicator = NO;
            
//            [collectionView bn_registerListClass:@[@"UICollectionViewExcelCell"]];
//            [collectionView bn_registerListClassReusable:@[@"UICollectionReusableOneView"] kind:UICollectionElementKindSectionHeader];
//            [collectionView bn_registerListClassReusable:@[@"UICollectionReusableOneView"] kind:UICollectionElementKindSectionFooter];
            
            collectionView;
        });
    }
    return _collectionView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
            tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;//确保TablView能够正确的调整大小
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //        tableView.separatorColor = kC_LineColor;
            tableView.backgroundColor = [UIColor greenColor];
            //        tableView.backgroundColor = kC_BackgroudColor;
            
            tableView.estimatedRowHeight = 0.0;
            tableView.estimatedSectionHeaderHeight = 0.0;
            tableView.estimatedSectionFooterHeight = 0.0;
            tableView.rowHeight = 50;
            
            //背景视图
//            UIView *view = [[UIView alloc]initWithFrame:tableView.bounds];
//            view.backgroundColor = [UIColor cyanColor];
//            tableView.backgroundView = view;
            
            tableView;
        });
    }
    return _tableView;
}

//-(UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;//确保TablView能够正确的调整大小
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
////        _tableView.separatorColor = kC_LineColor;
//        _tableView.backgroundColor = [UIColor greenColor];
////        _tableView.backgroundColor = kC_BackgroudColor;
//
//        _tableView.estimatedRowHeight = 0.0;
//        _tableView.estimatedSectionHeaderHeight = 0.0;
//        _tableView.estimatedSectionFooterHeight = 0.0;
//
//        self.tableView.rowHeight = 50;
//
//    }
//    return _tableView;
//}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;//不加的话，table会下移
    self.edgesForExtendedLayout = UIRectEdgeNone;//不加的话，UISearchBar返回后会上移
//    self.extendedLayoutIncludesOpaqueBars = YES;//导航栏透明使用
//    kAdjustsScrollViewInsets_NO(self.tableView, self);
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
////        self.tableViewGroup.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//
//    } else {
//        // Fallback on earlier versions
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.title = self.title ? : self.controllerName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 输出点击的view的类名
    //    DDLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - -otherFuntions

/**
 group模式数组获取
 
 */
- (NSMutableArray *)arrayAtSection:(NSInteger)section dataList:(NSMutableArray *)dataList{
//    NSArray *array = self.tableView.numberOfSections == 1 ? dataList : dataList[section];
    NSMutableArray *array = dataList;
    if ([[dataList firstObject] isKindOfClass:[NSArray class]]) {
        array = dataList[section];
        
    }
    return array;
}


/**
 模型获取
 
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath dataList:(NSMutableArray *)dataList{
    NSMutableArray *array = [self arrayAtSection:indexPath.section dataList:dataList];
    id model = array[indexPath.row];
    return model;
}


#pragma --tableView增删
- (void)handleRowIndexPaths:(NSArray *)indexPaths isInsert:(BOOL)isInsert{
    if (isInsert == YES) {
        [self.tableView insertIndexPaths:indexPaths rowAnimation:UITableViewRowAnimationFade];
        
    }else{
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (id)itemForElement:(BNItemElement)element indexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * itemdict = self.dataList[indexPath.section][indexPath.row];
    NSString * title = [itemdict.allKeys firstObject];//字典只有一个键值对
    NSString * content = [itemdict.allValues firstObject];//字典只有一个键值对

    NSArray * itemArray = [title componentsSeparatedByString:@","];

    NSInteger index = (NSInteger)element;
//    DDLog(@"index__%@",@(index));
//    DDLog(@"BNItemElement__%@",@((BNItemElement)1));

    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    id obj = @"";
    switch (element) {
        case BNItemElementTitle://NSAttributedString
        {
            BOOL isMust = ([itemArray[index] containsString:kAsterisk]) ? YES : NO;
            obj = [self getAttringByPrefix:kAsterisk content:itemArray[index] must:@(isMust)];
        }
            break;
        case BNItemElementCellSelectedStyle:
        {
           
            NSString * string = itemArray[index];
            obj = [string stringByReplacingOccurrencesOfString:@" " withString:@""];

        }
            break;
        case BNItemElementRightViewHidden:
        {
            NSString * string = itemArray[index];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            obj = @([self stringToBool:string]);

        }
            break;
        default://字符串
            break;
    }
    
    [marr addObject:obj];
    [marr addObject:content];
    
//    return obj;
    return marr;

}

- (NSString *)getPlaceholder:(NSString *)placeHolder indexPath:(NSIndexPath *)indexPath{
    
    NSString * string = @"";
    
    NSString *type = [[self itemForElement:BNItemElementCellSelectedStyle indexPath:indexPath] firstObject];
    BNCellSelectedStyle style = (BNCellSelectedStyle)[type integerValue];
    switch (style) {
        case BNCellSelectedStyleEditNO:
        {

        }
            break;
        case BNCellSelectedStyleEditYES:
        {
            string = placeHolder;

        }
            break;
        case BNCellSelectedStyleDatePicker:
        {
            string = @"请选择日期";

        }
            break;
        case BNCellSelectedStylePickerView:
        {
            string = @"请选择";

        }
            break;
        default:
            break;
    }
    return string;
}

@end
