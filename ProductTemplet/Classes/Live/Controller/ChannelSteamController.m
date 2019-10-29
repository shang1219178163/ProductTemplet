//
//  ChannelSteamController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import "ChannelSteamController.h"
#import <SVProgressHUD.h>

#import <YYModel/YYModel.h>
#import "PKDeviceListRootModel.h"
#import "PKChannelListRootModel.h"

#import "BNChannelstreamApi.h"
#import "BNTouchcChannelstreamApi.h"

#import "PKLivePlayerController.h"

@interface ChannelSteamController ()

@property(nonatomic, strong) BNChannelstreamApi * channelstreamApi;
@property(nonatomic, strong) BNTouchcChannelstreamApi * touchcChannelstreamApi;

@property(nonatomic, strong) PKChannelListRootModel *rootModel;
@property(nonatomic, strong) UITextView * textView;

@end

@implementation ChannelSteamController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.textView];
    
    [self createBarItem:@"播放" isLeft:false handler:^(id obj, UIView *item, NSInteger idx) {
//        [self goController:@"LivePlayerController" title:@"直播" obj:self.rootModel.EasyDarwin.Body.URL];
        
        NSString * url = self.rootModel.EasyDarwin.Body.URL;
        DDLog(@"%@",url);
        PKLivePlayerController * controller = [[PKLivePlayerController alloc]initWithURL:url];
        controller.url = url;
        [self.navigationController pushViewController:controller animated:true];

    }];
    
    [self.view getViewLayer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![self.obj isKindOfClass:PKDeviceInfoModel.class] || ![self.objOne isKindOfClass:PKChannelInfoModel.class]) {
        DDLog(@"error:%@, %@", self.obj, self.objOne);
        return;
    }
    [self requestStreamInfo];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.textView.superview);
    }];
}

#pragma mark -funtions

- (void)requestStreamInfo{
    [SVProgressHUD showWithStatus:kMsg_NetWorkRequesting];
    
    PKDeviceInfoModel * deviceModel = self.obj;
    PKChannelInfoModel * channelModel = self.objOne;
    self.channelstreamApi.ID = deviceModel.ID;
    [self.channelstreamApi requestWithSuccessBlock:^(NNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        //        DDLog(@"%@", responseObject);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            DDLog(@"%@", [(NSDictionary *)responseObject jsonString]);
            PKChannelListRootModel *rootModel = [PKChannelListRootModel yy_modelWithJSON:responseObject];
            self.rootModel = rootModel;
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                self.textView.text = [(NSDictionary *)responseObject jsonString];

            });
        });
        
    } failedBlock:^(NNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        DDLog(@"%@", error);
        
    }];
    
    self.touchcChannelstreamApi.ID = deviceModel.ID;
    [self.touchcChannelstreamApi requestWithSuccessBlock:^(NNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        DDLog(@"%@", responseObject);
     
    } failedBlock:^(NNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        DDLog(@"%@", error);
        
    }];
}

#pragma mark -lazy

- (BNChannelstreamApi *)channelstreamApi{
    if (!_channelstreamApi) {
        _channelstreamApi = [[BNChannelstreamApi alloc]init];
        _channelstreamApi.protocol = @"FLV";
        _channelstreamApi.channel = 1;
    }
    return _channelstreamApi;
}

-(BNTouchcChannelstreamApi *)touchcChannelstreamApi{
    if (!_touchcChannelstreamApi) {
        _touchcChannelstreamApi = [[BNTouchcChannelstreamApi alloc]init];
        _touchcChannelstreamApi.protocol = @"FLV";
        _touchcChannelstreamApi.channel = 1;
    }
    return _touchcChannelstreamApi;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [UIView createTextViewRect:CGRectZero placeholder:@"请输入"];
        
    }
    return _textView;
}

@end
