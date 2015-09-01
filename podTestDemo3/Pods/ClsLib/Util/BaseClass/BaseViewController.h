//
//  BaseViewController.h
//  CardMaster
//
//  Created by Lyner on 13-7-9.
//  Copyright (c) 2013年 GL. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline bool isOrientationIsLandscape() {
    return UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
}

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
{
 
 
    BOOL previousOritation;

    // before  viewdid load the tab status 
    BOOL tabShow;
}
@property (strong,nonatomic) UILabel * navigationBarTitle;


// 设定画面元素
- (void)initViews;
-(void)initService;


//tabbar
- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(BOOL)tabBarIsVisible;
-(CGFloat)tabBarHeight;

-(CGFloat)naviHeight;
-(BOOL)naviIsVisble;
 
@end
