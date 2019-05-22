//
//  WebSocketManager.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/5/22.
//  Copyright © 2019 BN. All rights reserved.
//

#import "WebSocketManager.h"
#import "Reachability.h"

static NSString * const kWebSocketUrl = @"ws://chat.workerman.net:7272";

@interface WebSocketManager ()
@property (nonatomic, strong) NSTimer *heartBeatTimer; //心跳定时器
@property (nonatomic, strong) NSTimer *netWorkTestTimer; //没有网络的时候检测网络定时器
@property (nonatomic, assign) NSTimeInterval reConnectTime; //重连时间
@property (nonatomic, strong) NSMutableArray *sendDataArray; //存储要发送给服务端的数据
@property (nonatomic, assign) BOOL isActiveClose;    //用于判断是否主动关闭长连接，如果是主动断开连接，连接失败的代理中，就不用执行 重新连接方法

@end


@implementation WebSocketManager

-(BOOL)reachable{
    Reachability *r = [Reachability reachabilityWithHostName:@"enbr.co.cc"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    return (internetStatus != NotReachable);
}

+(instancetype)shared{
    static WebSocketManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype)init{
    self = [super init];
    if(self){
        self.reConnectTime = 0;
        self.isActiveClose = NO;
        
        self.sendDataArray = [NSMutableArray array];
        
        /// 心跳计时器
        self.heartBeatTimer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(handleSendHeartBeat) userInfo:nil repeats:true];
        [NSRunLoop.currentRunLoop addTimer:self.heartBeatTimer forMode:NSRunLoopCommonModes];
        /// 网络检测
        self.netWorkTestTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleNetWorkTest) userInfo:nil repeats:true];
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleApplicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

#pragma mark -SRWebSocket
///开始连接
-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"socket---开始连接---");
    self.connectType = WebSocketConnect;
    
    [self startHeartBeat];///开始心跳
}

///接收消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    if ([message isKindOfClass: NSData.class]) {
        message = [[NSString alloc]initWithData:message encoding:NSUTF8StringEncoding];
    }
    NSLog(@"接收消息_%@_",message);
    if ([self.delegate respondsToSelector:@selector(webSocketManagerDidReceiveMessage:)]) {
        [self.delegate webSocketManagerDidReceiveMessage:(NSString *)message];
    }
}

///ping
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongData{
    NSLog(@"接受pong数据--> %@",pongData);
}

///关闭连接
-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    DDLog(@"被关闭连接，code: %ld, reason: %@, wasClean: %d", code, reason, wasClean);
    
    self.connectType = self.isActiveClose == true ? WebSocketDisconnect : WebSocketDefault;
    if(self.connectType == WebSocketDisconnect){
        return;
    }
    
    [self pauseHeartBeat]; //断开连接时销毁心跳
    
    //判断网络环境
    if (self.reachable){ //没有网络
        [self netWorkTestTimer];//开启网络检测
    } else { //有网络
        NSLog(@"开始重连服务器...");
        [self reConnectServer];//连接失败就重连
    }
}

///连接失败
-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"socket---连接失败---\n%@",error);
    
    self.connectType = WebSocketDisconnect;
    
    DDLog(@"掉线自动重连，注意:\n1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连\n3.连接次数限制，如果连接失败了，重试10次左右就可以了");
    //判断网络环境
    if (self.reachable){ //没有网络
        [self netWorkTestTimer];//开启网络检测定时器
        
    } else { //有网络
        [self reConnectServer];//连接失败就重连
        
    }
}

#pragma mark -NSNotificationCenter

- (void)handleApplicationDidBecomeActive{
    if (WebSocketManager.shared.connectType == WebSocketConnect) {
        return;
    }
    [self connectServer];
}

#pragma mark -NSTimer
/// 开启心跳
- (void)startHeartBeat{
    //开启心跳
    self.heartBeatTimer.fireDate = NSDate.distantFuture;
    
}

/// 停止网络检测
- (void)pauseNetWorkTest{
    self.netWorkTestTimer.fireDate = NSDate.distantPast;
    
}

/// 停止心跳
- (void)pauseHeartBeat{
    self.heartBeatTimer.fireDate = NSDate.distantPast;
    
}

//发送心跳
- (void)handleSendHeartBeat{
    //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
    if(self.webSocket.readyState == SR_OPEN){
        [self.webSocket send:nil];
    }
}

//没有网络的时候开始定时 -- 用于网络检测
- (void)handleNetWorkTest{
    if (self.reachable == false) {
        return;
    }
    //有网络,停止网络检测定时器
    [self pauseNetWorkTest];
    //开始重连
    [self reConnectServer];
}

#pragma mark -connect

//建立长连接
- (void)connectServer{
    DDLog(@"正在重连服务器...");
    
    self.isActiveClose = NO;
    
    if (self.webSocket) {
        [self.webSocket close];
    }
    [self.webSocket open];
}

//重新连接
- (void)reConnectServer{
    if(self.webSocket.readyState == SR_OPEN){
        return;
    }
    
    if(self.reConnectTime > 1024){  //重连10次 2^10 = 1024
        self.reConnectTime = 0;
        return;
    }
    
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.reConnectTime *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        if(self.webSocket.readyState == SR_OPEN && self.webSocket.readyState == SR_CONNECTING) {
            return;
        }
        
        [self connectServer];
        //重连时间2的指数级增长
        self.reConnectTime = self.reConnectTime == 0 ? 2 : self.reConnectTime*2;
    });
    
}

//关闭长连接
- (void)closeWebSocket{
    self.isActiveClose = YES;
    self.connectType = WebSocketDefault;
    if(self.webSocket) {
        [self.webSocket close];
    }
    
    //停止心跳定时器
    [self pauseHeartBeat];
    
    //停止网络检测定时器
    [self pauseNetWorkTest];
}


//发送数据给服务器
- (void)sendDataToServer:(NSString *)data{
    [self.sendDataArray addObject:data];
    
    //没有网络
    if (WebSocketManager.shared.reachable == false) {
        //开启网络检测定时器
        [self netWorkTestTimer];
        return;
    }
    
    if (self.webSocket == nil) {
        [self connectServer]; //连接服务器
        return;
    }
    
    switch (self.webSocket.readyState) {
        case SR_CONNECTING:
        {
            DDLog(@"正在连接中，重连后会去自动同步数据");
        }
            break;
        case SR_OPEN:
        {
            [self.webSocket send:data];
        }
            break;
        case SR_CLOSING:
        case SR_CLOSED:
        {
            //调用 reConnectServer 方法重连,连接成功后 继续发送数据
            [self reConnectServer];
        }
            break;
        default:
            break;
    }
    
}


#pragma mark -lazy

- (SRWebSocket *)webSocket{
    if (!_webSocket) {
        _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:kWebSocketUrl]];
        _webSocket.delegate = self;
        [_webSocket open];
    }
    return _webSocket;
}

@end
