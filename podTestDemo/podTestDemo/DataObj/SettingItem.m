//
//  SettingItem.m
//  FM
//
//  Created by Jianglei Wang on 2/27/15.
//  Copyright (c) 2015 Jianglei Wang. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

-(id)initWithIcon:(NSString *)img withName:(NSString *)strName{
    self = [super init];
    if (self) {
    }
    self.itemName = strName;
    self.imgIcon = img;
    return self;
}
-(id)initWithIcon:(NSString *)img withName:(NSString *)strName withClass:(Class )cls{
    self = [super init];
    if (self) {
    }
    self.itemName = strName;
    self.imgIcon = img;
    self.cls = cls;
    return self;
}
-(id)initWithIcon:(NSString *)img withName:(NSString *)strName withClass:(Class )cls withFuncUrl:(NSString *)funcUrl{
    self = [super init];
    if (self) {
    }
    self.itemName = strName;
    self.imgIcon = img;
    self.cls = cls;
    self.funcURL = funcUrl;
    return self;

}
@end
