//
//  WHKUserDataModel.h
//  
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 SHANG. All rights reserved.
//

/**
 登录用户单例类
 */

#import <Foundation/Foundation.h>

#define KEY_userNameDeault  @"匿名"


#define KEY_isJPush (@"isJPush")

#define KEY_typeCar (@"typeCar")
#define KEY_typeUser (@"typeUser")

#define KEY_isLogin (@"isLogin")
#define KEY_loginFlag (@"loginFlag")

#define KEY_userID (@"userID")
#define KEY_userLevel (@"userLevel")
#define KEY_authStatus (@"authStatus")

#define KEY_status (@"status")

#define KEY_userName (@"userName")
#define KEY_userPwd (@"userPwd")
#define KEY_userType (@"userType")

#define KEY_phone (@"phone")
#define KEY_phoneIemi (@"phoneIemi")


#define KEY_userCity (@"userCity")
#define KEY_userPhotoUrl (@"userPhotoUrl")
#define KEY_securityCode (@"securityCode")

#define KEY_IDCardNumber (@"KEY_IDCardNumber")

#define KEY_userSex (@"sex")
#define KEY_vehicleType (@"type")
#define KEY_vehicleLogo (@"logo")
#define KEY_vehicleBrand (@"brand")
#define KEY_plateNumber (@"plateNumber")

#define KEY_userGrade (@"grade")
#define KEY_integralTotal (@"integralTotal")
#define KEY_finishOrder (@"finishOrder")
#define KEY_businessDesc (@"businessDesc")
#define KEY_isDriver (@"isDriver")
#define KEY_isCompany (@"isCompany")
#define KEY_authDoubles (@"doubles")

#define KEY_platformType (@"platformType")

#define KEY_uidQQ (@"uidQQ")
#define KEY_tokenQQ (@"tokenQQ")
#define KEY_nicknameQQ (@"nicknameQQ")

//#define KEY_access_tokenQQ (@"access_tokenQQ")
//#define KEY_expires_inQQ (@"expires_inQQ")
//#define KEY_msgQQ (@"msgQQ")
//#define KEY_openidQQ (@"openidQQ")
//#define KEY_pay_tokenQQ (@"pay_tokenQQ")
//#define KEY_pfQQ (@"pfQQ")
//#define KEY_pf_keyQQ (@"pf_keyQQ")
//#define KEY_retQQ (@"retQQ")

#define KEY_uidWX (@"uidWX")
#define KEY_tokenWX (@"tokenWX")
#define KEY_nicknameWX (@"nicknameWX")

//#define KEY_access_tokenWX (@"access_tokenWX")
//#define KEY_expires_inWX (@"expires_inWX")
//#define KEY_openidWX (@"openidWX")
//#define KEY_refresh_tokenWX (@"refresh_tokenWX")
//#define KEY_scopeWX (@"scopeWX")
//#define KEY_unionidWX (@"unionidWX")


@class WHKWalletDataModel;

@interface WHKUserDataModel : NSObject

@property (nonatomic, copy) NSString * isJPush;

@property (nonatomic, copy) NSString * typeCar;
@property (nonatomic, copy) NSString * typeUser;

@property (nonatomic, copy) NSString * isLogin;//登录状态0/1
@property (nonatomic, copy) NSString * loginFlag;//登录方式0,phone; 1,qq;2,weChat

@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * userLevel;//1,默认仅注册,3非企业车主4,企业车主 6企业
@property (nonatomic, copy) NSString * authStatus;//1实名认证;2车主认证;3企业认证

@property (nonatomic, copy) NSString * status;

@property (nonatomic, copy) NSString * photoUrl;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * nickName;

//@property (nonatomic, copy) NSString * orderCount;

@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * phoneIemi;

@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * userType;

@property (nonatomic, copy) NSString * securityCode;

@property (nonatomic, copy) NSString * IDCardNumber;


@property (nonatomic, copy) NSString * userSex;//1女,2男
@property (nonatomic, copy) NSString * vehicleType;
@property (nonatomic, copy) NSString * vehicleLogo;
@property (nonatomic, copy) NSString * vehiclebrand;
@property (nonatomic, copy) NSString * plateNumber;

@property (nonatomic, copy) NSString * userGrade;
@property (nonatomic, copy) NSString * integralTotal;
@property (nonatomic, copy) NSString * finishOrder;

@property (nonatomic, copy) NSString * isDriver;
@property (nonatomic, copy) NSString * isCompany;
@property (nonatomic, copy) NSString * authDoubles;

@property (nonatomic, copy) NSString * businessDesc;
//@property (nonatomic, copy) NSString * markTips;///
//@property (nonatomic, copy) NSString * individualResume;//

@property (nonatomic, copy) NSString * platformType;//原生:0,QQ:1,WX:2
/*-----------------------------------QQ登录-------------------------------------------------*/

@property (nonatomic, copy) NSString * uidQQ;
@property (nonatomic, copy) NSString * tokenQQ;
@property (nonatomic, copy) NSString * nicknameQQ;

//@property (nonatomic, copy) NSString * access_tokenQQ;
//@property (nonatomic, copy) NSString * expires_inQQ;
//@property (nonatomic, copy) NSString * msgQQ;
//@property (nonatomic, copy) NSString * openidQQ;
//@property (nonatomic, copy) NSString * pay_tokenQQ;
//@property (nonatomic, copy) NSString * pfQQ;
//@property (nonatomic, copy) NSString * pf_keyQQ;
//@property (nonatomic, copy) NSString * retQQ;

/*-----------------------------------微信登录-------------------------------------------------*/

@property (nonatomic, copy) NSString * uidWX;
@property (nonatomic, copy) NSString * tokenWX;
@property (nonatomic, copy) NSString * nicknameWX;

//@property (nonatomic, copy) NSString * access_tokenWX;
//@property (nonatomic, copy) NSString * expires_inWX;
//@property (nonatomic, copy) NSString * openidWX;
//@property (nonatomic, copy) NSString * refresh_tokenWX;
//@property (nonatomic, copy) NSString * scopeWX;
//@property (nonatomic, copy) NSString * unionidWX;

/*------------------------------------------------------------------------------------*/



@property (nonatomic, strong) WHKWalletDataModel * walletModel;

+ (instancetype)sharedInstance;
+ (void)resetUserDefaultData;

//- (void)defaultSynchronize;

-(void)logOut;

@end


@interface WHKWalletDataModel : NSObject

@property (nonatomic, copy) NSString * paymentType;
@property (nonatomic, copy) NSString * money;
@property (nonatomic, copy) NSString * vocher;

@property (nonatomic, copy) NSString * invoices;
@property (nonatomic, copy) NSString * invoicesHistory;


@end


@interface WHKBlankCardDataModel : NSObject

@property (nonatomic, copy) NSString * cardName;
@property (nonatomic, copy) NSString * cardNumber;
@property (nonatomic, copy) NSString * cardCompany;

@property (nonatomic, copy) NSString * cardPhone;//银行卡绑定的手机号

@end
