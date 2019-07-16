//
//Created by ESJsonFormatForMac on 19/06/12.
//

#import <Foundation/Foundation.h>

@interface PKSeverinfoModel : NSObject

@property (nonatomic, assign) BOOL APIAuth;

@property (nonatomic, copy) NSString *Hardware;

@property (nonatomic, copy) NSString *InterfaceVersion;

@property (nonatomic, assign) BOOL IsDemo;

@property (nonatomic, copy) NSString *RunningTime;

@property (nonatomic, copy) NSString *Server;

@property (nonatomic, copy) NSString *ServerTime;

@property (nonatomic, copy) NSString *StartUpTime;

@end
