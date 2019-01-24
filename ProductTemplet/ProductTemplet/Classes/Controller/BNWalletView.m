//
//  BNWalletView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/19.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNWalletView.h"

@interface BNWalletView()

@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation BNWalletView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 20;
        _numberOfRow = 3;
        _duration = 0.05;
        
        for (NSInteger i = 0; i < 3; i++) {
            UIView * view = [[NSClassFromString(@"UILabel") alloc]init];
            if ([view isKindOfClass:UILabel.class]) {
                ((UILabel *)view).text = [@(i) stringValue];
            }
            view.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
            view.backgroundColor = UIColor.randomColor;
            view.tag = i;
            [view addGestureTap:^(UIGestureRecognizer *sender) {
                if (self.block) {
                    self.block(self, sender.view);
                }
            }];
            
            [view addGestureRecognizer:[self addPan]];
            
            [self addSubview:view];
            [self.itemList addObject:view];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    switch (self.type.integerValue) {
        case 1:
            [self setupConstraintDefault];

            break;
        case 2:
            [self setupConstraintReverse];

            break;
        default:
            [self setupConstraintFromBottom];
            break;
    }
}

- (void)setupConstraintFromBottom{
    CGFloat width = CGRectGetWidth(self.bounds) - _padding*(_itemList.count - 1)*2;
    CGFloat height = CGRectGetHeight(self.bounds) - _padding*(_itemList.count - 1);
    [_itemList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            obj.frame = CGRectMake(_padding*(_itemList.count - 1), _padding*(_itemList.count - 1), width, height);
        }
        [UIView animateWithDuration:_duration animations:^{
//            obj.frame = CGRectMake(_padding*idx, _padding*idx, width, height);
            obj.frame = CGRectMake(_padding*(_itemList.count - 1 - idx), _padding*(_itemList.count - 1 - idx), width + _padding*idx*2, height);
            
        }];
    }];
}

- (void)setupConstraintReverse{
    CGFloat width = CGRectGetWidth(self.bounds) - _padding*(_itemList.count - 1);
    CGFloat height = CGRectGetHeight(self.bounds) - _padding*(_numberOfRow - 1);
    [_itemList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            obj.frame = CGRectMake(_padding*(_itemList.count - 1), _padding*(_itemList.count - 1), width, height);
        }
        [UIView animateWithDuration:_duration animations:^{
            obj.frame = CGRectMake(_padding*(_itemList.count - 1 - idx), _padding*(_itemList.count - 1 - idx), width, height);

        }];
    }];
}

- (void)setupConstraintDefault{
    CGFloat width = CGRectGetWidth(self.bounds) - _padding*(_itemList.count - 1);
    CGFloat height = CGRectGetHeight(self.bounds) - _padding*(_itemList.count - 1);
    [_itemList enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            obj.frame = CGRectMake(0, 0, width, height);
        }
        [UIView animateWithDuration:_duration animations:^{
            obj.frame = CGRectMake(_padding*idx, _padding*idx, width, height);

        }];
    }];
}

-(UIPanGestureRecognizer *)addPan{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionGesture:)];
    recognizer.minimumNumberOfTouches = 1;
    recognizer.maximumNumberOfTouches = 3;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
//    [self addGestureRecognizer:recognizer];
    
    return recognizer;
}

- (void)handleActionGesture:(UIGestureRecognizer *)sender{
    if ([self.itemList indexOfObject:sender.view] == self.itemList.count - 1) {
        UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *)sender;
        switch (recognizer.state) {
            case UIGestureRecognizerStateBegan:
            {
                _origin = recognizer.view.center;

            }
                break;
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled:
            {
//                if (sender.view.center.x > CGRectGetMinX(recognizer.view.superview.frame) && sender.view.center.x < CGRectGetMaxX(recognizer.view.superview.frame)) {
                if (fabs(sender.view.center.x - CGRectGetMidX(recognizer.view.superview.frame)) < 50) {
                    [UIView animateWithDuration:0.5 animations:^{
                        sender.view.center = self.origin;
                        
                    }];
                    return ;
                }
                
                [self insertSubview:sender.view atIndex:0];
                [self.itemList removeObject:sender.view];
                [self.itemList insertObject:sender.view atIndex:0];
                
                [self setNeedsLayout];

            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                CGPoint translate = [recognizer translationInView:recognizer.view.superview];
                sender.view.center = CGPointMake(sender.view.center.x + translate.x, sender.view.center.y +translate.y);
                [recognizer setTranslation:CGPointZero inView:recognizer.view.superview];
                
            }
                break;
            default:
                break;
        }
    }
}

- (NSMutableArray *)itemList{
    if (!_itemList) {
        _itemList = [NSMutableArray array];
    }
    return _itemList;
}

- (UILabel *)createLabelRect:(CGRect)rect text:(NSString *)text tag:(NSInteger)tag{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.tag = tag;
    label.backgroundColor = UIColor.themeColor;
    
    return label;
}


@end
