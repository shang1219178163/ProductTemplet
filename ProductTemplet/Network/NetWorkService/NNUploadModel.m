//
//  NNUploadModel.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNUploadModel.h"

@implementation NNUploadModel

NNUploadModel *NNUploadModelFromParam(NSArray<UIImage *> *images, NSInteger idx, NSString *fileName){
    //    NSData *imageData = [UtilitiesDM compressImageDataFromImage:image maxFileSize:1024];
    //    NSString * imageType = [UtilitiesDM contentTypeForImageData:imageData];
    NSData *imageData = nil;
    NSString * imageType = @"jpg";
    // 默认图片的文件名, 若fileNames为nil就使用
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:@"yyyyMMddHHmmss" ];
    NSString *timeStamp = [formatter stringFromDate:NSDate.date];
    NSString *imageFileName = [NSString stringWithFormat:@"%@%@.%@",timeStamp, @(idx), imageType];
    
    NSString * name = [NSString stringWithFormat:@"image%@",@(idx+1)];
    
    NNUploadModel * model = [[NNUploadModel alloc] init];
    model.data = imageData;
    model.name = name;
    model.fileName = fileName ? [NSString stringWithFormat:@"%@.%@", fileName, imageType] : imageFileName;
    model.mimeType = [NSString stringWithFormat:@"image/%@", imageType];
    return model;
}

//+(instancetype *)modelWithImages:(NSArray<UIImage *> *)images idx:(NSInteger)idx fileName:(NSString *)fileName{
//    return BNUploadModelFromParam(images, idx, fileName);
//}

@end
