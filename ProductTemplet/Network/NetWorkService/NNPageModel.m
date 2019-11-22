//
//  NNPageModel.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNPageModel.h"

@interface NNPageModel()

@property (nonatomic, assign, readwrite) NSUInteger currPage;
@property (nonatomic, assign, readwrite) BOOL hasNextPage;

@end

@implementation NNPageModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _currPage = _firstPage = 1;
        _pageSize = 30;
        _hasNextPage = true;
        
    }
    return self;
}

-(instancetype)initWithPageSize:(NSUInteger)pageSize{
    NNPageModel * model = [[NNPageModel alloc]init];
    model.pageSize = pageSize;
    return model;
}

#pragma mak - -funtions

- (void)turnToFirstPage{
    _currPage = _firstPage;
}

- (void)turnToNextPage{
    _currPage += 1;
}

- (BOOL)hasPrePage{
    return _currPage > _firstPage;
}

- (void)turnToPrePage{
    if ([self hasPrePage]) {
        _currPage -= 1;
    }
}

- (BOOL)hasNextPageWithItems:(NSArray *)array{
    _hasNextPage = array.count == _pageSize;
    return _hasNextPage;
}

#pragma mark - -set
- (void)setFirstPage:(NSUInteger)firstPage{
    assert(firstPage >= 1);
    _firstPage = firstPage;
    _currPage = firstPage;
}


@end
