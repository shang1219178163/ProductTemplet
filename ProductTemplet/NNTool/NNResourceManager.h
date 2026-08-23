//
//  NNResourceManager.h
//  ProductTemplet
//
//  Created by BIN on 2026/8/23.
//  Copyright © 2026 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 全局资源单例：统一持有网图占位、默认头像、全局网图地址等
@interface NNResourceManager : NSObject

+ (instancetype)shared;



/// 网图加载占位图
@property (nonatomic, strong, nullable) UIImage *placeholderImage;
/// 默认头像（本地占位）
@property (nonatomic, strong, nullable) UIImage *defaultAvatarImage;

/// 全局默认网图前缀
@property (nonatomic, copy, nullable) NSString *imageBaseURL;
/// 默认头像网图地址
@property (nonatomic, copy, nullable) NSString *avatarURL;
/// 默认背景网图地址
@property (nonatomic, copy, nullable) NSString *bannerURL;

/// 全局网图 URL 列表
@property (nonatomic, strong, nonnull) NSArray<NSString *> *imageUrls;

/// 网图占位图名（本地资源名）
@property (nonatomic, copy) NSString *placeholderImageName;
/// 默认头像占位图名（本地资源名）
@property (nonatomic, copy) NSString *defaultAvatarImageName;

@end

NS_ASSUME_NONNULL_END
