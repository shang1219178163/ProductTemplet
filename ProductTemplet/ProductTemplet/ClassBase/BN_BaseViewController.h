//
//  BN_BaseViewController.h
//  SearchBar
//
//  Created by BIN on 2018/2/27.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

/**
 控制器基类
 
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BNItemElement) {
    BNItemElementTitle = 0,           //标题
    BNItemElementCellSelectedStyle,   //响应方式
    BNItemElementRightViewHidden,     //右侧辅助视图
    
};

typedef NS_ENUM(NSInteger, BNCellSelectedStyle) {
    BNCellSelectedStyleEditNO = 0,      //显示且不可编辑
    BNCellSelectedStyleEditYES,         //可编辑
    BNCellSelectedStyleDatePicker,      //日期选择
    BNCellSelectedStylePickerView,      //多项选择
    BNCellSelectedStyleSegmentView,     //分段
    BNCellSelectedStyleStep,            //购物车加减
    BNCellSelectedStyleTextView,        //备注信息

};

UIKIT_EXTERN NSString * const kSeparateStr ;
UIKIT_EXTERN NSString * const kAsterisk ;

@interface BN_BaseViewController : UIViewController

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UIViewController * parController;

@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) NSDictionary *dictClass;

- (NSMutableArray *)arrayAtSection:(NSInteger)section dataList:(NSMutableArray *)dataList;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath dataList:(NSMutableArray *)dataList;



@end
