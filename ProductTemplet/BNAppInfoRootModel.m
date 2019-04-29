//
//Created by ESJsonFormatForMac on 19/04/29.
//

#import "BNAppInfoRootModel.h"
@implementation BNAppInfoRootModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"results" : [BNAppInfoResultsModel class]};
}


@end


@implementation BNAppInfoResultsModel


@end


