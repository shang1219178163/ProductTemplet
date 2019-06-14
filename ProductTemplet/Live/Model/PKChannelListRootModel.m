//
//Created by ESJsonFormatForMac on 19/06/13.
//

#import "PKChannelListRootModel.h"
#import "BNAPIConfi.h"

@implementation PKChannelListRootModel


@end


@implementation PKChannelEasyDarwinModel


@end



@implementation PKChannelHeaderModel


@end



@implementation PKChannelBodyModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"Channels" : [PKChannelInfoModel class]};
}

- (void)setURL:(NSString *)URL{
    _URL = URL;
    if (![_URL hasPrefix:BNAPIConfi.serviceUrl]) {
        _URL = [BNAPIConfi.serviceUrl stringByAppendingString:_URL];
    }
}

@end



@implementation PKChannelInfoModel

- (void)setSnapURL:(NSString *)SnapURL{
    _SnapURL = SnapURL;
    if (![_SnapURL hasPrefix:BNAPIConfi.serviceUrl]) {
        _SnapURL = [BNAPIConfi.serviceUrl stringByAppendingString:_SnapURL];
    }
}


@end


