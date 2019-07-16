//
//Created by ESJsonFormatForMac on 19/06/13.
//

#import <Foundation/Foundation.h>

@class PKChannelEasyDarwinModel,PKChannelHeaderModel,PKChannelBodyModel,PKChannelInfoModel;


@interface PKChannelListRootModel : NSObject

@property (nonatomic, strong) PKChannelEasyDarwinModel *EasyDarwin;

@end


@interface PKChannelEasyDarwinModel : NSObject

@property (nonatomic, strong) PKChannelBodyModel *Body;

@property (nonatomic, strong) PKChannelHeaderModel *Header;

@end



@interface PKChannelHeaderModel : NSObject

@property (nonatomic, copy) NSString *CSeq;

@property (nonatomic, copy) NSString *ErrorNum;

@property (nonatomic, copy) NSString *ErrorString;

@property (nonatomic, copy) NSString *MessageType;

@property (nonatomic, copy) NSString *Version;

@end



@interface PKChannelBodyModel : NSObject

@property (nonatomic, assign) NSInteger ChannelCount;

@property (nonatomic, strong) NSArray *Channels;


@property (nonatomic, copy) NSString *ChannelName;

@property (nonatomic, copy) NSString *DeviceType;

@property (nonatomic, copy) NSString *StreamMode;

@property (nonatomic, copy) NSString *URL;

@end



@interface PKChannelInfoModel : NSObject

@property (nonatomic, assign) NSInteger Channel;

@property (nonatomic, copy) NSString *ErrorString;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, assign) NSInteger Online;

@property (nonatomic, copy) NSString *SnapURL;

@end

