//
//  UILabel+AgileCreate.h
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AgileCreate)
+(UILabel *)labelWithContent:(NSString *)str;
+(UILabel *)labelWithString:(NSString *)str;
- (void)alignTop;
@end
