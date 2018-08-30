//
//  UIImage+Helper.h
//  HuiZhuBang
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageRotatedByDegrees:(CGFloat)degrees image:(UIImage *)image;

- (UIImage *)normalizedImage;

- (UIImage *)fixOrientation;

- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;


/**
 
 区别:
 效果:第一种Core Image设置模糊之后会在周围产生白边，vImage使用不存在任何问题；
 性能:图像模糊处理属于复杂的计算，大部分图片模糊选择的是vImage，性能最佳
 
 Core Image是苹果提供的一个相当强大专门用于处理图片的库。稍微试了一下，不仅能实现毛玻璃效果，还能实现很多其他的效果。但是，在使用过程中发现使用Core Image来实现这些效果，非常占用内存。查看文档:createCGImage:outputImage : fromRect:方法会单独开辟一个临时的缓存区，出现离屏渲染，这可能是一个使得内存增大的重要原因。
 
 *  CoreImage图片高斯模糊
 *
 *  @param image 图片
 *  @param blur  模糊数值(默认是10)
 *
 *  @return 重新绘制的新图片
 */

+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/**
 *  vImage模糊图片(推荐)
 *
 *  @param image 原始图片
 *  @param blur  模糊数值(0-1)
 *
 *  @return 重新绘制的新图片
 */
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

- (BOOL)isEquelImgName:(NSString *)imageName;

@end
