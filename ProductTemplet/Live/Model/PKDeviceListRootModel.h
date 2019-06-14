//
//Created by ESJsonFormatForMac on 19/06/13.
//

#import <Foundation/Foundation.h>

@class PKDeviceInfoModel;


@interface PKDeviceListRootModel : NSObject

@property (nonatomic, assign) NSInteger DeviceCount;

@property (nonatomic, strong) NSArray *DeviceList;

@end


@interface PKDeviceInfoModel : NSObject

@property (nonatomic, assign) NSInteger ChannelCount;

@property (nonatomic, assign) NSInteger CpuUsedPercent;

@property (nonatomic, copy) NSString *CreatedAt;

@property (nonatomic, assign) long long DiskTotalSize;

@property (nonatomic, assign) CGFloat DiskUsedPercent;

@property (nonatomic, assign) long long DiskUsedSize;

@property (nonatomic, assign) NSInteger EnabledChannelCount;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger LivingChannelCount;

@property (nonatomic, assign) NSInteger MemUsedPercent;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, assign) NSInteger NumOutputs;

@property (nonatomic, assign) BOOL Online;

@property (nonatomic, assign) NSInteger OnlineChannelCount;

@property (nonatomic, assign) NSInteger RecordingChannelCount;

@property (nonatomic, copy) NSString *UpdatedAt;

@end

