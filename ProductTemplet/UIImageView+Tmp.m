//
//  UIImageView+Tmp.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/11/19.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIImageView+Tmp.h"

@implementation UIImageView (Tmp)

-(void)showImageEnlarge{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_enlargeImageView:)];
    self.userInteractionEnabled = YES;
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
//    [self enlargeImageView:tap];
}

-(void)p_enlargeImageView:(UITapGestureRecognizer *)tapAvatar{
    UIWindow *window = UIApplication.sharedApplication.keyWindow;

    UIImageView *avatarImageView = (UIImageView *)tapAvatar.view;
    CGRect oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
        
    UIImage *image = avatarImageView.image;
    UIImageView *imageView = ({
        UIImageView *view = [[UIImageView alloc]initWithFrame:oldframe];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.image = image;
        view.tag = 1001;
        view;
    });
    
    UIView *backgroundView = ({
        UIView *view = [[UIView alloc]initWithFrame:window.bounds];
        view.backgroundColor = UIColor.blackColor;
        view.alpha = 0;
        view.tag = 1000;
        view;
    });
    [backgroundView addSubview:imageView];
    [window insertSubview:backgroundView atIndex:1];
    //
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_hideImageView:)];
    [backgroundView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.15 animations:^{
        imageView.frame = window.bounds;
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)p_hideImageView:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
    
    [UIView animateWithDuration:0.15 animations:^{
        backgroundView.alpha = 0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [backgroundView removeFromSuperview];
        }
    }];
}

@end
