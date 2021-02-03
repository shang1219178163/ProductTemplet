//
//  NNSearchView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNSearchView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, copy) NSString * queryStr;
@property (nonatomic, copy) void(^block)(NNSearchView *view, NSString *queryStr, bool isFinish);

@end


