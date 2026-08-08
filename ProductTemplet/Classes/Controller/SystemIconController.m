//
//  SystemIconController.m
//  ProductTemplet
//
//  Created by BIN on 2026/8/8.
//  Copyright © 2026 BN. All rights reserved.
//

#import "SystemIconController.h"
#import "ProductTemplet-Swift.h"

@interface SystemIconController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSString *> *allNames;
@property (nonatomic, copy) NSArray<NSString *> *filteredNames;

@end

@implementation SystemIconController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    if (self.title.length == 0) {
        self.title = @"系统图标";
    }

    self.allNames = UIImage.allSystemIconNames ?: @[];
    self.filteredNames = self.allNames;

    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self updateTitleCount];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat searchH = 56;
    self.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), searchH);
    self.tableView.frame = CGRectMake(0, searchH, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - searchH);
}

- (void)updateTitleCount {
    self.title = [NSString stringWithFormat:@"系统图标 (%@/%@)", @(self.filteredNames.count), @(self.allNames.count)];
}

- (void)applyFilter:(NSString *)keyword {
    NSString *key = [[keyword ?: @"" stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] lowercaseString];
    if (key.length == 0) {
        self.filteredNames = self.allNames;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *name, NSDictionary *bindings) {
            return [[name lowercaseString] containsString:key];
        }];
        self.filteredNames = [self.allNames filteredArrayUsingPredicate:predicate];
    }
    [self updateTitleCount];
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self applyFilter:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self applyFilter:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [self applyFilter:@""];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SystemIconCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.font = [UIFont monospacedSystemFontOfSize:11 weight:UIFontWeightRegular];
        cell.detailTextLabel.textColor = UIColor.secondaryLabelColor;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    NSString *name = self.filteredNames[indexPath.row];
    cell.textLabel.text = name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"#%@", @(indexPath.row + 1)];
    UIImage *image = [UIImage systemImageNamed:name];
    cell.imageView.image = image ?: [UIImage systemImageNamed:@"questionmark.square"];
    cell.imageView.tintColor = UIColor.labelColor;
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

#pragma mark - lazy

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.placeholder = @"搜索图标名（忽略大小写）";
        _searchBar.delegate = self;
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.showsCancelButton = YES;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 56;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

@end
