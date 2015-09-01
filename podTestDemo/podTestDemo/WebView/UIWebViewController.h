//
//  UIWebViewController.h
//   
//
//  Created by zhihuiguan on 14-7-8.
//  Copyright (c) 2014年 freedom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"

@interface UIWebViewController : UIViewController{

    // before  viewdid load the tab status
    BOOL tabShow;
}

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, assign) BOOL showsWebViewControls;

@property (strong, nonatomic) WebViewJavascriptBridge *javascriptBridge;


-(void)goBack:(BOOL)animated;
@end
