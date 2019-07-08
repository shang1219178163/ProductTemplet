//
//  WebSocketManager.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/5/22.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>

typedef NS_ENUM(NSUInteger,WebSocketConnectType){
    WebSocketDefault = 0, //初始状态,未连接
    WebSocketConnect,      //已连接
    WebSocketDisconnect    //连接后断开
};

@class WebSocketManager;
@protocol WebSocketManagerDelegate <NSObject>

- (void)webSocketManagerDidReceiveMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_BEGIN

@interface WebSocketManager : NSObject<SRWebSocketDelegate>

@property (nonatomic, strong, nullable) SRWebSocket *webSocket;
@property (nonatomic, weak)  id<WebSocketManagerDelegate > delegate;
@property (nonatomic, assign) WebSocketConnectType connectType;
//当前网络状态检测
@property (nonatomic, assign, readonly) BOOL reachable;

+ (instancetype)shared;
- (void)connectServer;//建立长连接
- (void)reConnectServer;//重新连接
- (void)closeWebSocket;//关闭长连接
- (void)sendDataToServer:(NSString *)data;//发送数据给服务器

@end

NS_ASSUME_NONNULL_END
