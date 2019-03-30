//
//  BNImageView.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/20.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNImageView.h"
#include <mach/mach_time.h>

@implementation BNImageView

static const CGRect imageRect = {{0, 0}, {100, 100}};

-(void)setImage:(UIImage *)image{
    _image = image;
    if (!_image) {
        UIGraphicsBeginImageContextWithOptions(imageRect.size, YES, 0);
        [_image drawInRect:imageRect];
        _image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (CGRectEqualToRect(rect, imageRect)) {
        uint64_t start = mach_absolute_time();

        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, 100);
        CGContextScaleCTM(context, 1, -1);
        CGContextDrawImage(context, imageRect, _image.CGImage);
        
        uint64_t drawTime = mach_absolute_time() - start;
        NSLog(@"drawTime_%@",@(drawTime));
    }
   
}


@end
