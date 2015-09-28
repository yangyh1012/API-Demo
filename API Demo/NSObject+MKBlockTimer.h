//
//  NSObject+MKBlockTimer.h
//  API Demo
//
//  Created by 杨毅辉 on 15/7/4.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  计算代码执行的时间
 */
@interface NSObject (MKBlockTimer)

- (void)logTimeTakenToRunBlock:(void (^)(void))block withPrefix:(NSString*)prefixString;

@end
