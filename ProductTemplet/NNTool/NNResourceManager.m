//
//  NNResourceManager.m
//  ProductTemplet
//
//  Created by BIN on 2026/8/23.
//  Copyright © 2026 BN. All rights reserved.
//

#import "NNResourceManager.h"

@implementation NNResourceManager

+ (instancetype)shared{
    static NNResourceManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NNResourceManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _placeholderImageName = @"postImage";
        _defaultAvatarImageName = @"bug.png";

        _imageBaseURL = @"";
        _avatarURL = @"";
        _bannerURL = @"";
    }
    return self;
}

#pragma mark - lazy

- (UIImage *)placeholderImage{
    if (!_placeholderImage) {
        _placeholderImage = [UIImage imageNamed:self.placeholderImageName];
    }
    return _placeholderImage;
}

- (UIImage *)defaultAvatarImage{
    if (!_defaultAvatarImage) {
        _defaultAvatarImage = [UIImage imageNamed:self.defaultAvatarImageName];
    }
    return _defaultAvatarImage;
}

- (NSArray<NSString *> *)imageUrls{
    if (!_imageUrls) {
        _imageUrls = @[
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737078692/im/msg/rec/651722246582308864.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737078705/im/msg/rec/651722301611577344.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337130/im/msg/rec/652806214488559616.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337130/im/msg/rec/652806216854147072.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337130/im/msg/rec/652806216086589440.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337130/im/msg/rec/652806217546207232.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337131/im/msg/rec/652806218489925632.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337131/im/msg/rec/652806219450421248.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337131/im/msg/rec/652806220805181440.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337132/im/msg/rec/652806222130581504.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337132/im/msg/rec/652806224420671488.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737343844/im/msg/rec/652834375670566912.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737343889/im/msg/rec/652834566318460928.jpg",
           @"https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737343924/im/msg/rec/652834709679771648.png",
       ];
    }
    return _imageUrls;
}

@end
