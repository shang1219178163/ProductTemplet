//
//  UIScreenEdgePanView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/4.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIScreenEdgePanView.h"

@implementation UIScreenEdgePanView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(UIView *)showView{
    if (!_showView) {
        _showView = ({
            UIView * view = [[UIView alloc]initWithFrame:self.bounds];
            view.backgroundColor = UIColor.redColor;
            view.alpha = .5;
            view;
        });
    }
    return _showView;
}

@end
