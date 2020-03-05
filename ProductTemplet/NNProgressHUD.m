//
//  NNProgressHUD.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/7/6.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNProgressHUD.h"
#import "MBProgressHUD.h"

@implementation NNProgressHUD

+ (void)showText:(NSString *)text mode:(MBProgressHUDMode)mode imageName:(NSString *)imageName isHide:(BOOL)isHide inView:(UIView *)view {
//    MBProgressHUD *hud;
//    if (view) {
//        [MBProgressHUD hideHUDForView:view animated:true];
//        hud = [MBProgressHUD showHUDAddedTo:view animated:true];
//    } else {
//        [MBProgressHUD hideHUDForView:UIApplication.sharedApplication.keyWindow animated:true];
//        hud = [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:true];
//    }
    
    view = view ? : UIApplication.sharedApplication.keyWindow;
    [MBProgressHUD hideHUDForView:view animated:true];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:true];
    
    hud.userInteractionEnabled = !isHide; //自动隐藏的，不响应事件
//    hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];

    hud.minSize = mode == MBProgressHUDModeAnnularDeterminate ? CGSizeMake(90, 90) : CGSizeMake(130, 130);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = UIColorHexValueAlpha(0x000000, 0.5);
    hud.bezelView.layer.cornerRadius = 4;
    hud.backgroundView.backgroundColor = [UIColor clearColor];
    
    // 显示模式,改成customView,即显示自定义图片(mode设置,必须写在customView赋值之前)
    hud.mode = MBProgressHUDModeCustomView;
    if (imageName.length) {
        // 设置要显示 的自定义的图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        if (mode == MBProgressHUDModeAnnularDeterminate) {
            CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
            animation.fromValue = [NSNumber numberWithFloat:0.f];
            animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
            animation.duration  = 1;
            animation.autoreverses = false;
            animation.fillMode = kCAFillModeForwards;
            animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
            [hud.customView.layer addAnimation:animation forKey:nil];
        }
        if (text.length) {
            hud.label.text = @"placeholder";
            hud.label.hidden = true;
            hud.label.font = [UIFont systemFontOfSize:7.3];
        }
    }
    // 显示的文字,比如:加载失败...加载中...
    hud.detailsLabel.text = text;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    // 标志:必须为true,才可以隐藏,  隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = true;
    
    if (isHide) {
        [hud hideAnimated:true afterDelay:1.5];
    }
}

+ (void)showText:(NSString *)text centerY:(CGFloat)centerY{
    UIView * view = UIApplication.sharedApplication.keyWindow;
    [MBProgressHUD hideHUDForView:view animated:true];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:true];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    // Move to bottm center.
    centerY = centerY > 0.0 ? centerY : MBProgressMaxOffset;
    hud.offset = CGPointMake(0.f, centerY);
    [hud hideAnimated:true afterDelay:1.5];
}

+ (void)showText:(NSString *)text{
    UIView *view = UIApplication.sharedApplication.keyWindow;
    [NNProgressHUD showText:text centerY:view.center.y];
}

+ (void)showLoadingText:(NSString *)text inView:(UIView *)inView{
    [NNProgressHUD showText:text mode:MBProgressHUDModeAnnularDeterminate imageName:@"toast_loading" isHide:false inView:inView];
}

+ (void)showLoadingText:(NSString *)text{
    [NNProgressHUD showLoadingText:text inView:nil];
}

+ (void)showSuccessText:(NSString *)text inView:(UIView *)inView{
    [NNProgressHUD showText:text mode:MBProgressHUDModeCustomView imageName:@"toast_success" isHide:true inView:inView];
}

+ (void)showSuccessText:(NSString *)text{
    [NNProgressHUD showSuccessText:text inView:nil];
}

+ (void)showErrorText:(NSString *)text inView:(UIView *)inView{
    [NNProgressHUD showText:text mode:MBProgressHUDModeCustomView imageName:@"toast_error" isHide:true inView:inView];
}

+ (void)showErrorText:(NSString *)text{
    [NNProgressHUD showErrorText:text inView:nil];
}

+ (void)dismissInView:(UIView *)view{
    view = view ? : UIApplication.sharedApplication.keyWindow;
    [MBProgressHUD hideHUDForView:view animated:true];
}

+ (void)dismiss{
    [MBProgressHUD hideHUDForView:UIApplication.sharedApplication.keyWindow animated:true];
}

@end

