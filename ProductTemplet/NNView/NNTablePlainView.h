//
//  NNTablePlainView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/22.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NNGloble/NNGloble.h>

//typedef UITableViewCell *(^BlockCellForRow)(UITableView *tableView, NSIndexPath *indexPath);
//typedef void(^BlockDidSelectRow)(UITableView *tableView, NSIndexPath *indexPath);
//typedef NSArray *(^BlockEditActionsForRow)(UITableView *tableView, NSIndexPath *indexPath);

/**
 列表数据展示通用
 */
@interface NNTablePlainView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * list;

@property (nonatomic, strong) UILabel * label;

@property (nonatomic, assign) BOOL hasTips;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * inputString;

@property (nonatomic, copy) BlockCellForRow blockCellForRow;
@property (nonatomic, copy) BlockDidSelectRow blockDidSelectRow;
@property (nonatomic, copy) BlockEditActionsForRow blockEditActionsForRow;

@end

