//
//  ObjCHigherOrderController.m
//  ProductTemplet
//
//  Created by BIN on 2026/8/8.
//  Copyright © 2026 BN. All rights reserved.
//

#import "ObjCHigherOrderController.h"

@interface ObjCHigherOrderController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *allItems;
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *filteredItems;

@end

@implementation ObjCHigherOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    if (self.title.length == 0) {
        self.title = @"ObjC 高阶函数";
    }

    self.allItems = [self buildSamples];
    self.filteredItems = self.allItems;

    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self updateTitleCount];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat searchH = 56;
    self.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), searchH);
    self.tableView.frame = CGRectMake(0,
                                      searchH,
                                      CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(self.view.bounds) - searchH);
}

- (void)updateTitleCount {
    self.title = [NSString stringWithFormat:@"ObjC 高阶函数 (%@/%@)",
                  @(self.filteredItems.count),
                  @(self.allItems.count)];
}

- (void)applyFilter:(NSString *)keyword {
    NSString *key = [[keyword ?: @"" stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] lowercaseString];
    if (key.length == 0) {
        self.filteredItems = self.allItems;
    } else {
        self.filteredItems = [self.allItems filter:^BOOL(NSArray<NSString *> *obj, NSUInteger idx) {
            NSString *title = obj.count > 0 ? obj[0] : @"";
            NSString *detail = obj.count > 1 ? obj[1] : @"";
            NSString *joined = [[NSString stringWithFormat:@"%@ %@", title, detail] lowercaseString];
            return [joined containsString:key];
        }];
    }
    [self updateTitleCount];
    [self.tableView reloadData];
}

#pragma mark - Samples (NSArray+Helper / NSDictionary+Helper)

