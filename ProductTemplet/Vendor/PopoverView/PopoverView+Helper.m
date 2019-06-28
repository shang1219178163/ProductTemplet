
//
//  PopoverView+Helper.m
//  AccessControlSystem
//
//  Created by Bin Shang on 2019/6/28.
//  Copyright © 2019 irain. All rights reserved.
//

#import "PopoverView+Helper.h"

@implementation PopoverView (Helper)

//+ (void)showView:(UIView *)view list:(NSArray<NSString *> *)list handler:(void (^)(PopoverAction *action))handler {
//    
//    __block NSMutableArray * marr = [NSMutableArray array];
//    [list enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        PopoverAction *action = [PopoverAction actionWithTitle:obj handler:handler];
//        [marr addObject:action];
//    }];
//    PopoverView *popoverView = [PopoverView popoverView];
//    //    popoverView.style = PopoverViewStyleDark;
//    //    popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
//    
//    if ([NSThread isMainThread]) {
//        [popoverView showToView:view withActions:marr.copy];
//
//    } else {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [popoverView showToView:view withActions:marr.copy];
//
//        });
//    }
//}

+ (void)showView:(UIView *)view list:(NSArray<PopoverItemModel *> *)list handler:(void (^)(PopoverAction *action, PopoverItemModel *model))handler {
    
//    assert(list.firstObject.index != nil && ![list.firstObject.index isEqualToString:@""]);
    NSAssert(list.firstObject.index != nil && ![list.firstObject.index isEqualToString:@""], @"index属性不能为空,作为数组排序用,传数字即可");
    NSSortDescriptor * sorter = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:true];
    list = [list sortedArrayUsingDescriptors:@[sorter]];
    
    __block NSMutableArray * marr = [NSMutableArray array];
    [list enumerateObjectsUsingBlock:^(PopoverItemModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.hidden) {
            return;
        }
        
        if (obj.image) {
            PopoverAction *action = [PopoverAction actionWithImage:obj.image title:obj.title handler:^(PopoverAction *action) {
                if (handler) {
                    handler(action, obj);
                }
            }];
            [marr addObject:action];

        } else {
            PopoverAction *action = [PopoverAction actionWithTitle:obj.title handler:^(PopoverAction *action) {
                if (handler) {
                    handler(action, obj);
                }
            }];
            [marr addObject:action];
            
        }
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    //    popoverView.style = PopoverViewStyleDark;
    //    popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
    
    if ([NSThread isMainThread]) {
        [popoverView showToView:view withActions:marr.copy];
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [popoverView showToView:view withActions:marr.copy];
            
        });
    }
}

@end

@implementation PopoverItemModel

@end
