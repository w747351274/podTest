//
//  BaseView.m
//  Pro10788
//
//  Created by WangJiangLei on 14/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (void)initViews{
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending ){
        //ios7 pushviewcontroller 透明效果不好的bug
        self.backgroundColor = [UIColor whiteColor];
    }
}
- (void)initService{

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self initService];
        [self initViews];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
