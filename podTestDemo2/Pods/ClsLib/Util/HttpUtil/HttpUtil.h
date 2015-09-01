//
//  HttpUtil.h
//  FM
//
//  Created by Jianglei Wang on 3/25/15.
//  Copyright (c) 2015 Jianglei Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>


typedef void(^okBlock_t)(NSDictionary * dict);
typedef void(^okArrBlock_t)(NSArray * arr);
typedef void(^ngBlock_t)(NSString * error);

@interface HttpUtil : NSObject
+(void)requestHtmlUrl:(NSString *)strUrl okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock;
+(void)requestUrl:(NSString *)strUrl okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock;
+(void)postRequestUrl:(NSString *)strUrl para:(NSDictionary *)parmDic okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock;
+(void)postRequestUrl:(NSString *)strUrl para:(NSDictionary *)parmDic file:(NSString *)filePath okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock;
+(void)postRequestUrl:(NSString *)strUrl para:(NSDictionary *)parmDic imageKey:(NSString *)key image:(UIImage *)img okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock;
@end
