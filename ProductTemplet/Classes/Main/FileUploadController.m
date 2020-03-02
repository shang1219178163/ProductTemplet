//
//  FileUploadController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2020/3/2.
//  Copyright © 2020 BN. All rights reserved.
//

#import "FileUploadController.h"

@interface FileUploadController ()<UIDocumentPickerDelegate>

@property (nonatomic, copy) QLPreviewController *preController;

@end

@implementation FileUploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"文件上传";
    
    [self createBarItemTitle:@"next" imgName:nil isLeft:NO isHidden:NO handler:^(id obj, id item, NSInteger idx) {
        [self presentDocumentPicker];

    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DDLog(@"url_%@", self.url);
}

- (void)presentDocumentPicker {
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
    
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:docTypes inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
    documentPicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

#pragma mark -UIDocumentPickerViewController
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    self.url = url;
    [self.preController reloadData];

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


#pragma mark - - QLPreviewController
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSLog(@"%@",self.url);
    return self.url;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView *__autoreleasing  _Nullable *)view{
    return self.view.bounds;
}

- (void)previewControllerWillDismiss:(QLPreviewController *)controller{

    
}

#pragma mark -lazy

-(QLPreviewController *)preController{
    if (!_preController) {
        _preController = ({
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
    return _preController;
    
}

@end
