//
//  UIWebViewController.m
//   
//
//  Created by zhihuiguan on 14-7-8.
//  Copyright (c) 2014年 freedom. All rights reserved.
//

#import "UIWebViewController.h"
#import "UIWebLoaderView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "JSONKit.h"

#define kBarButtonTagHome 0
#define kBarButtonTagBackward 1
#define kBarButtonTagForward 2
#define kBarButtonTagRefresh 3
#define kBarButtonTagStop 4

@interface UIWebViewController () <UIWebViewDelegate>

@end

@implementation UIWebViewController

{
    BOOL initialized;
    
    UIWebLoaderView *webView;
    UIToolbar *toolBar;
}
@synthesize javascriptBridge = _bridge;

-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!initialized) {
        initialized = YES;
        
        //init web view
        webView = [[UIWebLoaderView alloc] initWithFrame:CGRectZero];
        
        webView.frame = self.view.bounds;
        webView.delegate = self;
        webView.opaque = YES;
        webView.userInteractionEnabled = YES;
        webView.backgroundColor = [UIColor clearColor];
        //webView.scalesPageToFit = YES;
        
        webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        
        [self.view addSubview:webView];
        
        [WebViewJavascriptBridge enableLogging];
        
        _bridge = [WebViewJavascriptBridge bridgeForWebView:webView handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"ObjC received message from JS: %@", data);
//            [self playVideo];
            responseCallback(@"Response for message from ObjC");
        }];
        
        [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"testObjcCallback called: %@", data[@"videoUrl"]);
            responseCallback(@"Response from testObjcCallback");
            [self playVideo:data[@"videoUrl"]];
//            NSDictionary *dic = [NSString ]
        }];
        
        [_bridge send:@"A string sent from ObjC before Webview has loaded." responseCallback:^(id responseData) {
            NSLog(@"objc got response! %@", responseData);
        }];
        
        [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
 
        
        [_bridge send:@"A string sent from ObjC after Webview has loaded."];

    }
    
    [self loadUrlString:self.urlString];
    [self loadFilePage:self.fileName];
}

-(void)setShowsWebViewControls:(BOOL)showsWebViewControls
{
    _showsWebViewControls = showsWebViewControls;
    [self layoutViews];
}

-(void)setUrlString:(NSString *)urlString
{
    _urlString = [urlString copy];
    
    if ([self isViewLoaded]) {
        [self loadUrlString:self.urlString];
    }
}

-(void)setFileName:(NSString *)fileName
{
    _fileName = [fileName copy];
    
    if ([self isViewLoaded]) {
        [self loadFilePage:self.fileName];
    }
}


-(void)layoutViews
{
    CGRect webViewFrame;
    
    if (_showsWebViewControls) {
        CGFloat toolBarHeight = 44;
        
        webViewFrame = self.view.bounds;
        webViewFrame.size.height -= toolBarHeight;
        
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(webViewFrame), CGRectGetWidth(self.view.bounds), toolBarHeight)];
        [self.view addSubview:toolBar];
        
        //setup buttons
        NSMutableArray *items = [NSMutableArray array];
        
        [items addObject:[self barButtonItemWithImageNamed:@"UIWebLoaderView.bundle/images/WebView_home" tag:kBarButtonTagHome target:self action:@selector(actionWebView:)]];
        [items addObject:[self barButtonItemWithImageNamed:@"UIWebLoaderView.bundle/images/WebView_Backward" tag:kBarButtonTagBackward target:self action:@selector(actionWebView:)]];
        [items addObject:[self barButtonItemWithImageNamed:@"UIWebLoaderView.bundle/images/WebView_Forward" tag:kBarButtonTagForward target:self action:@selector(actionWebView:)]];
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL]];
        [items addObject:[self barButtonItemWithImageNamed:@"UIWebLoaderView.bundle/images/WebView_Refresh" tag:kBarButtonTagRefresh target:self action:@selector(actionWebView:)]];
        [items addObject:[self barButtonItemWithImageNamed:@"UIWebLoaderView.bundle/images/WebView_Stop" tag:kBarButtonTagStop target:self action:@selector(actionWebView:)]];
        
        toolBar.items = items;
        
        [self updateWebViewControls];
        
    } else {
        if (toolBar) {
            [toolBar removeFromSuperview];
            toolBar = nil;
        }
        
        webViewFrame = self.view.bounds;
    }
    
    webView.frame = webViewFrame;
}

-(UIBarButtonItem *)barButtonItemWithImageNamed:(NSString *)imageName tag:(NSInteger)tag target:(id)target action:(SEL)action
{
    UIImage *image = [UIImage imageNamed:imageName];
    NSParameterAssert(image);
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    barButtonItem.tag = tag;

//    barButtonItem.tintColor = [UIColor whiteColor];
    
    return barButtonItem;
}

