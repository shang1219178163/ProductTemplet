//
//  FileShareController.m
//  NNFileShare
//
//  Created by hsf on 2018/9/13.
//  Copyright © 2018年 Sera. All rights reserved.
//

#import "FileShareController.h"

@interface FileShareController ()

@property (nonatomic, copy) UIDocumentInteractionController *docController;
@property (nonatomic, copy) QLPreviewController *preController;

@end

@implementation FileShareController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
//    self.title = @"File";
    
    [self createControls];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)createControls{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(handleActionSenderLeft:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(handleActionSender:)];
    
}

- (void)handleActionSenderLeft:(UIBarButtonItem *)sender{
    UIViewController *rootVC = UIApplication.sharedApplication.delegate.window.rootViewController;
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}


- (void)handleActionSender:(UIBarButtonItem *)sender{
//    [self.docController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    BOOL isSuccess = [self.docController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
    if (isSuccess == NO) {
        NSLog(@"%@",@"没有程序可以打开要分享的文件");
    }
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

#pragma mark - -UIDocumentInteractionController

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController{
    return self;
    
}

-(UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    NSLog(@"documentInteractionControllerDidEndPreview");
    return self.view;
    
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller{
    NSLog(@"documentInteractionControllerDidDismissOpenInMenu");
    return self.view.frame;
    
}
- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller{
    NSLog(@"开始预览");
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
    NSLog(@"结束预览");
}


- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    NSLog(@"dismiss");
}

/**
 *  文件分享面板弹出的时候调用
 */
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller {
    NSLog(@"WillPresentOpenInMenu");
    
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(nullable NSString *)application {
    NSLog(@"begin send : %@", application);
}

- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller canPerformAction:(nullable SEL)action{
    return YES;
}

- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller performAction:(nullable SEL)action{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -set

-(void)setUrl:(NSURL *)url{
    _url = url;
    
    self.title = [self.url.lastPathComponent componentsSeparatedByString:@"-"].firstObject;
    [self.preController reloadData];

}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;

}
#pragma mark -lazy

-(UIDocumentInteractionController *)docController{
    if (!_docController) {
        _docController = [[UIDocumentInteractionController alloc] init];
        _docController.delegate = self;
        
    }
    _docController.URL = self.url;
//    _docController.UTI = self.url.getUTI;
    [_docController presentPreviewAnimated:YES];
    return _docController;
}

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
