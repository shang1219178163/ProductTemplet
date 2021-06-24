//
//  TestViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/4.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "TestViewController.h"
#import "WHKNetInfoFeedModel.h"
#import "NSArray+Tmp.h"
#import "NSDictionary+Tmp.h"
#import "UIImageView+Tmp.h"
#import "Person.h"

@interface TestViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *list = [@[@"登录", @"设置", @"定时器",] map:^id _Nonnull(NSString * obj, NSUInteger idx) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:obj style:UIBarButtonItemStylePlain target:self action:@selector(handleActionItem:)];
        item.tag = idx;
        return item;
    }];
    self.navigationItem.rightBarButtonItems = list;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    imgView.image = [UIImage imageNamed:@"parkingOne"];
    [self.view addSubview:imgView];

    [imgView showImageEnlarge];
    
    [self enumerateModel];
//    [self.view getViewLayer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self funtionMore];
    [self funtionMoreDic];

//    CFUUIDRef uuid = CFUUIDCreate(NULL);
//    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
//    NSString *uniqueIdentifier = [NSString stringWithFormat:@"%@", uuidStr];
//    DDLog(@"uniqueIdentifier_%@", uniqueIdentifier);
//    DDLog(@"nextResponder_%@", [self.view nextResponder:@"UIViewController"]);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(userDidTakeScreenshotNotification:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)userDidTakeScreenshotNotification:(NSNotification *)sender {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    UIImage *snapshotImage = [UIImage snapshotImageWithView:window];
    // TODO: 将screenshotImage进行分享，可以调用友盟SDK或自己集成第三方SDK实现，这里就不做演示了
    UIButton *btn = [window showFeedbackView:snapshotImage title:@"求助反馈"];
    [btn addActionHandler:^(UIButton * _Nonnull sender) {
        DDLog(@"%@", sender);

    } forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - -UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
            //    cell.imgView.image = [UIImage imageNamed:@"bug.png"];
            //    cell.label.text = [NSString stringWithFormat:@"row_%@",@(indexPath.row)];
            
            UILabel * label = [[UILabel alloc]init];
            label.backgroundColor = UIColor.yellowColor;
            label.numberOfLines = 0;
            [cell.contentView addSubview:label];
            
            label.text = @"label.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.textlabel.text";
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView.top).offset(0);
                make.left.equalTo(cell.contentView.left).offset(0);
                make.right.equalTo(cell.contentView.right).offset(0);
                make.bottom.equalTo(cell.contentView.bottom).offset(0);
                
                make.width.equalTo(cell.contentView).offset(0);
                
            }];
            
            [cell.contentView getViewLayer];

            return cell;
        }
            break;
        case 1:
        {
            UITableViewOneCell *cell = [UITableViewOneCell cellWithTableView:tableView];
            cell.contentView.backgroundColor = UIColor.randomColor;
            //
            UIView * backView = [[UIView alloc]init];
            [cell.contentView addSubview:backView];
            
            UILabel * labLast;
            for (NSInteger i = 0; i < 3; i++) {
                UILabel * label = [[UILabel alloc]init];
                label.text = [self ramdomText];
                
                label.textAlignment = NSTextAlignmentLeft;
                
                label.numberOfLines = 0;
                label.backgroundColor = UIColor.randomColor;
                [backView addSubview:label];
                
                [label makeConstraints:^(MASConstraintMaker *make) {
                    if (labLast) {
                        make.top.equalTo(labLast.bottom).offset(15);
                    }
                    else{
                        make.top.equalTo(backView.top).offset(15);
                        
                    }
                    make.left.equalTo(cell.contentView.left).offset(15);
                    make.right.equalTo(cell.contentView.right).offset(-15);
                }];
                labLast = label;
                
            }
            
            [backView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
                make.bottom.equalTo(labLast.bottom).offset(15);
                
            }];
            [cell getViewLayer];
            return cell;

        }
            break;
        case 2:
        {
            UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
            [cell getViewLayer];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *actionDelete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:kTitleDelete handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        DDLog(@"点击了%@",action.title);
        //        [self handleMsgDeleteWithIndexPath:indexPath];
        //网络删除成功之后,再删除本地,刷新列表
        
    }];
    return @[actionDelete];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIResponder *next = self.nextResponder;
    NSMutableString *prefix = @"--".mutableCopy;
    NSLog(@"%@", [self class]);
    
    while (next != nil) {
        NSLog(@"%@%@", prefix, next.class);
        [prefix appendString: @"--"];
        next = [next nextResponder];
    }
}


