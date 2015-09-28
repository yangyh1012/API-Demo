//
//  KSPlistFileHandle.m
//  KnowSomething
//
//  Created by 杨毅辉 on 15/8/21.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "KSPlistFileHandle.h"

#define INFONAME    @"initData.plist"

@implementation KSPlistFileHandle

static KSPlistFileHandle *sharedManager = nil;

+ (KSPlistFileHandle *)sharedManager {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
        [sharedManager createDatas];
    });
    return sharedManager;
}

- (void)createDatas {
    
    self.datas = [[NSMutableArray alloc] init];
    
    NSString *plistPath = [self plistFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dbexits = [fileManager fileExistsAtPath:plistPath];
    
    if (dbexits) {
    
        DLog(@"工程下initData.plist文件读取成功");
        
//        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
//        for (NSDictionary *dic in array) {
//            
//            KSDataBaseClassify *classify = [[KSDataBaseClassify alloc] init];
//            classify.classifyId = [dic[@"classifyId"] longLongValue];
//            classify.classifyName = dic[@"classifyName"];
//            classify.classifyImage = dic[@"classifyImage"];
//            classify.infos = [[NSMutableArray alloc] init];
//            
//            for (NSDictionary *dic2 in dic[@"infos"]) {
//                
//                KSDataBaseThing *thing = [[KSDataBaseThing alloc] init];
//                thing.thingId = [dic2[@"thingId"] longLongValue];
//                thing.thingName = dic2[@"thingName"];
//                thing.thingRecord = dic2[@"thingRecord"];
//                thing.thingImage1 = dic2[@"thingImage1"];
//                thing.thingImage2 = dic2[@"thingImage2"];
//                thing.thingImage3 = dic2[@"thingImage3"];
//                thing.classifyId = [dic2[@"classifyId"] longLongValue];
//                
//                [classify.infos addObject:thing];
//            }
//            
//            [self.datas addObject:classify];
//        }
        DLog(@"工程下initData.plist文件数据：%@",self.datas);
    }
}

- (NSString *)plistFilePath {
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:INFONAME];
    
    DLog(@"工程下initData.plist文件路径：%@",path);
    
    return path;
}

@end
