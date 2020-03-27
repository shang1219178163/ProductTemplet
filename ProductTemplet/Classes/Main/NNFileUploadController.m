//
//  NNFileUploadController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2020/3/2.
//  Copyright © 2020 BN. All rights reserved.
//

#import "NNFileUploadController.h"
#import <AFNetworking.h>
#import "NNProgressHUD.h"

@interface NNFileUploadController ()<UIDocumentPickerDelegate>

@property (nonatomic, strong) UIBarButtonItem *chooseItem;
@property (nonatomic, strong) UIBarButtonItem *uploadItem;
@property (nonatomic, strong) UIBarButtonItem *shareItem;

@property (nonatomic, strong) QLPreviewController *previewVC;
@property (nonatomic, strong) UIDocumentPickerViewController *docPickVC;

@end

@implementation NNFileUploadController

+ (NSArray *)docTypes{
    NSArray *docTypes = @[@"com.microsoft.word.doc",
    @"com.microsoft.excel.xls",
    @"com.microsoft.powerpoint.ppt",
    @"com.adobe.pdf",
//    @"public.item",
//    @"public.image",
    @"public.content",
//    @"public.composite-content",
//    @"public.archive",
//    @"public.audio",
//    @"public.movie",
    @"public.text",
//    @"public.data",
    ];
    return docTypes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"文件上传";
    
    self.chooseItem = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(handleActionItem:)];
    self.uploadItem = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(handleActionItem:)];
    self.shareItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(handleActionItem:)];
    self.navigationItem.rightBarButtonItems = @[self.uploadItem, self.chooseItem, self.shareItem];
    
    [self.previewVC reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DDLog(@"url_%@", self.localFileUrl);
    self.title = self.isUpload ? @"文件上传" : @"文件下载";
    if (self.isUpload) {
        self.navigationItem.rightBarButtonItems = @[self.uploadItem, self.chooseItem];
    } else {
        self.navigationItem.rightBarButtonItems = @[self.shareItem];
    }
}

- (void)handleActionItem:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"选择"]) {
        [self presentDocPicker];
        
    } else if ([item.title isEqualToString:@"上传"]) {
        [self uploadFile];
        
    } else {
        [self downloadFile:self.localFileUrl.absoluteString];
    }
}

#pragma mark -UIDocumentPickerViewController
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    self.localFileUrl = url;
    [self.previewVC reloadData];

    BOOL canAccessingResource = [url startAccessingSecurityScopedResource];
    if(canAccessingResource) {
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
            NSData *fileData = [NSData dataWithContentsOfURL:newURL];
            NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentPath = [arr lastObject];
            NSString *desFileName = [documentPath stringByAppendingPathComponent:@"myFile"];
            [fileData writeToFile:desFileName atomically:YES];
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        if (error) {
            // error handing
        }
    } else {
        // startAccessingSecurityScopedResource fail
    }
    [url stopAccessingSecurityScopedResource];
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller{
    [controller setupContentInsetAdjustmentBehavior:false];
}

#pragma mark - - QLPreviewController
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSLog(@"%@",self.localFileUrl);
    return self.localFileUrl;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView *__autoreleasing  _Nullable *)view{
    return self.view.bounds;
}

- (void)previewControllerWillDismiss:(QLPreviewController *)controller{

}

#pragma mark -funtions
- (void)presentDocPicker {
    [self.docPickVC setupContentInsetAdjustmentBehavior:true];
    [self presentViewController:self.docPickVC animated:YES completion:nil];
//    UIDocumentPickerViewController *docPickVC = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:docTypes inMode:UIDocumentPickerModeImport];
//    docPickVC.delegate = self;
//    docPickVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:docPickVC animated:YES completion:nil];
}

- (void)uploadFile{
    [NNProgressHUD showLoadingText:kNetWorkRequesting];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [sessionManager.requestSerializer setValue:@"IOP/iOS" forHTTPHeaderField:@"User-Agent"];
    [sessionManager.requestSerializer setValue:@"3.3.1" forHTTPHeaderField:@"Accept-Version"];
    
    [sessionManager POST:@"http://116.62.132.145:8008/iop/ipk/img_upload" parameters:@{@"token" : @"680b2275a2318b076a6c883908bae43e"}
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 在这个block中设置需要上传的文件
//            NSData *data = [NSData dataWithContentsOfFile:@"/Users/xiaomage/Desktop/placeholder.png"];
 
            //方法一
//            [formData appendPartWithFileData:data name:@"file" fileName:@"test.png" mimeType:@"image/png"];

            //方法二：自动给封装filename、mimeType
//            [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/xiaomage/Desktop/placeholder.png"] name:@"file" fileName:@"xxx.png" mimeType:@"image/png" error:nil];
           
            //方法三：自动给封装filename、mimeType
//            [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/xiaomage/Desktop/placeholder.png"] name:@"file" error:nil];
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/xiaomage/Desktop/placeholder.png"] name:@"file" error:nil];
        [formData appendPartWithFileURL:self.localFileUrl name:@"file" error:nil];

    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"-------%@", responseObject);
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        [NNProgressHUD showSuccessText:@"请求成功"];
        NSDictionary *dic = responseObject;
        NSString *url = dic[@"data"][@"url"];
        [self downloadFile:url];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [NNProgressHUD showErrorText:kNetWorkFailed];
    }];
}

- (void)downloadFile:(NSString *)urlStr{
    [NNProgressHUD showLoadingText:@"下载中..."];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [NSFileManager.defaultManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
//        NSLog(@"File downloaded toresponse: %@", response);

        NSString *msg = error == nil ? error.description : @"下载成功";
        [NNProgressHUD showText:msg];
        
        self.localFileUrl = filePath;
        [self.previewVC reloadData];

    }];
    [downloadTask resume];
}

#pragma mark -lazy

-(QLPreviewController *)previewVC{
    if (!_previewVC) {
        _previewVC = ({
            QLPreviewController *controller = [[QLPreviewController alloc]init];
            controller.edgesForExtendedLayout = UIRectEdgeNone;
            controller.dataSource = self;
            controller.delegate = self;
            controller.currentPreviewItemIndex = 0;
            
            controller.view.frame = self.view.bounds;
            [self addChildViewController:controller];
            [controller didMoveToParentViewController:self];
            [self.view addSubview:controller.view];

            controller;
        });
    }
    return _previewVC;
    
}

-(UIDocumentPickerViewController *)docPickVC{
    if (!_docPickVC) {
        _docPickVC = [[UIDocumentPickerViewController alloc] initWithDocumentTypes: NNFileUploadController.docTypes inMode:UIDocumentPickerModeImport];
        _docPickVC.delegate = self;
        _docPickVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return _docPickVC;
}

@end
