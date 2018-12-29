//
//  BN_SimpleDataModel.h
//  ProductTemplet
//
//  Created by BIN on 2018/4/17.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BN_SimpleDataModel : NSObject

@property (nonatomic, assign) NSInteger modelID;
@property (nonatomic, copy) NSString *controllerName;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleSub;
@property (nonatomic, strong) id objc;

//@property (nonatomic, strong) NSMutableDictionary *mdict;
//@property (nonatomic, strong) NSMutableArray *marr;

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *list;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) NSTextAlignment alignment ;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) BOOL isChoose;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL  isHidden;

//@property (nonatomic, assign) BOOL  isHiddenLeft;
//@property (nonatomic, assign) BOOL  isHiddenRow;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIViewController *parController;

//地图专用字段

@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * province;

@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * addressDetailInfo;

//@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
