//
//  UIWebLoaderView.m
//   
//
//  Created by zhihuiguan on 13-6-24.
//  Copyright (c) 2013年 freedom. All rights reserved.
//

#import "UIWebLoaderView.h"

@interface UIWebLoaderView () <UIWebViewDelegate>

@end


@implementation UIWebLoaderView
{
    BOOL initialized;
    UIActivityIndicatorView *activityIndicatorView;
}

@synthesize autoresizesContent;
@synthesize delegate = m_delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    if (!initialized) {
        super.delegate = self;
        
        initialized = YES;
        autoresizesContent = YES;
    }
}

-(void)dealloc
{
    [self stopLoading];
    
    self.delegate = nil;
    super.delegate = nil;
}

-(id<UIWebViewDelegate>)delegate
{
    return m_delegate;
}

-(void)setDelegate:(id<UIWebViewDelegate>)delegate
{
    m_delegate = delegate;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldStart = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        shouldStart = [self.delegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return shouldStart;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (!activityIndicatorView) {
        activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicatorView.hidesWhenStopped = YES;
        activityIndicatorView.hidden = YES;
        
        [webView addSubview:activityIndicatorView];
    }
    
    //center setting
    activityIndicatorView.center = webView.center;
    
    //display
    activityIndicatorView.hidden = NO;
    
    //animating
    [activityIndicatorView startAnimating];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
    
    if (autoresizesContent) {
        [self adjustContentForWebView:webView];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicatorView stopAnimating];
        
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:webView didFailLoadWithError:error];
    }
}

#pragma mark - Modify web view content

-(void)adjustContentForWebView:(UIWebView *)webView
{
    CGFloat width = webView.bounds.size.width;
    
    //modify html meta viewport (device-width)
    //<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    NSString *metaViewport = [NSString stringWithFormat:@"\
                              var newContent = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\";\
                              var metaViewport = document.getElementsByName(\"viewport\")[0];\
                              if (metaViewport) {\
                              metaViewport.content = newContent;\
                              } else {\
                              var head = document.documentElement.firstChild;\
                              metaViewport = document.createElement(\"meta\");\
                              metaViewport.setAttribute(\"name\", \"viewport\");\
                              metaViewport.setAttribute(\"content\", newContent);\
                              head.appendChild(metaViewport);\
                              }", width];
    
    [webView stringByEvaluatingJavaScriptFromString:metaViewport];
    
    //resize images
    //<img src="" width="200" height="200">
    NSString *resizeImagesScript = [NSString stringWithFormat:
                                    @"var script = document.createElement('script');"
                                    "script.type = 'text/javascript';"
                                    "script.text = \"function ResizeImages() { "
                                    "var myimg,oldwidth,oldheight,mystyle;"
                                    "var maxwidth = %f;"
                                    "for(i=0;i <document.images.length;i++) {"
                                    "myimg = document.images[i];"
                                    "mystyle = myimg.style;"
                                    "mystyle.width = null;"
                                    "mystyle.height = null;"
                                    "if(myimg.width > maxwidth) {"
                                    "oldwidth = myimg.width;"
                                    "oldheight = myimg.height;"
                                    "myimg.width = maxwidth;"
                                    "myimg.height = oldheight * (maxwidth/oldwidth);"
                                    "}"
                                    "}"
                                    "}\";"
                                    "document.getElementsByTagName('head')[0].appendChild(script);", width - 20];
    
    [webView stringByEvaluatingJavaScriptFromString:resizeImagesScript];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
    //NSLog(@"<html>%@</html>", html);
}

@end