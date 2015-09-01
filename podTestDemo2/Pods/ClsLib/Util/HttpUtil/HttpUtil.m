//
//  HttpUtil.m
//  FM
//
//  Created by Jianglei Wang on 3/25/15.
//  Copyright (c) 2015 Jianglei Wang. All rights reserved.
//

#import "HttpUtil.h"
#import "AFNetworking.h"

@implementation HttpUtil

+(void)requestHtmlUrl:(NSString *)strUrl okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:5];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        okBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* newStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Error: %@", error);
        NSLog(@"Error: %@", newStr);
        NSString *str = [NSString stringWithFormat:@"%@",error];
        ngBlock(str);
    }];
}


+(void)requestUrl:(NSString *)strUrl okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:5];
    
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        okBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* newStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Error: %@", error);
        NSLog(@"Error: %@", newStr);
        NSString *str = [NSString stringWithFormat:@"%@",error];
        ngBlock(str);
    }];
}

+(void)postRequestUrl:(NSString *)strUrl para:(NSDictionary *)parmDic okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:parmDic];

        [manager POST:strUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(),^{
                
                okBlock(responseObject);});
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString* newStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@", newStr);
            NSString *str = [NSString stringWithFormat:@"%@",error];
            ngBlock(str);
        }];
    });
}

+(void)postRequestUrl:(NSString *)strUrl para:(NSDictionary *)parmDic file:(NSString *)filePath okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = parmDic;
    NSURL *path = [NSURL fileURLWithPath:filePath];
    [manager POST:strUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:path name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {

        okBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSString *str = [NSString stringWithFormat:@"%@",error];
        ngBlock(str);
    }];
}
+(void)postRequestUrl:(NSString *)strUrl para:(NSDictionary *)parmDic imageKey:(NSString *)key image:(UIImage *)img okBlock:(okBlock_t)okBlock ngBlock:(ngBlock_t)ngBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:parmDic];
    NSData* imgData = UIImagePNGRepresentation(img);
    [manager POST:strUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *fileName = [NSString stringWithFormat:@"image_%@.png",[NSDate new]];
        [formData appendPartWithFileData:imgData
                                    name:key
                                fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        okBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSString *str = [NSString stringWithFormat:@"%@",error];
        ngBlock(str);
    }];
}

@end
