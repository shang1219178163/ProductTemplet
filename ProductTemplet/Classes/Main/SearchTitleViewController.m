//
//  SearchTitleViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/8.
//  Copyright © 2019 BN. All rights reserved.
//

#import "SearchTitleViewController.h"
#import "UISearchBar+Helper.h"
#import "UIApplication+Tmp.h"

@interface SearchTitleViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation SearchTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [UIApplication setupAppearanceSearchbarCancellButton];
    self.searchBar = ({
        UISearchBar *searchBar = [UISearchBar createRect:CGRectMake(0, 0, kScreenWidth - 100, 30)];
        searchBar.placeholder = @"请输入流水号、商品信息或会员信息";        
        searchBar.delegate = self;
//        searchBar.scopeButtonTitles = @[@"111", @"22", @"333"];
//        searchBar.showsScopeBar = true;
//        searchBar.showsBookmarkButton = true;
        searchBar;
    });

    //Set to titleView
    self.navigationItem.titleView = ({
        UIView *titleView = [[UIView alloc]initWithFrame:self.searchBar.bounds];
        //UIColor *color =  self.navigationController.navigationBar.tintColor;
        //[titleView setBackgroundColor:color];
        [titleView addSubview:self.searchBar];

        titleView;
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    
    CGRect rect = CGRectMake(20, 20, kScreenWidth - 40, 40);
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems: @[@"昨天", @"今天", @"明天"]];
    control.frame = rect;
    [self.view addSubview: control];
}

#pragma mark -UISearchBar

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return true;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return true;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    DDLog(@"%@1", searchBar.text);
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    DDLog(@"%@", searchBar.text);

    return true;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    DDLog(@"%@", searchBar.text);

}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    DDLog(@"%@", searchBar.text);

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    DDLog(@"%@", searchBar.text);

}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    DDLog(@"%@", searchBar.text);

}

#pragma mark - lazy

//- (UISearchBar *)searchBar{
//    if (!_searchBar) {
//        _searchBar = ({
//            UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 30)];
//            searchBar.layer.cornerRadius = 15;
//            searchBar.layer.masksToBounds = YES;
//            //设置背景图是为了去掉上下黑线
//            searchBar.backgroundImage = [[UIImage alloc] init];
//            //searchBar.backgroundImage = [UIImage imageNamed:@"sexBankgroundImage"];
//            // 设置SearchBar的主题颜色
//            //searchBar.barTintColor = [UIColor colorWithRed:111 green:212 blue:163 alpha:1];
//            //设置背景色
//            searchBar.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1];
//
//            searchBar.barStyle = UIBarStyleDefault;
//            searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
//            //searchBar.searchBarStyle = UISearchBarStyleMinimal;
//            //没有背影，透明样式
//            // 修改cancel
//            // 修改cancel
//            [searchBar setValue:@"取消" forKey:@"cancelButtonText"];
//            searchBar.showsCancelButton = true;
////            searchBar.showsSearchResultsButton = true;
//            //5. 设置搜索Icon
//            //        [searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//            searchBar;
//        });
//    }
//    return _searchBar;
//}

@end