#pragma mark - others funtion

- (void)handleActionItem:(UITabBarItem *)sender {

    switch (sender.tag) {
        case 0:
        {
            [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert]
            .addAction(@[@"取消", @"确定"], ^(UIAlertAction * _Nonnull action) {
                NSLog(@"%@", action.title);
            })
            .addTextField(@[@"请输入账号", @"请输入密码"], ^(UITextField * _Nonnull textField) {
                NSLog(@"%@", textField.text);
            })
            .present(true, ^{
        
            });
        }
            break;
        case 1:
        {
            NSString *message = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - %@ - %@] 打开访问开关", @"相机" ,UIApplication.appName];
            [UIAlertController showAlertTitle:@"" message:message actionTitles:@[kTitleKnow] handler:nil];
        }
            break;
            
        case 2:
        {
            UIViewController *vc = [[NSClassFromString(@"TimerViewController") alloc]init];
            vc.title = @"Timer";
            [self.navigationController pushViewController:vc animated:true];
        }
            break;

        default:
            break;
    }
    
}


- (NSString *)ramdomText{
    CGFloat length = arc4random()%30 + 5;
    NSMutableString * mstr = [NSMutableString stringWithCapacity:0];
    for (NSUInteger i = 0; i < length; i++) {
        [mstr appendString:@"测试数据,"];
    }
    return mstr;
    
}

- (void)funtionMore{
    
    NSArray *list = @[@"1111", @"2222", @"3333", @"4444"];
    DDLog(@"listsorted_%@", list.sorted);
    DDLog(@"listsorted.reversed_%@", list.reversed);
    
    NSArray *listOne = [list map:^id _Nonnull(id  _Nonnull obj, NSUInteger idx) {
        return [(NSString *)obj substringToIndex:idx];
    }];
    DDLog(@"listOne_%@", listOne);
    
    NSMutableArray * marr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        WHKNetInfoFeedModel * model = [[WHKNetInfoFeedModel alloc]init];
        model.category = [NSString stringWithFormat:@"name_%@", @(i)];
        model.vendor = [NSDateFormatter stringFromDate:NSDate.date fmt:kDateFormat];
        if (i == 1) {
            model.category = nil;
        }
        [marr addObject:model];
    }
    
    NSArray *listTwo = [marr map:^id _Nonnull(WHKNetInfoFeedModel *obj, NSUInteger idx) {
        return [obj valueForKey:@"category"] ? : @"";
    }];
    DDLog(@"listTwo_%@", listTwo);
    
    NSArray *listThree = [marr map:^id _Nonnull(WHKNetInfoFeedModel *obj, NSUInteger idx) {
        [obj setValue:@(idx) forKey:@"category"];
        return obj;
    }];
    DDLog(@"listThree_%@", listThree);
    
    NSArray *list1 = [list filter:^BOOL(NSString *obj, NSUInteger idx) {
        return [obj compare:@"2222" options:NSNumericSearch] == NSOrderedDescending;
    }];
    DDLog(@"list1_%@", list1);
    
    
    for (NSString *obj in list) {
        NSComparisonResult result = [obj compare:@"222" options:NSNumericSearch];
        DDLog(@"%@", @(result));
    }
    
    NSArray *array = @[@24, @17, @85, @13, @9, @54, @76, @45, @5, @63];
    NSArray *list2 = [array filter:^BOOL(id _Nonnull obj, NSUInteger idx) {
        return [(NSNumber *)obj integerValue] > 20;
    }];
    DDLog(@"list2_%@", list2);
    
    NSArray *list3 = [list filter:^BOOL(id _Nonnull obj, NSUInteger idx) {
        return (![(NSString *)obj isEqualToString:@"2222"]);
    }];
    DDLog(@"list3_%@", list3);
    
    array = @[@1, @3, @5, @7, @9];
    NSNumber *result = [array reduce:@(0) transform:^NSNumber * _Nonnull(NSNumber * _Nonnull result, NSNumber * _Nonnull obj) {
        return @(result.floatValue * 10 + obj.floatValue);
    }];
    DDLog(@"result_%@", result);
    
    NSNumber *result1 = [array reduce:@(0) transform:^NSNumber * _Nonnull(NSNumber * _Nonnull result, NSNumber * _Nonnull obj) {
        return @(result.floatValue + obj.floatValue);
    }];
    DDLog(@"result1_%@", result1);
        
    NSArray *array10 = [NSArray range:0 end:10 step:1];
    NSArray *array11 = [NSArray range:1 end:11 step:1];
    NSArray *array12 = [NSArray range:0 end:30 step:5];
    NSArray *array13 = [NSArray range:-10 end:0 step:1];
    DDLog(@"%@", [array10 componentsJoinedByString:@","]);
    DDLog(@"%@", [array11 componentsJoinedByString:@","]);
    DDLog(@"%@", [array12 componentsJoinedByString:@","]);
    DDLog(@"%@", [array13 componentsJoinedByString:@","]);
}

