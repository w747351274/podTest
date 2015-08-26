//
//  ViewController.h
//  podTestDemo
//
//  Created by wangjl on 15/8/24.
//  Copyright (c) 2015年 wangjl. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    CELL_PODTEST,
    CELL_COUNT

};

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
}

@property(nonatomic,strong)UITableView *tableView;


@end