-(void)actionWebView:(id)sender
{
    //UIBarButtonItem *item = sender;
    //NSParameterAssert([sender isKindOfClass:[UIBarButtonItem class]]);
    
    UIButton *item = sender;
    
    switch (item.tag) {
        case kBarButtonTagHome:
        {
            [self loadUrlString:self.urlString];
        }
            break;
        
        case kBarButtonTagBackward:
        {
            if ([webView canGoBack]) {
                [webView goBack];
            }
        }
            break;
          
        case kBarButtonTagForward:
        {
            if ([webView canGoForward]) {
                [webView goForward];
            }
        }
            break;
          
        case kBarButtonTagRefresh:
        {
            [webView reload];
        }
            break;
          
        case kBarButtonTagStop:
        {
            [webView stopLoading];
        }
            break;
            
        default:
            break;
    }
}

-(void)updateWebViewControls
{
    if (!toolBar) {
        return;
    }
    
    UIBarButtonItem *goBackItem = [[toolBar items] objectAtIndex:kBarButtonTagBackward];
    goBackItem.enabled = [webView canGoBack];
    
    UIBarButtonItem *goForwardItem = [[toolBar items] objectAtIndex:kBarButtonTagForward];
    goForwardItem.enabled = [webView canGoForward];
}

-(void)loadUrlString:(NSString *)urlString
{
    if (!urlString) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:urlRequest];
}
- (void)loadFilePage:(NSString*) file {
    if (!file) {
        return;
    }
    
	NSString *htmlPath = [[NSBundle mainBundle] pathForResource:_fileName ofType:nil];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:appHtml baseURL:nil];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //NSLog(@"%d", navigationType);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)_webView
{
    [self updateWebViewControls];
    
    //NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)_webView
{
    //NSLog(@"webViewDidFinishLoad");
    
    [self updateWebViewControls];
    
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}
- (void)playVideo:(NSString *)url{
 
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"testMovie" ofType:@"mp4"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    
//    MPMoviePlayerController *player  = [[MPMoviePlayerController alloc] initWithContentURL:url];
//
////    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
////    
// 
//    [self setupMovie:player];
//    [player play];
    
    
    // create MPMoviePlayerViewController
    MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:url]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:[playerViewController moviePlayer]];
    CGRect aFrame = [[UIScreen mainScreen] applicationFrame];
    aFrame = CGRectMake(0.0f, 0.0f, aFrame.size.width/2, aFrame.size.height/2);
    
    playerViewController.view.frame = aFrame;
    
    // add to view
    [self.view addSubview:playerViewController.view];
    

    // play movie
    MPMoviePlayerController *player = [playerViewController moviePlayer];
    player.controlStyle = MPMovieControlStyleNone;
    player.shouldAutoplay = YES;
    player.repeatMode = MPMovieRepeatModeOne;
//    [player setFullscreen:YES animated:YES];
    player.scalingMode = MPMovieScalingModeAspectFit;
    [player play];
}
-(void)moviePlayBackDidFinish:(id)sender{

}
-(void)setupMovie:(MPMoviePlayerController *)myMovie
{
    CGRect aFrame = [[UIScreen mainScreen] applicationFrame];
    aFrame = CGRectMake(0.0f, 0.0f, aFrame.size.width/2, aFrame.size.height/2);
    
    myMovie.controlStyle = MPMovieControlStyleDefault;
    myMovie.view.frame = aFrame;
    myMovie.shouldAutoplay = YES;
    myMovie.repeatMode = MPMovieRepeatModeOne;
    myMovie.view.center = CGPointMake(aFrame.size.width/2, aFrame.size.height/2);
//    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
//    [myMovie.view setTransform:transform];
    [self.view addSubview:myMovie.view];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:myMovie.view];
}

- (void)webView:(UIWebView *)_webView didFailLoadWithError:(NSError *)error
{
    //NSLog(@"webViewDidFinishLoad");
    
    [self updateWebViewControls];
}
-(void)removeSelfController:(BOOL )aninated{
    CATransition *transition = [CATransition animation];
    transition.duration = aninated?0.3:0;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self.view removeFromSuperview];
}

-(void)goBack:(BOOL)animated{
    
    [self removeSelfController:animated];
    [self removeFromParentViewController];
}

- (void)sendMessage:(id)sender {
    [_bridge send:@"A string sent from ObjC to JS" responseCallback:^(id response) {
        NSLog(@"sendMessage got response: %@", response);
    }];
}

- (void)callHandler:(id)sender {
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

@end

@implementation NSURLRequest(DataController)

+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end