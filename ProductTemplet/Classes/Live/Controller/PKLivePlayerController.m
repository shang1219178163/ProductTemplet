//
//  PKLivePlayerController.m
//  HuiZhuBang
//
//  Created by BIN on 2018/8/21.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "PKLivePlayerController.h"

//#import <IJKMediaFramework/IJKMediaFramework.h>
//#import <SVProgressHUD.h>
//
//@interface PKLivePlayerController ()<IJKMediaUrlOpenDelegate>
//
//@property (nonatomic, strong) IJKFFMoviePlayerController * player;
//
//@end

@implementation PKLivePlayerController

//- (instancetype)initWithURL:(NSString *)url {
//    self = [self init];
//    if (self) {
//        self.url = url;
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.view.backgroundColor = UIColor.blackColor;
//    self.view.autoresizesSubviews = YES;
//
//    [self configurePlayer];
//    [self.view addSubview:self.player.view];
////    self.player.view.frame = CGRectMake(10, 10, 200, 200);
//
//    [self.view getViewLayer];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
////    [UIDevice.currentDevice setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
//    if (!self.player) {
//        [SVProgressHUD showWithStatus:kNetWorkRequesting];
//    }
//
//    if (self.obj) self.url = self.obj;
//
//    [self installMovieNotificationObservers];
//    [self.player prepareToPlay];
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//
//    [self.player shutdown];
//    [self removeMovieNotificationObservers];
////    [UIDevice.currentDevice setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
//
//}
//
//- (void)configurePlayer{
//
//#ifdef DEBUG
//    [IJKFFMoviePlayerController setLogReport:YES];
//    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_DEBUG];
//#else
//    [IJKFFMoviePlayerController setLogReport:NO];
//    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_INFO];
//#endif
//
//    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
//    // [IJKFFMoviePlayerController checkIfPlayerVersionMatch:YES major:1 minor:0 micro:0];
//
//
//    IJKFFMoviePlayerController *ffp = self.player;
//    ffp.httpOpenDelegate = self;
//
//}
//
//
//- (void)willOpenUrl:(IJKMediaUrlOpenData*) urlOpenData{
//    NSLog(@"%@",urlOpenData.url);
//
//}
//
//#pragma mark - - Orientations
//- (BOOL)shouldAutorotate{
//    return NO;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeRight;
//
//}
//
//- (void)didReceiveMemoryWarning{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark IBAction
//
//- (void)loadStateDidChange:(NSNotification*)notification{
//    //    MPMovieLoadStateUnknown        = 0,
//    //    MPMovieLoadStatePlayable       = 1 << 0,
//    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
//    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
//
//    IJKMPMovieLoadState loadState = _player.loadState;
//
//    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
//        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
//    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
//        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
//    } else {
//        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
//    }
//}
//
//- (void)moviePlayBackDidFinish:(NSNotification*)notification
//{
//    //    MPMovieFinishReasonPlaybackEnded,
//    //    MPMovieFinishReasonPlaybackError,
//    //    MPMovieFinishReasonUserExited
//    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
//
//    switch (reason)
//    {
//        case IJKMPMovieFinishReasonPlaybackEnded:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
//            break;
//
//        case IJKMPMovieFinishReasonUserExited:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
//            break;
//
//        case IJKMPMovieFinishReasonPlaybackError:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
//            break;
//
//        default:
//            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
//            break;
//    }
//}
//
//- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
//{
//    NSLog(@"mediaIsPreparedToPlayDidChange\n");
//    [SVProgressHUD dismiss];
//}
//
//- (void)moviePlayBackStateDidChange:(NSNotification*)notification
//{
//    //    MPMoviePlaybackStateStopped,
//    //    MPMoviePlaybackStatePlaying,
//    //    MPMoviePlaybackStatePaused,
//    //    MPMoviePlaybackStateInterrupted,
//    //    MPMoviePlaybackStateSeekingForward,
//    //    MPMoviePlaybackStateSeekingBackward
//
//    switch (_player.playbackState)
//    {
//        case IJKMPMoviePlaybackStateStopped: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
//            break;
//        }
//        case IJKMPMoviePlaybackStatePlaying: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
//            break;
//        }
//        case IJKMPMoviePlaybackStatePaused: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
//            break;
//        }
//        case IJKMPMoviePlaybackStateInterrupted: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
//            break;
//        }
//        case IJKMPMoviePlaybackStateSeekingForward:
//        case IJKMPMoviePlaybackStateSeekingBackward: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
//            break;
//        }
//        default: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
//            break;
//        }
//    }
//}
//
//#pragma mark Install Movie Notifications
//
///* Register observers for the various movie object notifications. */
//-(void)installMovieNotificationObservers
//{
//    [NSNotificationCenter.defaultCenter addObserver:self
//                                             selector:@selector(loadStateDidChange:)
//                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
//                                               object:_player];
//
//    [NSNotificationCenter.defaultCenter addObserver:self
//                                             selector:@selector(moviePlayBackDidFinish:)
//                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
//                                               object:_player];
//
//    [NSNotificationCenter.defaultCenter addObserver:self
//                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
//                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
//                                               object:_player];
//
//    [NSNotificationCenter.defaultCenter addObserver:self
//                                             selector:@selector(moviePlayBackStateDidChange:)
//                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
//                                               object:_player];
//}
//
//#pragma mark Remove Movie Notification Handlers
//
///* Remove the movie notification observers from the movie object. */
//-(void)removeMovieNotificationObservers{
//    [NSNotificationCenter.defaultCenter removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
//    [NSNotificationCenter.defaultCenter removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
//    [NSNotificationCenter.defaultCenter removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
//    [NSNotificationCenter.defaultCenter removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
//}
//
//#pragma mark -旋转屏幕
//
//- (void)setInterfaceOrientation:(UIDeviceOrientation)orientation {
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
//    }
//}
//#pragma mark - -layz
//
//-(IJKFFMoviePlayerController *)player{
//    if (!_player) {
//        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
//        [options setFormatOptionValue:@"ijktcphook" forKey:@"http-tcp-hook"];
//
//        _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.url] withOptions:options];
//        _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        _player.view.frame = self.view.bounds;
//        _player.scalingMode = IJKMPMovieScalingModeAspectFit;
//        _player.shouldAutoplay = YES;
//    }
//    return _player;
//}


@end
