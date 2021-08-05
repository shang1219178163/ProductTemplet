//
//  NNEmail.m
//  Location
//
//  Created by BIN on 2017/12/22.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import "NNEmail.h"

#import  <MessageUI/MFMailComposeViewController.h>

#import <NNGloble/NNGloble.h>
#import "NSData+Helper.h"

@interface NNEmail ()<MFMailComposeViewControllerDelegate>

@end

@implementation NNEmail

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)sendBug:(NSString *)bug interface:(NSException *)interfaceinfo{
    
    NSString * emailAddress = @"1219176600@qq.com";
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSDate *dd = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *crashLogInfo = [NSString stringWithFormat:@"exception type : %@ \n crash reason : %@ \n call stack time : %@", interfaceinfo, bug, dd];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://%@?subject=bug report&body=Thank you for your cooperation!""Error Details:%@",emailAddress,crashLogInfo];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    if ([[UIApplication sharedApplication] openURL:url]) {
        
    } else {
        DDLog(@"____________________________________________________________邮件发送失败!!!");
    }
}

-(void)sendEmailDict:(NSDictionary *)dict attachmentDict:(NSDictionary *)attachmentDict{

    NSString * mimeType = @"";
    if ([attachmentDict.allKeys containsObject:kEmail_attachMineType]) {
        mimeType = attachmentDict[kEmail_attachMineType];
        
    } else {
        NSArray * fileNameArray = [attachmentDict[kEmail_attachFilName] componentsSeparatedByString:@"."];
        mimeType = [fileNameArray lastObject];

    }
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:dict[kEmail_Recipients]];
    [controller setTitle:dict[kEmail_Title]];
    [controller setSubject:dict[kEmail_Subject]];
    [controller setMessageBody:dict[kEmail_Body] isHTML:YES];
    
    [controller addAttachmentData:attachmentDict[kEmail_attachData] mimeType:mimeType fileName:attachmentDict[kEmail_attachFilName]];

    [self presentViewController:controller animated:YES completion:^{
        
    }];

}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    NSString *message;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            message = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            message = @"邮件保存成功";

            break;
        case MFMailComposeResultSent:
            message = @"邮件发送成功";

            break;
        case MFMailComposeResultFailed:
            message = @"邮件发送失败";
            break;
        default:
            break;
    }
    DDLog(@"message: %@", message);

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


@end
