//
//  NNTextFieldOne.h
//  NNKit
//
//  Created by BIN on 2018/11/23.
//

#import <UIKit/UIKit.h>

/// 密码输入框(leftView在最右边)
@interface NNTextFieldOne : UITextField
  
- (void)showHistoryWithImage:(NSString *)image handlder:(void(^)(NNTextFieldOne *textField, UIImageView *imgView))handler;

@end


