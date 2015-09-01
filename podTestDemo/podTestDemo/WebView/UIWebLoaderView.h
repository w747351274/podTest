//
//  UIWebLoaderView.h
//   
//
//  Created by zhihuiguan on 13-6-24.
//  Copyright (c) 2013年 freedom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebLoaderView : UIWebView

@property(nonatomic, weak) id<UIWebViewDelegate> delegate;
@property (assign) BOOL autoresizesContent;

@end