//
//Created by ESJsonFormatForMac on 18/01/23.
//

#import <Foundation/Foundation.h>

@class BN_NetResultShareModel,BN_NetInfoShareModel,BN_NetShareModel;
@interface BN_NetRootShareModel : NSObject

@property (nonatomic, strong) BN_NetResultShareModel *result;

@end
@interface BN_NetResultShareModel : NSObject

@property (nonatomic, strong) BN_NetInfoShareModel *info;

@property (nonatomic, assign) NSInteger code;

@end

@interface BN_NetInfoShareModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) BN_NetShareModel *data;

@end

@interface BN_NetShareModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *desc;

@end

