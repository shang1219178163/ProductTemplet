//
//  NNSliderView.h
//  HXPhotoSlideUnlock
//
//  Created by Bin Shang on 2019/2/26.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNSliderControlView : UIView

@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, assign) UIEdgeInsets insets;

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *textFinish;

@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIImage *thumbFinishImage;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *labFront;
@property (nonatomic, strong) UILabel *labBack;

//@property (nonatomic, strong) UIView *bgViewFront;
//@property (nonatomic, strong) UIView *bgViewBack;

@property (nonatomic, assign) CGFloat cornerRadius;


@end

NS_ASSUME_NONNULL_END
