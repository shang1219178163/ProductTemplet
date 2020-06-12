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

@interface TestViewController ()

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createBarItem:@"Done" isLeft:false handler:^(id  _Nonnull obj, UIView * _Nonnull item, NSInteger idx) {
        NSString * msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - %@ - %@] 打开访问开关", @"相机" ,UIApplication.appName];
        [UIAlertController showAlertTitle:@"" msg:msg actionTitles:@[kTitleKnow] handler:nil];
    }];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    imgView.image = [UIImage imageNamed:@"parkingOne"];
    [self.view addSubview:imgView];

    [imgView showImageEnlarge];
    
    [self.view getViewLayer];
}

- (void)handleActionBtn:(UIBarButtonItem *)sender{
    [self goController:@"TimerViewController" title:@"Timer"];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self funtionMore];
    [self funtionMoreDic];

    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    NSString *uniqueIdentifier = [NSString stringWithFormat:@"%@", uuidStr];
    
    DDLog(@"uniqueIdentifier_%@", uniqueIdentifier);
    
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
    [btn addActionHandler:^(UIControl * _Nonnull control) {
        DDLog(@"%@", control);

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
            UITableViewZeroCell *cell = [UITableViewZeroCell cellWithTableView:tableView];
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
            UITableViewTwoCell *cell = [UITableViewTwoCell cellWithTableView:tableView];
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


#pragma mark - others funtion

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
    DDLog(@"listsorted.reversed_%@", list.sorted.reversed);
    
    NSArray *listOne = [list map:^id _Nonnull(id  _Nonnull obj, NSUInteger idx) {
        return [(NSString *)obj substringToIndex:idx];
    }];
    DDLog(@"listOne_%@", listOne);
    
    NSMutableArray * marr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        WHKNetInfoFeedModel * model = [[WHKNetInfoFeedModel alloc]init];
        model.category = [NSString stringWithFormat:@"name_%@", @(i)];
        model.vendor = [NSDateFormatter stringFromDate:NSDate.date fmt:kFormatDate];
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
    NSNumber * result = [array reduce:^NSNumber * _Nonnull(NSNumber * _Nonnull num1, NSNumber * _Nonnull num2) {
        return @(num1.floatValue * 10 + num2.floatValue);
    }];
    DDLog(@"result_%@", result);
    
    NSNumber * result1 = [array reduce:^NSNumber * _Nonnull(NSNumber * _Nonnull num1, NSNumber * _Nonnull num2) {
        return @(num1.floatValue + num2.floatValue);
    }];
    DDLog(@"result1_%@", result1);
    
    
    NSArray * array10 = [NSArray range:0 end:10 step:1];
    NSArray * array11 = [NSArray range:1 end:11 step:1];
    NSArray * array12 = [NSArray range:0 end:30 step:5];
    NSArray * array13 = [NSArray range:-10 end:0 step:1];
    DDLog(@"%@", [array10 componentsJoinedByString:@","]);
    DDLog(@"%@", [array11 componentsJoinedByString:@","]);
    DDLog(@"%@", [array12 componentsJoinedByString:@","]);
    DDLog(@"%@", [array13 componentsJoinedByString:@","]);
}

- (void)funtionMoreDic{
    NSDictionary *dic = @{
                          @"1": @"111",
                          @"2": @"222",
                          @"3": @"222",
                          @"4": @"444",
                          };
    
    NSDictionary *dic1 = [dic map:^NSObject * _Nonnull(NSObject<NSCopying> * _Nonnull key, NSObject * _Nonnull obj) {
        return [NSString stringWithFormat:@"%@_%@", key, obj];
    }];
    DDLog(@"dic1_%@",dic1);
//    2019-08-26 18:54:36.503000+0800【line -303】-[TestViewController funtionMoreDic] dic1_{
//        3 = 3_222;
//        1 = 1_111;
//        4 = 4_444;
//        2 = 2_222;
//    }
    
    NSDictionary *dic2 = [dic filter:^BOOL(NSObject<NSCopying> * _Nonnull key, NSObject * _Nonnull obj) {
        return [(NSString *)key isEqualToString:@"2"];
    }];
    DDLog(@"dic2_%@",dic2);
//    2019-08-26 18:54:36.504000+0800【line -304】-[TestViewController funtionMoreDic] dic2_{
//        2 = 222;
//    }
    NSDictionary *dic3 = [dic filter:^BOOL(NSObject<NSCopying> * _Nonnull key, NSObject * _Nonnull obj) {
        return [(NSString *)obj isEqualToString:@"222"];
    }];
    DDLog(@"dic3_%@",dic3);
//    2019-08-26 18:54:36.504000+0800【line -305】-[TestViewController funtionMoreDic] dic3_{
//        3 = 222;
//        2 = 222;
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
