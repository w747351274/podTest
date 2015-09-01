//
//  ResourceManager.m
//  ClsLib
//
//  Created by wangjl on 15/8/27.
//  Copyright (c) 2015年 wangjl. All rights reserved.
//

#import "ResourceManager.h"

@implementation ResourceManager
+(NSString *)appDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *)appCachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *)applicationSupportDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *)appTemporaryDirectory
{
    return NSTemporaryDirectory();
}

+(NSString *)currentUserDirectory
{
    return [self userDirectoryWithID:UserId];
}

+(NSString *)userDirectoryWithID:(NSString *)userID
{
    if (!userID) {
        return nil;
    }
    
    NSString *appDocDir = [self appDocumentsDirectory];
    
    NSString *rootUserDir = [appDocDir stringByAppendingPathComponent:@"user"];
    NSString *userDir = [rootUserDir stringByAppendingPathComponent:userID];
    if (![self resolveDirectoryAtPath:userDir]) {
        return nil;
    }
    
    return userDir;
}
+(NSArray *)getFilesInDir:(NSString *)dir{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *files = [fileManager subpathsAtPath: dir ];
    return files;
    
}
+(BOOL)resolveDirectoryAtPath:(NSString *)dirPath
{
    if (!dirPath) {
        NSLog(@"Error unresolved path: %@", dirPath);
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDir] || !isDir) {
        NSError *error = nil;
        BOOL result = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!result) {
            NSLog(@"%@", [NSString stringWithFormat:@"%@: Unresolved error %@, %@", [self class], error, [error userInfo]]);
            return NO;
        }
    }
    
    return YES;
}
+(BOOL)isExist:(NSString *)filePath{
    BOOL isExist;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    isExist = [fileManager fileExistsAtPath:filePath];
    return isExist;
}

+(BOOL)createPlistFile:(NSString *)strFileName{
    NSString *path=[ResourceManager appDocumentsDirectory];
    NSString *fileName = [NSString stringWithFormat:@"%@.plist",strFileName];
    NSString *filePath=[path stringByAppendingPathComponent:fileName];
    NSFileManager* fm = [NSFileManager defaultManager];
    if ([ResourceManager isExist:filePath]) {
        NSError *err;
        [fm removeItemAtPath:filePath error:&err];
        if (err) {
            NSLog(@"%@",err);
        }
    }
    return [fm createFileAtPath:filePath contents:nil attributes:nil];
}
+(NSDictionary *)dicFromPlist:(NSString *)strFileName{
    NSString *filePath = [ResourceManager filePathWithName:strFileName];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

+(NSArray *)arrFromPlist:(NSString *)strFileName{
    NSString *filePath = [ResourceManager filePathWithName:strFileName];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    return arr;
}

+(NSString *)filePathWithName:(NSString *)strFileName{
    NSString *path=[ResourceManager appDocumentsDirectory];
    NSString *fileName = [NSString stringWithFormat:@"%@.plist",strFileName];
    NSString *filePath=[path stringByAppendingPathComponent:fileName];
    if ([ResourceManager isExist:filePath]) {
        return filePath;
    }else{
        return nil;
    }
}
@end