- (void)funtionMoreDic{
    NSDictionary<NSString *, NSString *> *dic = @{
        @"1": @"111",
        @"2": @"222",
        @"3": @"222",
        @"4": @"444",
    };
    
    NSDictionary *dic1 = [dic map:^NSDictionary * _Nonnull(NSString * _Nonnull key, NSString * _Nonnull obj) {
        return @{[key stringByAppendingFormat:@"%@", @"_"] : [obj stringByAppendingFormat:@"%@", @"_"],
        };
    }];
    DDLog(@"dic1_%@", dic1);
//    2020-07-03 06:20:05.248000+0000【line -305】-[TestViewController funtionMoreDic] dic1_{
//        2_ = 222_;
//        4_ = 444_;
//        1_ = 111_;
//        3_ = 222_;
//    }

    NSDictionary *dic2 = [dic compactMapValues:^id _Nonnull(NSString * _Nonnull obj) {
        return [NSString stringWithFormat:@"%@_", obj];
    }];

    DDLog(@"dic2_%@",dic2);
//    2019-08-26 18:54:36.503000+0800【line -303】-[TestViewController funtionMoreDic] dic1_{
//        3 = 222_;
//        1 = 111_;
//        4 = 444_;
//        2 = 222_;
//    }
    NSDictionary *dic3 = [dic filter:^BOOL(NSString * _Nonnull key, NSString * _Nonnull obj) {
        return [key isEqualToString:@"2"];
    }];
    DDLog(@"dic3_%@",dic3);
//    2019-08-26 18:54:36.504000+0800【line -304】-[TestViewController funtionMoreDic] dic2_{
//        2 = 222;
//    }
    NSDictionary *dic4 = [dic filter:^BOOL(NSString * _Nonnull key, NSString * _Nonnull obj) {
        return [obj isEqualToString:@"222"];
    }];
    DDLog(@"dic4_%@",dic4);
//    2019-08-26 18:54:36.504000+0800【line -305】-[TestViewController funtionMoreDic] dic3_{
//        3 = 222;
//        2 = 222;
//    }
    
}


- (void)enumerateModel {
    Person *model = [[Person alloc]init];
    model.name = @"sda";
    model.age = 18;

    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
//    [model enumerateIvars:^(Ivar  _Nonnull v, NSString * _Nonnull name, id  _Nullable value) {
//        DDLog(@"Ivar_%@_%@", name, value);
//        mdic[name] = value ? : @"";
//    }];

    [model enumeratePropertys:^(objc_property_t  _Nonnull property, NSString * _Nonnull name, id  _Nullable value) {
        DDLog(@"Property_%@_%@", name, value);
        mdic[name] = value ? : @"";
    }];
    DDLog(@"mdic_%@", mdic);
    
//    [model enumerateMethods:^(Method  _Nonnull method, NSString * _Nonnull name) {
//        DDLog(@"Method_%@_%@", name, @(idx));
//    }];
//    
//    [model enumerateProtocols:^(Protocol * _Nonnull proto, NSString * _Nonnull name) {
//        DDLog(@"Protocol_%@_%@", name, @(idx));
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -lazy
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


@end
