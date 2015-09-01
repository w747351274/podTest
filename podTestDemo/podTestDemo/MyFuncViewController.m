//
//  MyFuncViewController.m
//  podTestDemo
//
//  Created by wangjl on 15/8/31.
//  Copyright (c) 2015年 wangjl. All rights reserved.
//

#import "MyFuncViewController.h"

@implementation MyFuncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectInset(self.view.frame, 20,100)];
    imageView.image = UIResourceBundleImage(@"sdj");
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end