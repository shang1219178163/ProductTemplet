//
//  BNUserLoginView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/14.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNUserLoginView : UIView<UITextFieldDelegate>

//@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) BNRotationView * imgView;

@property (nonatomic, strong) UITextField * textFieldName;
@property (nonatomic, strong) UITextField * textFieldPwd;
@property (nonatomic, strong) UIButton * btnPwd;
@property (nonatomic, strong) UIButton * btnLogin;
@property (nonatomic, strong) UIButton * btnRegister;

@property (nonatomic, strong) UIView * pwdRightView;
@property (nonatomic, strong) NSArray * pwdImagList;

@property (nonatomic, strong) UILabel * labEULA;

@property (nonatomic, copy) void(^block)(BNUserLoginView * view);

@end

NS_ASSUME_NONNULL_END
