//
//  BNPageModel.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNPageModel.h"

@interface BNPageModel()

@property (nonatomic, assign, readwrite) NSUInteger currPage;
@property (nonatomic, assign, readwrite) BOOL hasNextPage;

@end

@implementation BNPageModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _currPage = _minPage = 1;
        _limit = 30;
        _hasNextPage = true;
        
    }
    return self;
}

-(instancetype)initWithLimit:(NSUInteger)limit{
    BNPageModel * model = [[BNPageModel alloc]init];
    model.limit = limit;
    return model;
}

#pragma mak - -funtions

- (void)turnToMinPage{
    _currPage = _minPage;
}

- (void)turnToNextPage{
    _currPage += 1;
}

- (BOOL)hasPrePage{
    return _currPage > _minPage;
}

- (void)turnToPrePage{
    if ([self hasPrePage]) {
        _currPage -= 1;
    }
}

- (BOOL)hasNextPageWithItems:(NSArray *)array{
    _hasNextPage = array.count >= _limit;
    return _hasNextPage;
}

#pragma mark - -set
-(void)setMinPage:(NSUInteger)minPage{
    assert(minPage >= 1);
    _minPage = minPage;
    _currPage = minPage;
}


@end
