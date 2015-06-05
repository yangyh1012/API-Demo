//
//  ThreadAndGCD.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/27.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "ThreadAndGCD.h"

@implementation ThreadAndGCD

#pragma mark - NSThread

- (void)testNSThread:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(calculationThreadEntry)
                             toTarget:self
                           withObject:nil];
}

- (void)calculationThreadEntry {
    
    @autoreleasepool {
        
        NSUInteger counter = 0;
        while ([[NSThread currentThread] isCancelled] == NO) {
            
            //[self doCalculation];
            counter++;
            if (counter >= 100)
            {
                break;
            }
        }
    }
}

#pragma mark - GCD

- (void)testGCD:(id)sender {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    size_t numberOfIterations = 100;
    dispatch_async(queue, ^(void) {
        
        dispatch_apply(numberOfIterations,queue, ^(size_t iteration){
            
            //[self doCalculation];
        });
    });
    
    /*
    在GCD中，有3种类型的派发队列：
     
    串行队列。
    串行队列通常用于同步访问一个特定的资源，每次只能执行一个任务。使用函数 dispatch_queue_create，可以创建串行队列。
     
    并发队列。
    也称为全局派发队列，可以并发地执行一个或多个任务。并发队列分为高、中、低3个优先级队列，中级为默认级别。
    可以使用调用dispatch_get_global_queue函数设定优先级来访问队列。在上面介绍的ConcurrencyTest工程中，
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)语句用于获得并发队列对象，
    其中DISPATCH_QUEUE_PRIORITY_DEFAULT是默认的优先级常量。
    
    主队列。
    它在应用程序的主线程中，用于更新UI。其他的两个队列不能更新UI。使用dispatch_get_main_queue函数，可以获得主队列。
     
    */
}


- (void)click:(id)sender {
    
    NSURL *imgkURL = [NSURL URLWithString:@"http://www.51work6.com/ios_book/animals/animal-3.png"];
    
    //创建串行队列
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.51work6.image.downloader",NULL);
    
    //异步执行
    dispatch_async(downloadQueue, ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:imgkURL];
        UIImage *img = [UIImage imageWithData:imgData];
        NSLog(@"%@",img);
        
        //主线程中更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //self.imageView.image = img;
        });
    });
}

@end
