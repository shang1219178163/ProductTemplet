//
//  FlowerFactory.h
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/24.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    FlowerTypeAnemone = 1,
    FlowerTypeCosmos,
    FlowerTypeGerberas,
    FlowerTypeHollyhock,
    FlowerTypeJasmine,
    FlowerTypeZinnia,
    FlowerTypeTotalNumber
} FlowerType;

@interface FlowerFactory : NSObject

@property(nonatomic ,strong) NSMutableDictionary *flowerPool;

-(UIView *)flowerViewWithType:(FlowerType)type;
@end
