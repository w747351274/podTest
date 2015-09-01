//
//  PayViewController.m
//  podTestDemo
//
//  Created by wangjl on 15/8/27.
//  Copyright (c) 2015年 wangjl. All rights reserved.
//

#import "PayViewController.h"
#import "UIButton+Addition.h"
#import "NSDate+Addition.h"
#import "HttpUtil.h"
#import "URLDefine.h"


@interface PayViewController (){
    UILabel *label;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
}

@end

@implementation PayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithStr:@"重试"];
    [btn addTarget:self action:@selector(actionRetry:) forControlEvents:UIControlEventTouchUpInside];
    [btn setCenter:CGPointMake(self.view.center.x, 100)];
    [self.view addSubview:btn];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 200, 50)];

    [self.view addSubview:label];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 170, 200, 50)];
    [self.view addSubview:label2];
    
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, 220, 200, 50)];
    [self.view addSubview:label3];
    
    label4 = [[UILabel alloc]initWithFrame:CGRectMake(20, 270, 200, 50)];
    [self.view addSubview:label4];
    
    [label setText:@"付款APP:"];
    [label2 setText:@"收款:"];
    [label3 setText:@"购买数量:"];
    [label4 setText:@"购买日期"];
    
    
    [self requestData];
}
-(void)actionRetry:(id)sender{
    [self requestData];
}
-(void)requestData{
    [HttpUtil requestUrl:URL_WT okBlock:^(NSDictionary *dict) {
        
        NSLog(@"%@",dict);
        [label setText:[NSString stringWithFormat:@"付款APP:%@",dict[@"data"][@"from"]]];
        [label2 setText:[NSString stringWithFormat:@"收款:%@",dict[@"data"][@"fee"]]];
        [label3 setText:[NSString stringWithFormat:@"购买数量:%@",dict[@"data"][@"count"]]];
        NSString *nowTime = [[NSDate date]convertDateToStringWithFormat:@"yyyy年MM月dd日"];
        [label4 setText:[NSString stringWithFormat:@"购买日期:%@",nowTime]];
        
    } ngBlock:^(NSString *error) {
        
    }];
    
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
