//
//Created by ESJsonFormatForMac on 18/01/23.
//

#import <Foundation/Foundation.h>

@class NNNetResultShareModel, NNNetInfoShareModel, NNNetShareModel;
@interface NNNetRootShareModel : NSObject

@property (nonatomic, strong) NNNetResultShareModel *result;

@end


@interface NNNetResultShareModel : NSObject

@property (nonatomic, strong) NNNetInfoShareModel *info;

@property (nonatomic, assign) NSInteger code;

@end


@interface NNNetInfoShareModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NNNetShareModel *data;

@end


@interface NNNetShareModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *desc;

@end

