//
//  MainViewController.m
//  NNCollectionData
//
//  Created by hsf on 2018/8/2.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NNCollectionDataController.h"

#import "NNCollectionDataModel.h"

@interface NNCollectionDataController ()

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSMutableArray *actionList;

@property (nonatomic, strong) NNCollectionDataModel *dataModel;

@end

@implementation NNCollectionDataController

-(NNCollectionDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [[NNCollectionDataModel alloc]init];
    }
    return _dataModel;
}

-(NSMutableArray *)list{
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

-(NSMutableArray *)actionList{
//    DDLog(@"%@",NSStringFromSelector(@selector(list)));
    return  [self mutableArrayValueForKey:@"list"];

}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    [self addObserver:self forKeyPath:@"list" options:0 context:nil];
    [self.dataModel addObserver:self forKeyPath:@"array" options:NSKeyValueObservingOptionNew context:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.actionList addObject:@"1"];
    [self.actionList addObject:@"2"];
    [self.actionList removeObject:@"3"];

    [[self.dataModel mutableArrayValueForKey:@"array"] addObject:@"11"];
    [[self.dataModel mutableArrayValueForKey:@"array"] addObject:@"12"];
    [[self.dataModel mutableArrayValueForKey:@"array"] removeObject:@"13"];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    DDLog(@"%@",NSStringFromClass([object class]));
    
    if ([keyPath isEqualToString:@"list"]) {
        DDLog(@"_%@_%@_%@",change[NSKeyValueChangeNewKey],self.list,self.actionList);
//        DDLog(@"_%p_%p_%p",change[NSKeyValueChangeNewKey],self.list,self.actionList);
        
    }
    
    if ([keyPath isEqualToString:@"array"]) {
        //        DDLog(@"_%@_%@_%@",change[NSKeyValueChangeNewKey],self.list,self.actionList);
        //        DDLog(@"_%p_%p_%p",change[NSKeyValueChangeNewKey],self.list,self.actionList);
        DDLog(@"_%@_%@",change[NSKeyValueChangeNewKey],self.dataModel.array);
        
    }
}


@end
