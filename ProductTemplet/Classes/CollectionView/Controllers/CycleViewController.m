//
//  ViewController.m
//  NNCycleScrollView
//
//  Created by bjovov on 2017/11/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CycleViewController.h"
#import "NNCycleScrollView.h"

@interface CycleViewController ()<NNCycleScrollViewDelegate>

@property (nonatomic,strong) NNCycleScrollView *horScrollView;
@property (nonatomic,strong) NNCycleScrollView *verScrollView;

@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"循环滚动式视图";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self setScrollView];
//    [self setVerScrollView];
    
    NSArray *urlArray = @[@"http://upload-images.jianshu.io/upload_images/1714291-6c664d526b380115.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/700",
                          @"http://upload-images.jianshu.io/upload_images/6486956-a0c75e83255105c9?imageMogr2/auto-orient/strip%7CimageView2/2/w/583",
                          @"http://upload-images.jianshu.io/upload_images/3580598-482508548410c111.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    self.horScrollView.imageArray = urlArray;
    [self.view addSubview:self.horScrollView];
    //
    NSArray *imageArray = @[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"2"]];
    self.verScrollView.imageArray = imageArray;
    [self.view addSubview:self.verScrollView];
    
    [self.view getViewLayer];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.horScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(200);
    }];

    [self.verScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horScrollView.bottom).offset(20);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(200);
    }];
    
}

- (void)setScrollView{
    NSArray *urlArray = @[@"http://upload-images.jianshu.io/upload_images/1714291-6c664d526b380115.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/700",
                          @"http://upload-images.jianshu.io/upload_images/6486956-a0c75e83255105c9?imageMogr2/auto-orient/strip%7CimageView2/2/w/583",
                          @"http://upload-images.jianshu.io/upload_images/3580598-482508548410c111.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    _horScrollView = [[NNCycleScrollView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.bounds), 200)];
    _horScrollView.imageArray = urlArray;
    _horScrollView.delegate = self;
    [self.view addSubview:_horScrollView];
}

- (void)setVerScrollView{
    NSArray *imageArray = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"2"]];
    _verScrollView = [[NNCycleScrollView alloc]initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), 200)];
    _verScrollView.direction = UICollectionViewScrollDirectionVertical;
    _verScrollView.imageArray = imageArray;
    _verScrollView.delegate = self;
    _verScrollView.blockDidSelectedIndex = ^(NSInteger index) {
        NSLog(@"___第%ld个",index);

    };
    [self.view addSubview:_verScrollView];
}

#pragma mark - CarouselScrollViewDelegate
- (void)didSelectedIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个",index);
}

#pragma mark -lazy

-(NNCycleScrollView *)horScrollView{
    if (!_horScrollView) {
        _horScrollView = ({
            NNCycleScrollView *view = [[NNCycleScrollView alloc]initWithFrame:CGRectZero];
            view.delegate = self;
            
            view;
        });
    }
    return _horScrollView;
}

- (NNCycleScrollView *)verScrollView{
    if (!_verScrollView) {
        _verScrollView = ({
            NNCycleScrollView *view = [[NNCycleScrollView alloc]initWithFrame:CGRectZero];
            view.direction = UICollectionViewScrollDirectionVertical;
            view.delegate = self;
            view.blockDidSelectedIndex = ^(NSInteger index) {
                NSLog(@"___第%ld个",index);
                
            };
            
            view;
        });
    }
    return _verScrollView;
}

@end
