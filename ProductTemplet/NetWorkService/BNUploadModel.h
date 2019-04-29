//
//  BNUploadModel.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNUploadModel : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *mimeType;

BNUploadModel *BNUploadModelFromParam(NSArray<UIImage *> *images, NSInteger idx, NSString *fileName);

@end

NS_ASSUME_NONNULL_END
