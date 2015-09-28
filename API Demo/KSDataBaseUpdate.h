//
//  KSDataBaseUpdate.h
//  KnowSomething
//
//  Created by 杨毅辉 on 15/9/20.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSDataBaseUpdate : NSObject

@property (nonatomic, copy) NSString *className;

@property (nonatomic, assign) long long int classId;

@property (nonatomic, copy) NSString *columnName;

@property (nonatomic, copy) NSString *columnValue;

@end
