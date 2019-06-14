//
//Created by ESJsonFormatForMac on 19/06/13.
//

#import "PKDeviceListRootModel.h"

@implementation PKDeviceListRootModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"DeviceList" : [PKDeviceInfoModel class]};
}


@end


@implementation PKDeviceInfoModel


@end


