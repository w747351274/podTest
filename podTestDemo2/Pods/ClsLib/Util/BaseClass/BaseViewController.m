//
//  BaseViewController.m
//  CardMaster
//
//  Created by Lyner on 13-7-9.
//  Copyright (c) 2013年 GL. All rights reserved.
//

#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)loadView {
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor whiteColor];
}

// 初始化共通设置,比如背景图,导航栏风格等
- (void)initViews
{    
}

-(void)initService{
    
}
////////////////////////////////////////////////////////////
// UIGestureRecognizerDelegate methods

#pragma mark UIGestureRecognizerDelegate methods


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    BOOL result = YES;
 
    return result;
}

- (void)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    [self initService];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

-(void)orientationDidChange:(BOOL)isOrientationIsLandscape{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// a param to describe the state change, and an animated flag
// optionally add a completion block which matches UIView animation
- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    
    // bail if the current state matches the desired state
    if ([self tabBarIsVisible] == visible) return;
    
    // get a frame calculation ready
    
    CGFloat height = [self tabBarHeight];
    CGFloat offsetY = (visible)? -height : height;
    
    // zero duration means no animation
    CGFloat duration = (animated)? 0.3 : 0.0;
    
    [UIView animateWithDuration:duration animations:^{
        self.tabBarController.tabBar.frame = CGRectOffset(self.tabBarController.tabBar.frame, 0, offsetY);
    } completion:^(BOOL finished){
        if (completion) {
            completion(finished);
        }
    }];
}

-(CGFloat)tabBarHeight{
    CGRect frame = self.tabBarController.tabBar.frame;
    CGFloat height = frame.size.height;
    return height;
}

// know the current state
- (BOOL)tabBarIsVisible {
    return self.tabBarController.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame);
}

-(CGFloat)naviHeight{
    return CGRectGetHeight(self.navigationController.navigationBar.frame) + 20;
}

-(BOOL)naviIsVisble{
    return self.navigationController.navigationBar.frame.origin.y +  self.navigationController.navigationBar.frame.size.height >= CGRectGetMinY(self.view.frame);
}

 
@end
