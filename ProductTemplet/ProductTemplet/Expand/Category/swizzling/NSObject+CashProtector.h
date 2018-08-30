//
//  NSObject+CashProtector.h
//  ChildViewControllers
//
//  Created by BIN on 2017/12/4.
//  Copyright © 2017年 BIN. All rights reserved.
//

/**
 此类别只负责处理崩溃;其余功能处理,请在别处
 此类需要-fno-objc-arc支持不然会出现崩溃
 [UIKeyboardLayoutStar release]: message sent to deallocated instanc
 
 
 崩溃原因是替换了NSMutableArray 的objectAtIndex：（ NSMutableArray和 NSArray 的objectAtIndex：都有替换，单独替换 NSArray 的objectAtIndex：方法则不会引起crash）
 */

#import <Foundation/Foundation.h>

#define isOpenCashProtector  1

#define isOpenAssert         1
//isOpenAssert配合异常断点一起使用(自动定位到崩溃位置)

@interface NSObject (CashProtector)

+(BOOL)swizzleMethodClass:(Class)clz origMethod:(SEL)origSelector newMethod:(SEL)newSelector;

@end


@interface NSMutableDictionary (CashProtector)


@end


@interface NSArray (CashProtector)


@end


@interface NSMutableArray (CashProtector)


@end
