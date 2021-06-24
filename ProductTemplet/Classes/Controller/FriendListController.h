//
//  FriendListController.h
//  ProductTemplet
//
//  Created by BIN on 2018/4/24.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendListController : UIViewController

@end



//折叠数据模型
@interface NNFoldSectionModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleSub;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) id image;
@property (nonatomic, assign) BOOL isOpen;

@end
