//
//  BNCollectionDataModel.m
//  NNCollectionData
//
//  Created by hsf on 2018/8/2.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNCollectionDataModel.h"

@implementation BNCollectionDataModel

-(NSMutableArray *)list{
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

@end
