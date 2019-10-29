//
//Created by ESJsonFormatForMac on 19/06/13.
//

#import "PKChannelListRootModel.h"
#import "NNAPIConfi.h"

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
    if (![_URL hasPrefix:NNAPIConfi.serviceUrl]) {
        _URL = [NNAPIConfi.serviceUrl stringByAppendingString:_URL];
    }
}

@end



@implementation PKChannelInfoModel

- (void)setSnapURL:(NSString *)SnapURL{
    _SnapURL = SnapURL;
    if (![_SnapURL hasPrefix:NNAPIConfi.serviceUrl]) {
        _SnapURL = [NNAPIConfi.serviceUrl stringByAppendingString:_SnapURL];
    }
}


@end


