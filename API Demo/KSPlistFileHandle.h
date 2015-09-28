//
//  KSPlistFileHandle.h
//  KnowSomething
//
//  Created by 杨毅辉 on 15/8/21.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSPlistFileHandle : NSObject

@property (nonatomic, strong) NSMutableArray *datas;

+ (KSPlistFileHandle *)sharedManager;

@end
