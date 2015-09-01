//
//  ResourceManager.h
//  ClsLib
//
//  Created by wangjl on 15/8/27.
//  Copyright (c) 2015年 wangjl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>


#define UserId @"testUserId"


CG_INLINE UIImage * UIResourceBundleImage(NSString *strPath){
    return [UIImage imageNamed:[NSString stringWithFormat:@"default.bundle/image/%@.png",strPath]];
}

CG_INLINE NSDictionary *PropertyList(NSString *strPath){
    NSString *strBundlePath = [[NSBundle mainBundle]pathForResource:@"default" ofType:@"bundle"];
    NSBundle* myBundle =[NSBundle bundleWithPath:strBundlePath];
    
    // Obtain a reference to a loadable bundle.
    
    NSString *resultPath = [myBundle pathForResource:strPath ofType:nil];
    NSDictionary *dictionary=[[NSDictionary alloc]initWithContentsOfFile:resultPath];
    return dictionary;
}

@interface ResourceManager : NSObject

+(NSString *)appDocumentsDirectory;

+(NSString *)appCachesDirectory;

+(NSString *)applicationSupportDirectory;

+(NSString *)appTemporaryDirectory;

+(NSString *)currentUserDirectory;

+(NSString *)userDirectoryWithID:(NSString *)userID;
+(NSArray *)getFilesInDir:(NSString *)dir;
+(BOOL)resolveDirectoryAtPath:(NSString *)dirPath;
+(BOOL)isExist:(NSString *)filePath;

+(NSString *)filePathWithName:(NSString *)strFileName;
+(BOOL)createPlistFile:(NSString *)strFileName;
+(NSDictionary *)dicFromPlist:(NSString *)strFileName;
+(NSArray *)arrFromPlist:(NSString *)strFileName;
@end
