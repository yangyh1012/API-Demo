//
//  KSDataBaseUpdate.m
//  KnowSomething
//
//  Created by 杨毅辉 on 15/9/20.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "KSDataBaseUpdate.h"

@implementation KSDataBaseUpdate

- (BOOL)isEqual:(id)object {
    
    KSDataBaseUpdate *compareObj = (KSDataBaseUpdate *)object;
    
    NSString *str = [NSString stringWithFormat:@"%@_%llu_%@",self.className,self.classId,self.columnName];
    
    NSString *compareStr = [NSString stringWithFormat:@"%@_%llu_%@",compareObj.className,compareObj.classId,compareObj.columnName];
    
    if ([str isEqualToString:compareStr]) {
        
        return YES;
    } else {
        
        return NO;
    }
}

- (NSUInteger)hash {
    
    return (NSUInteger)self;
}

@end
