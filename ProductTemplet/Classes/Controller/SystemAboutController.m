//
//  SystemAboutController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "SystemAboutController.h"

@interface SystemAboutController ()

@property (nonatomic, strong) NNTablePlainView * plainView;

@end

@implementation SystemAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.plainView];
    
    self.dataList = @[
                      @[@"AudioSoundController", @"iOS 系统铃声大全",],
                      @[@"FontListController", @"iOS 系统字体大全",],
                      @[@"FileShareController", @"app之间文件共享",],
                      @[@"AppIconChangeController", @"app图标更换",],
                      @[@"TextFromSpeechController", @"语音转文字",],
                      @[@"AVSpeechViewController", @"文字转语音",],
                      @[@"UITextFieldController", @"UITextField",],
                      @[@"TextViewController", @"UITextView",],
                      @[@"KeyboardController",@"Keyboard自定义",],
                      @[@"FileParseController", @"json文件解析",],
                      @[@"BNCollectionDataController", @"集合属性KVO监听",],
                      @[@"SnapshotViewController", @"屏幕截图分享/反馈",],
                      ].mutableCopy;
        
        self.plainView.list = self.dataList;
        [self.plainView.tableView reloadData];
        
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    self.plainView.frame = self.view.bounds;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark -lazy

- (NNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[NNTablePlainView alloc]initWithFrame:self.view.bounds];
        _plainView.tableView.rowHeight = 70;
        
        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSArray * list = self.dataList[indexPath.row];

            static NSString * identifier = @"UITableViewCell1";
            //    UITableViewOneCell * cell = [UITableViewOneCell cellWithTableView:tableView];
            UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];
            cell.textLabel.text = list[1];
            cell.textLabel.textColor = UIColor.themeColor;
            
            cell.detailTextLabel.text = list[0];
            cell.detailTextLabel.textColor = UIColor.grayColor;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        };
        
        _plainView.blockDidSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            NSArray * list = self.dataList[indexPath.row];
            //    [self goController:list.lastObject title:list.firstObject];
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            [self pushController:list[0] title:list[1] item:cell type:@0];
        };
    }
    return _plainView;
}


@end
