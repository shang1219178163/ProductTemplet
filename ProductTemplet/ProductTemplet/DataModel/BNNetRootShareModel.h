//
//Created by ESJsonFormatForMac on 18/01/23.
//

#import <Foundation/Foundation.h>

@class BNNetResultShareModel,BNNetInfoShareModel,BNNetShareModel;
@interface BNNetRootShareModel : NSObject

@property (nonatomic, strong) BNNetResultShareModel *result;

@end
@interface BNNetResultShareModel : NSObject

@property (nonatomic, strong) BNNetInfoShareModel *info;

@property (nonatomic, assign) NSInteger code;

@end

@interface BNNetInfoShareModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) BNNetShareModel *data;

@end

@interface BNNetShareModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *desc;

@end

