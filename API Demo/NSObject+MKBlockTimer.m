//
//  NSObject+MKBlockTimer.m
//  API Demo
//
//  Created by 杨毅辉 on 15/7/4.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "NSObject+MKBlockTimer.h"

@implementation NSObject (MKBlockTimer)

-(void)logTimeTakenToRunBlock:(void (^)(void))block withPrefix:(NSString*)prefixString {
    
    double a = CFAbsoluteTimeGetCurrent();
    block();
    double b = CFAbsoluteTimeGetCurrent();
    
    double m = ((b-a) * 1000.0f); // convert from seconds to milliseconds
    
    NSLog(@"%@: %.5f ms", prefixString ? prefixString : @"Time taken", m);
}

@end
