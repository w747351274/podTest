//
//  SettingItem.h
//  FM
//
//  Created by Jianglei Wang on 2/27/15.
//  Copyright (c) 2015 Jianglei Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingItem : NSObject

@property(nonatomic ,strong)NSString *imgIcon;
@property(nonatomic ,strong)NSString *itemName;
@property(nonatomic ,strong)NSString *funcURL;
@property(nonatomic ,strong)Class cls;

-(id)initWithIcon:(NSString *)img withName:(NSString *)strName;
-(id)initWithIcon:(NSString *)img withName:(NSString *)strName withClass:(Class )cls withFuncUrl:(NSString *)funcUrl;
@end
