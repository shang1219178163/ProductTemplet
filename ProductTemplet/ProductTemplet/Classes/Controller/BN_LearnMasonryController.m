//
//  BN_UserLoginController.m
//  
//
//  Created by BIN on 2018/5/3.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "BN_LearnMasonryController.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface BN_LearnMasonryController ()

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView * viewA;
@property (nonatomic, strong) UIView * viewB;
@property (nonatomic, strong) UIView * viewC;

@property (nonatomic, strong) UIView * containerView;

@end

@implementation BN_LearnMasonryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
//    [self createControls];
//    [self configureScrollView];
//    [self makeConstraintsScrollView];
    
    
    self.dataList = @[@"",@"",@"",].mutableCopy;

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = 80;

    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
        
}

#pragma mark - -UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewZeroCell *cell = [UITableViewZeroCell cellWithTableView:tableView];
    cell.imgViewLeft.image = [UIImage imageNamed:@"bug.png"];
    cell.labelLeft.text = [NSString stringWithFormat:@"row_%@",@(indexPath.row)];

    return cell;
}

- (void)createControls{
    //1.首先，创建视图控件，添加到self.view上

    [self.view addSubview:self.viewA];
    [self.view addSubview:self.viewB];
    [self.view addSubview:self.viewC];

    //3.接着，添加约束
    
    //先确定view_1的约束
    [self.viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20); //view_1的上，距离self.view是30px
        make.left.equalTo(self.view.mas_left).with.offset(20); //view_1de左，距离self.view是30px
    }];
    
    //然后确定view_2的约束
    [self.viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewA.mas_centerY).with.offset(0); //view2 Y方向上的中心线和view_1相等
        make.left.equalTo(self.viewA.mas_right).with.offset(20); //view2 的左距离view_1的右距离为30px
        make.right.equalTo(self.view.mas_right).with.offset(-20); //view_2的右距离self.view30px
        make.width.height.equalTo(self.viewA); //view_2的和view_1相等
    }];
    
    //最后确定view_3的约束
    [self.viewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewA.mas_bottom).with.offset(20); //view_3的上距离view_1的底部 30px
//        make.left.equalTo(self.view.mas_left).with.offset(20); //view_3的左距离self.view 30px
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);//view_3的底部距离self.view 30px
//        make.right.equalTo(self.view.mas_right).with.offset(-20); //view_3的右距离self.view 30px
        
        make.left.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(40, 40, 40, 40));
        make.height.equalTo(self.viewA);//view_3的高度和view_1相等
    }];

}

- (void)configureScrollView{
    
    // 提前设置好UIScrollView的contentSize，并设置UIScrollView自身的约束
    self.scrollView.contentSize = CGSizeMake(1000, 1000);
    [self.view addSubview:self.scrollView];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        
    }];
    
    [self.scrollView addSubview:self.viewA];
    [self.viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView).with.offset(20);
        make.width.height.equalTo(150);

    }];
    
    [self.scrollView addSubview:self.viewB];
    [self.viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewA);
        make.left.equalTo(self.viewA.mas_right).with.offset(20);
        make.width.height.equalTo(self.viewA);

    }];

    [self.scrollView addSubview:self.viewC];
    [self.viewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewA.mas_bottom).with.offset(20);
        make.left.equalTo(self.viewA);
        make.width.height.equalTo(self.viewA);

    }];
    
}

- (void)makeConstraintsScrollView{
    
    CGFloat padding = 15;
    
    // 在进行约束的时候，要对containerView的上下左右都添加和子视图的约束，以便确认containerView的边界区域。
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
        
    [self.scrollView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView).insets(UIEdgeInsetsMake(padding, padding, padding, padding));
    }];
    
    [self.containerView addSubview:self.viewA];
    [self.viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.containerView).offset(padding);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
    
    [self.containerView addSubview:self.viewB];
    [self.viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(padding);
        make.left.equalTo(self.viewA.mas_right).offset(padding);
        make.size.equalTo(self.viewA);
        make.right.equalTo(self.containerView).offset(-padding);
    }];

    [self.containerView addSubview:self.viewC];
    [self.viewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(padding);
        make.top.equalTo(self.viewB.mas_bottom).offset(padding);
        make.size.equalTo(self.viewB);
        make.bottom.equalTo(self.containerView).offset(-padding);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - layz

-(UIView *)viewA{
    if (!_viewA) {
        _viewA  =  ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = UIColor.redColor;
            
            view;
        });
    }
    return _viewA;
}

-(UIView *)viewB{
    if (!_viewB) {
        _viewB  =  ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = UIColor.greenColor;
            
            view;
        });
    }
    return _viewB;
}

-(UIView *)viewC{
    if (!_viewC) {
        _viewC  =  ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = UIColor.yellowColor;
            
            view;
        });
    }
    return _viewC;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
            scrollView.backgroundColor = UIColor.cyanColor;
            scrollView.pagingEnabled = YES;
            scrollView.delegate = self;
            
            scrollView;
        });
        
    }
    return _scrollView;
}

-(UIView *)containerView{
    if (!_containerView) {
        _containerView  =  ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = UIColor.orangeColor;
            
            view;
        });
    }
    return _containerView;
}

@end
