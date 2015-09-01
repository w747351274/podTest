//
//  HtmlTextViewViewController.m
//  Plattii-new
//
//  Created by Jianglei Wang on 3/31/15.
//  Copyright (c) 2015 Jianglei Wang. All rights reserved.
//

#import "HtmlTextViewViewController.h"

@interface HtmlTextViewViewController ()

@end

@implementation HtmlTextViewViewController
@synthesize strHtml = _strHtml;

-(void)initViews{
 
    self.textView = [[UITextView alloc]initWithFrame:self.view.bounds];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.strHtml dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.textView.attributedText = attributedString;
    [self.view addSubview:self.textView];
}

-(void)setStrHtml:(NSString *)strHtml{
    _strHtml = strHtml;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.textView.attributedText = attributedString;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
