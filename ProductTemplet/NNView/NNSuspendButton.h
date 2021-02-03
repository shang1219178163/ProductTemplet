//
//  NNSuspendButton.h
//  ProductTemplet
//
//  Created by BIN on 2017/12/12.
//  Copyright © 2019年 shang. All rights reserved.
//
 
#import <UIKit/UIKit.h>

@interface NNSuspendButton : UIButton

+(instancetype)spBtnRect:(CGRect)rect image:(id)image parController:(UIViewController *)parController;

@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, assign) CGFloat padding;

@end