- (NSArray<NSArray<NSString *> *> *)buildSamples {
    NSArray<NSNumber *> *nums = @[@1, @2, @3, @4, @5, @6];
    NSArray<NSString *> *words = @[@"Swift", @"map", @"Filter", @"reduce", @"swift"];

    NSArray *mapped = [nums map:^id(NSNumber *obj, NSUInteger idx) {
        return @(obj.integerValue * 2);
    }];
    NSArray *filtered = [nums filter:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.integerValue % 2 == 0;
    }];
    NSNumber *reduced = [nums reduce:@(0) transform:^NSNumber *(NSNumber *result, NSNumber *obj) {
        return @(result.integerValue + obj.integerValue);
    }];
    NSArray *compact = [@[@"a", [NSNull null], @"b", [NSNull null], @"c"] compactMap:^id(id obj, NSUInteger idx) {
        return [obj isKindOfClass:NSNull.class] ? nil : obj;
    }];
    // compactMap：返回 NSArray 时自动降维展平
    NSArray *flat = [@[ @[@1, @2], @[@3], @[@4, @5] ] compactMap:^id(NSArray *obj, NSUInteger idx) {
        return obj;
    }];

    NSArray *sorted = [words sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
        return [[a lowercaseString] compare:[b lowercaseString]];
    }];

    NSArray *indexed = [nums map:^id(NSNumber *obj, NSUInteger idx) {
        return [NSString stringWithFormat:@"%@:%@", @(idx), obj];
    }];

    // groupBy first letter
    NSMutableDictionary *grouped = [NSMutableDictionary dictionary];
    [words forEach:^(NSString *obj, NSUInteger idx) {
        NSString *key = obj.length ? [[obj lowercaseString] substringToIndex:1] : @"#";
        NSMutableArray *bucket = grouped[key];
        if (!bucket) {
            bucket = [NSMutableArray array];
            grouped[key] = bucket;
        }
        [bucket addObject:obj];
    }];

    // chunked into 2
    NSMutableArray *chunked = [NSMutableArray array];
    for (NSUInteger i = 0; i < nums.count; i += 2) {
        NSRange range = NSMakeRange(i, MIN((NSUInteger)2, nums.count - i));
        [chunked addObject:[nums subarrayWithRange:range]];
    }

    // uniqued lowercase
    NSMutableArray *uniqued = [NSMutableArray array];
    NSMutableSet *seen = [NSMutableSet set];
    [words forEach:^(NSString *obj, NSUInteger idx) {
        NSString *lower = obj.lowercaseString;
        if (![seen containsObject:lower]) {
            [seen addObject:lower];
            [uniqued addObject:lower];
        }
    }];

    BOOL anyOdd = [nums filter:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.integerValue % 2 != 0;
    }].count > 0;
    BOOL allPositive = [nums filter:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.integerValue > 0;
    }].count == nums.count;

    NSNumber *firstWhere = [[nums filter:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.integerValue > 3;
    }] firstObject];
    BOOL contains4 = [nums filter:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.integerValue == 4;
    }].count > 0;

    NSDictionary *dict = @{@"a": @1, @"b": @2, @"c": @3};
    NSDictionary *mappedKeys = [dict map:^NSDictionary *(NSString *key, NSNumber *obj) {
        return @{[key uppercaseString]: obj};
    }];

    NSString *opt = @"hello";
    if (opt.length > 3) {
        opt = opt.uppercaseString;
    } else {
        opt = @"nil";
    }

    return @[
        @[@"map", @"映射变换", [NSString stringWithFormat:@"%@ → %@", nums, mapped]],
        @[@"filter", @"条件过滤", [NSString stringWithFormat:@"%@ → %@", nums, filtered]],
        @[@"reduce", @"归约累计", [NSString stringWithFormat:@"%@ → %@", nums, reduced]],
        @[@"compactMap", @"映射并去掉 nil/NSNull", [NSString stringWithFormat:@"→ %@", compact]],
        @[@"compactMap (flatten)", @"展平二维", [NSString stringWithFormat:@"→ %@", flat]],
        @[@"sortedArrayUsingComparator", @"排序（忽略大小写）", [NSString stringWithFormat:@"%@ → %@", words, sorted]],
        @[@"map (idx)", @"带下标 map", [NSString stringWithFormat:@"→ %@", indexed]],
        @[@"forEach + group", @"按首字母分组", [NSString stringWithFormat:@"→ %@", grouped]],
        @[@"chunked", @"分块", [NSString stringWithFormat:@"→ %@", chunked]],
        @[@"uniqued", @"去重保序", [NSString stringWithFormat:@"→ %@", uniqued]],
        @[@"any / all", @"存在 / 全部满足", [NSString stringWithFormat:@"anyOdd=%@, allPositive=%@", @(anyOdd), @(allPositive)]],
        @[@"Optional-like", @"有值且满足则变换", [NSString stringWithFormat:@"→ %@", opt]],
        @[@"Dictionary map", @"字典 key 变换", [NSString stringWithFormat:@"→ %@", mappedKeys]],
        @[@"forEach", @"遍历副作用", @"[nums forEach:^(id obj, NSUInteger idx){ ... }]"],
        @[@"filter + firstObject", @"首个匹配", [NSString stringWithFormat:@"%@", firstWhere]],
        @[@"filter + count", @"是否存在", [NSString stringWithFormat:@"%@", @(contains4)]],
    ];
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
    return self.filteredItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ObjCHigherOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
        cell.textLabel.numberOfLines = 1;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = UIColor.secondaryLabelColor;
        cell.detailTextLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray<NSString *> *item = self.filteredItems[indexPath.row];
    cell.textLabel.text = item.count > 0 ? item[0] : @"";
    NSString *detail = item.count > 1 ? item[1] : @"";
    NSString *result = item.count > 2 ? item[2] : @"";
    cell.detailTextLabel.text = result.length ? [NSString stringWithFormat:@"%@\n%@", detail, result] : detail;
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

#pragma mark - lazy

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.placeholder = @"搜索函数名（忽略大小写）";
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
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 72;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

@end
