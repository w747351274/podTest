//
//  ViewController.m
//  podTestDemo
//
//  Created by wangjl on 15/8/24.
//  Copyright (c) 2015年 wangjl. All rights reserved.
//

#import "ViewController.h"
#import "PodTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return CELL_COUNT;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString static *cellIdentifier = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.row) {
        case CELL_PODTEST:
            cell.textLabel.text = @"PodTest";
            break;
            
        default:
            break;
    }
    cell.accessoryType =UITableViewCellAccessoryDetailButton;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PodTestViewController *podTestViewController = [[PodTestViewController alloc]init];
    [self.navigationController pushViewController:podTestViewController animated:YES];
    

}
@end
