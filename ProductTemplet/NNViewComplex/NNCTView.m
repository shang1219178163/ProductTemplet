//
//  NNCollectionView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/19.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NNCTView.h"

@implementation NNCTView

/**************************************************
 http://www.jianshu.com/p/420f9dc78c04
 question:
 当tableView被 父控件(scrollView或其子类) 所包含时,当tableView滑动到顶部时,
 再次下拉滑动tableView时,scrollView会其联动
 --------------------------------------------------
 answer:
 通过相应者链,获取父控件(scrollView或其子类)对象,修改其'scrollEnabled'属性,解除联动
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    //使用相应者链解决
    UIResponder *responder = [self nextResponder];
    UIScrollView *scrollView = nil;
    //responder==nil:说明tableView未被scrollView包含 scrollView!=nil:说明按照条件获取到父控件(scrollView或其子类)对象
    while (responder && scrollView == nil){
        //如果是父控件(scrollView或其子类)就返回,说明tableview被scrollView包含关系
        if ([responder isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)responder;
        }
        else {
            //根据响应者链去获取下一个相应者对象
            responder = [responder nextResponder];
        }
    }
    
    //scrollView为空时不会发送消息
    if (view) { //当view!=nil时,(view类型为UITableViewCellContentView)需要关闭响应者链中scrollView滑动手势
        scrollView.scrollEnabled = NO;
    }
    else { //当view==nil时,说明手势操作不是tableView发出的
        scrollView.scrollEnabled = YES;
    }
    return view;
}

@end
