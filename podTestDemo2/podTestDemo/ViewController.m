//
//  ViewController.m
//  podTestDemo
//
//  Created by wangjl on 15/8/24.
//  Copyright (c) 2015年 wangjl. All rights reserved.
//

#import "ViewController.h"
#import "PodTestViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PayViewController.h"
#import "ResourceManager.h"
#import "HttpUtil.h"
#import "SettingItem.h"
#import "MyFuncViewController.h"
#import "Myfunc2ViewController.h"

static NSString *propFileName = @"appConfig";
static NSString *configUrl = @"http://app1.demo.com:8082/ConfServer/getAppProperty?AppTId=%@";

CG_INLINE Class funcTest(NSString *str){
    
    if([str isEqualToString:@"002-func1"] ) {
        return [PodTestViewController class];
    }else if ([str isEqualToString:@"002-func2"]){
        return [PayViewController class];
    }else if ([str isEqualToString:@"002-func3"]){
        return [MyFuncViewController class];
    }else if ([str isEqualToString:@"002-func4"]){
        return [Myfunc2ViewController class];
    }else {
        return Nil;
    }
    
}
@interface ViewController (){
    
    NSDictionary *propertyDic;
    NSArray *arrFuncDataSource;
    UILabel *footer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 84)];
    
    footer = [[UILabel alloc]initWithFrame:CGRectInset(footerView.frame, 10, 3)];
    [footer setNumberOfLines:0];
    [footerView addSubview:footer];
    self.tableView.tableFooterView = footerView;
    [self.view addSubview:self.tableView];
    
    UIButton *btnRefresh = [UIButton buttonWithStr:@"refresh"];
    [btnRefresh addTarget:self action:@selector(actionRefresh:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView: btnRefresh];
    
    //获取缓存配置数据（appDocumentsDirectory）
     NSDictionary *dicDocu = [ResourceManager dicFromPlist:propFileName];
    if (!dicDocu) {
        //读取默认配置数据（mainbundle）
        propertyDic = PropertyList(@"files/appConfig.plist");
        
    }else{
        propertyDic = dicDocu;
    }
    
    
    NSLog(@"dic ->%@",propertyDic);
    
    [self setup];
    //请求数据更新版本
    [self requestData];
    
}

-(void)setFuncDataSource{
    NSMutableArray * funcconfigList = [[NSMutableArray alloc]initWithCapacity:3];
    [propertyDic[@"funcconfigList"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
 
        NSInteger showFlag = [obj[@"funcshow"] integerValue];
        Class cls = funcTest(obj[@"funcval"]);
        if (showFlag == 1&& cls != Nil) {
            [funcconfigList addObject:[[SettingItem alloc]initWithIcon:obj[@"iconurl"] withName:obj[@"funname"] withClass:cls]];
        }
    }];
    
    arrFuncDataSource = [funcconfigList copy];
}

//配置功能
-(void)setup{
    self.navigationItem.title = propertyDic[@"appname"];
    [self setFuncDataSource];
    [footer setText:propertyDic[@"apdesc"]];
    [self.tableView reloadData];
}

-(void)requestData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       //request data
        [HttpUtil requestUrl:[NSString stringWithFormat:configUrl,AppId] okBlock:^(NSDictionary *dict) {
            NSLog(@"receiveData ->%@",dict);
            if ([dict[@"status"] isEqualToString:@"1"]) {
                NSDictionary *dicToSave = dict[@"data"];
                if ([dicToSave[@"ver"] integerValue] > [propertyDic[@"ver"] integerValue]) {
                    if ([ResourceManager createPlistFile:propFileName]) {
                        [dicToSave writeToFile:[ResourceManager filePathWithName:propFileName] atomically:YES];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            propertyDic = [ResourceManager dicFromPlist:propFileName];
                            [self setup];
                        });
                    }
                }
            }
        } ngBlock:^(NSString *error) {
             NSLog(@"error ->%@",error);
        }];
        
    });
}
-(void)actionRefresh:(id)sender{
    //请求数据更新版本
    [self requestData];
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrFuncDataSource count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString static *cellIdentifier = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }


    
    SettingItem *item =[arrFuncDataSource objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.imgIcon]
                      placeholderImage:UIResourceBundleImage(@"chat_bg_image_left")];
    cell.textLabel.text = item.itemName;
    cell.accessoryView = [[UIImageView alloc]initWithImage:UIResourceBundleImage(@"chevron")];
    
    cell.accessoryType =UITableViewCellAccessoryDetailButton;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    SettingItem *item =[arrFuncDataSource objectAtIndex:indexPath.row];
    UIViewController *controller = [[item.cls alloc]init];
    controller.navigationItem.title = item.itemName;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
