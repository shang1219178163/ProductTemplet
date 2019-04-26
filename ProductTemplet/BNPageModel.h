//
//  BNPageModel.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNPageModel : NSObject

@property (nonatomic, assign, readonly) NSUInteger currPage;
/// 最小页码,不一定是1(重置时currPage同值)
@property (nonatomic, assign) NSUInteger minPage;
/// 每页限制个数
@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, assign, readonly) BOOL hasNextPage;

-(instancetype)initWithLimit:(NSUInteger)limit;

- (void)turnToMinPage;

- (void)turnToNextPage;

- (BOOL)hasPrePage;

- (void)turnToPrePage;

/**
数组个数==perPageCount时才有下一页
 */
- (BOOL)hasNextPageWithItems:(NSArray *)array;

@end

