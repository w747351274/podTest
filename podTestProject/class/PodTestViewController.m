//
//  ViewController.m
//  podTest
//
//  Created by wangjl on 15/8/13.
//  Copyright (c) 2015年 wangjl. All rights reserved.
//

#import "PodTestViewController.h"

@interface PodTestViewController ()

@end

@implementation PodTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 50)];
    [label setText:@"this is for podTest Label"];
    [self.view addSubview:label];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 200, 50)];
    [label2 setText:@"this is for podTest Label"];
    [self.view addSubview:label2];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 200, 50)];
    [label3 setText:@"this is for podTest Label"];
    [self.view addSubview:label3];
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(20, 170, 200, 50)];
    [label setText:@"this is for podTest Label"];
    [self.view addSubview:label4];
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(20, 220, 200, 50)];
    [label setText:@"this is for podTest Label"];
    [self.view addSubview:label5];
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
