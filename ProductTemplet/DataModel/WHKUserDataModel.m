//
//  WHKUserDataModel.m
//  
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "WHKUserDataModel.h"

#import <NNGloble/NNGloble.h>

@interface WHKUserDataModel ()

@end


@implementation WHKUserDataModel


-(instancetype)init{
    if ([super init]) {
        NSUserDefaults * userDefaults =  NSUserDefaults.standardUserDefaults;

        _typeCar = [userDefaults objectForKey:KEY_typeCar];
        _typeUser = [userDefaults objectForKey:KEY_typeUser];

        _isLogin = [userDefaults objectForKey:KEY_isLogin];

        _userId = [userDefaults objectForKey:KEY_userID];
        _userLevel = [userDefaults objectForKey:KEY_userLevel];
        _authStatus = [userDefaults objectForKey:KEY_authStatus];

        _status = [userDefaults objectForKey:KEY_status];

        _phone = [userDefaults objectForKey:KEY_phone];
        _phoneIemi = [userDefaults objectForKey:KEY_phoneIemi];
        _password = [userDefaults objectForKey:KEY_userPwd];
        _name = [userDefaults objectForKey:KEY_userName];
        _photoUrl = [userDefaults objectForKey:KEY_userPhotoUrl];
        _userType = [userDefaults objectForKey:KEY_userType];
        _city = [userDefaults objectForKey:KEY_userCity];
        _securityCode = [userDefaults objectForKey:KEY_securityCode];

        _IDCardNumber = [userDefaults objectForKey:KEY_IDCardNumber];
        
        _userSex = [userDefaults objectForKey:KEY_userSex];
        _vehicleType = [userDefaults objectForKey:KEY_vehicleType];
        _vehicleLogo = [userDefaults objectForKey:KEY_vehicleLogo];
        _vehiclebrand = [userDefaults objectForKey:KEY_vehicleBrand];
        _plateNumber = [userDefaults objectForKey:KEY_plateNumber];
        _userGrade = [userDefaults objectForKey:KEY_userGrade];
        _integralTotal = [userDefaults objectForKey:KEY_integralTotal];
        _finishOrder = [userDefaults objectForKey:KEY_finishOrder];
        _isDriver = [userDefaults objectForKey:KEY_isDriver];
        _isCompany = [userDefaults objectForKey:KEY_isCompany];
        _businessDesc = [userDefaults objectForKey:KEY_businessDesc];
        
        //第三方登录
        _platformType = [userDefaults objectForKey:KEY_platformType];

        _uidQQ = [userDefaults objectForKey:KEY_uidQQ];
        _tokenQQ = [userDefaults objectForKey:KEY_tokenQQ];
        _nicknameQQ = [userDefaults objectForKey:KEY_nicknameQQ];

        _uidWX = [userDefaults objectForKey:KEY_uidWX];
        _tokenWX = [userDefaults objectForKey:KEY_tokenWX];
        _nicknameWX = [userDefaults objectForKey:KEY_nicknameWX];

    }
    return self;
}

//下个版本启用
//-(void)setIsJPush:(NSString *)isJPush{
//    [NSUserDefaults.standardUserDefaults setObject:isJPush forKey:KEY_isJPush];
//
//}
//下个版本启用
//- (void)defaultSynchronize{
//    [NSUserDefaults.standardUserDefaults synchronize];
//    
//}


-(NSString *)isJPush{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_isJPush];
}

-(NSString *)typeCar{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_typeCar];
}

-(NSString *)typeUser{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_typeUser];
}

-(NSString *)isLogin{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_isLogin];
}

-(NSString *)loginFlag{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_loginFlag];
}

-(NSString *)userId{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_userID];
}

-(NSString *)userLevel{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_userLevel];
}

-(NSString *)authStatus{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_authStatus];
}

-(NSString *)phone{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_phone];
}

-(NSString *)phoneIemi{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_phoneIemi];
}

-(NSString *)password{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_userPwd];
}

-(NSString *)name{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_userName];
}


-(NSString *)photoUrl{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_userPhotoUrl];
}

-(NSString *)userType{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_userType];
}

-(NSString *)city{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_userCity];
}

-(NSString *)IDCardNumber{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_IDCardNumber];
}

-(NSString *)vehicleType{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_vehicleType];
}

-(NSString *)vehicleLogo{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_vehicleLogo];
}

-(NSString *)vehiclebrand{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_vehicleBrand];
}

-(NSString *)plateNumber{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_plateNumber];
}

-(NSString *)userGrade{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_userGrade];
}

-(NSString *)integralTotal{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_integralTotal];
}

-(NSString *)finishOrder{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_finishOrder];
}

-(NSString *)isDriver{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_isDriver];
}

-(NSString *)isCompany{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_isCompany];
}

-(NSString *)businessDesc{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_businessDesc];
}


-(NSString *)platformType{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_platformType];
}

-(NSString *)uidQQ{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_uidQQ];
}

-(NSString *)tokenQQ{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_tokenQQ];
}

-(NSString *)nicknameQQ{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_nicknameQQ];
}

-(NSString *)uidWX{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_uidWX];
}

-(NSString *)tokenWX{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_tokenWX];
}

-(NSString *)nicknameWX{
    return [NSUserDefaults.standardUserDefaults objectForKey:KEY_nicknameWX];
}


#pragma mark - -WHKUserDataModel
+ (WHKUserDataModel *)sharedInstance{
    static WHKUserDataModel * instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WHKUserDataModel alloc]init];
    });
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static WHKUserDataModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

/**
 * 更换用户(包括：1、退出登录，2、切换账户，3、账户被踢，4、添加账户，5、删除当前账号，6、改密码之后)的时候，需要对"用户权限"进行复位！
 * 将复位操作统一写在此处，便于维护！
 */
//- (void)resetUserDefaultData{
//    
//    NSUserDefaults * userDefaults = NSUserDefaults.standardUserDefaults;
//    NSDictionary * dict = [userDefaults dictionaryRepresentation];
//    for(id key in dict) {
//        if (![key isEqualToString:@"appVer"]) {
//            [userDefaults removeObjectForKey:key];
////        [userDefaults setValue:@"" forKey:key];
//        }
//    }
//    [userDefaults synchronize];
//}

+ (void)resetUserDefaultData{
    NSArray *array = @[@"appVersion",KEY_phone];
    
    NSUserDefaults * userDefaults = NSUserDefaults.standardUserDefaults;
    NSDictionary * dict = [userDefaults dictionaryRepresentation];
    for(id key in dict) {
        if (![array containsObject:key]) {
            [userDefaults removeObjectForKey:key];
 //        [userDefaults setValue:@"" forKey:key];
        }
    }
    [userDefaults synchronize];
}

-(void)logOut{
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSNotificationCenter.defaultCenter postNotificationName:kNotiNameLogOut object:nil userInfo:nil];
    });
}

-(WHKWalletDataModel *)walletModel{
    if (!_walletModel) {
        _walletModel = [[WHKWalletDataModel alloc]init];
    }
    return _walletModel;
}

@end


@implementation WHKWalletDataModel

@end


@implementation WHKBlankCardDataModel

@end

