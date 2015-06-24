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
    
    /**
     *  创建并发线程
     *
     */
    [NSThread detachNewThreadSelector:@selector(calculationThreadEntry)
                             toTarget:self
                           withObject:nil];
    
    /**
     *  当前线程
     */
    NSLog(@"Current thread = %@", [NSThread currentThread]);
    
    /**
     *  以在一段给定的时间之后调用对象中的选择器
     *
     */
    [self performSelector:@selector(printString:)
               withObject:@"Grand Central Dispatch"
               afterDelay:3.0];
    
    /**
     *  在后台创建了一个线程
     *
     */
    [self performSelectorInBackground:@selector(firstCounter)
                           withObject:nil];
    
    /**
     停止线程
     
     */
    NSThread *myThread = [[NSThread alloc]
                          initWithTarget:self
                          selector:@selector(threadEntryPoint)
                          object:nil];
    [NSThread sleepForTimeInterval:4];//每次循环都会休眠4 秒钟
    [self performSelector:@selector(stopThread)
               withObject:nil
               afterDelay:3.0f];
    [myThread start];
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

- (void)printString:(NSString *)paramString {
    
    NSLog(@"%@", paramString);
}

- (void)firstCounter {
    
    @autoreleasepool {
        
        NSUInteger counter = 0;
        for (counter = 0;
             counter < 1000;
             counter++){
            NSLog(@"First Counter = %lu", (unsigned long)counter);
        }
    }
}

- (void)stopThread {
    
    /**
     *  取消线程
     *
     */
//    NSLog(@"Cancelling the Thread");
//    [self.myThread cancel];
//    NSLog(@"Releasing the thread");
//    self.myThread = nil;
}

- (void)threadEntryPoint {
    
    @autoreleasepool {
        
        NSLog(@"Thread Entry Point");
        while ([[NSThread currentThread] isCancelled] == NO) {
            [NSThread sleepForTimeInterval:4];
            if ([[NSThread currentThread] isCancelled] == NO) {
                
                NSLog(@"Thread Loop");
            }
        }
        NSLog(@"Thread Finished");
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
     
     Main Queue：（dispatch_get_main_queue）
     这个队列在主线程上执行它的所有任务，Cocoa 和 Cocoa Touch 允许程序员在主线程
     上调用一切UI-related 方法。使用dispatch_get_main_queue 函数检索到主队列的句柄。
     
     Concurrent Queues：（dispatch_get_global_queue）
     为了执行异步和同步任务，你可以在GCD 中检索到这些队列。多个并发队列能够轻而
     易举的并行执行多个任务，没有更多的线程管理，酷！使用dispatch_get_global_queue 函数
     检索一个并发队列的句柄。
     
     Serial Queues：
     无论你提交同步或者异步任务，这些队列总是按照先入先出（FIFO）的原则来执行任
     务，这就意味着它们一次执行一个Block Object。然而，他们不在主线程上运行，所以对于
     那些要按照严格顺序执行并不阻塞主线程的任务而言是一个完美的选择。使用
     dispatch_queue_create 函数创建一个串行队列。一旦你使用完队列， 必须使用
     dispatch_release 函数释放它。
     
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

- (void)gcdTest2 {
    
    dispatch_queue_t concurrentQueue1 = dispatch_get_main_queue();
    
    /**
     *  
     
     DISPATCH_QUEUE_PRIORITY_LOW
     您的任务比正常任务用到更少的时间片。
     
     DISPATCH_QUEUE_PRIORITY_DEFAULT
     执行代码的默认系统优先级将应用于您的任务。
     
     DISPATCH_QUEUE_PRIORITY_HIGH
     和正常任务相比，更多的时间片会应用到你的任务中。
     
     *
     */
    dispatch_queue_t concurrentQueue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t concurrentQueue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t concurrentQueue4 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //================================================================================================
    
    /**
     *  用GCD 执行与UI 相关的任务，使用dispatch_get_main_queue 函数。
     *  异步提交到主队列
     */
    dispatch_async(concurrentQueue1, ^{
        
        [[[UIAlertView alloc] initWithTitle:@"GCD333"
                                    message:@"GCD is amazing!"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        NSLog(@"3333");
    });
    
    //================================================================================================
    
    /**
     *  用GCD 同步执行非UI 相关的任务,使用dispatch_sync 函数。
     *
     */
    dispatch_sync(concurrentQueue2, ^{
        
        NSUInteger counter = 0;
        for (counter = 1; counter <= 1000; counter++) {
            
            NSLog(@"Counter = %lu - Thread = %@",(unsigned long)counter,[NSThread currentThread]);
        }
        
        NSLog(@"Current thread = %@", [NSThread currentThread]);
    });
    
    //================================================================================================
    
    /**
     *  在GCD 上异步执行非UI 相关任务。
     *
     */
    dispatch_async(concurrentQueue3, ^{
        
        __block UIImage *image = nil;
        dispatch_sync(concurrentQueue3, ^{
            
            /* Download the image here */
        });
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            /* Show the image to the user here on the main queue*/
            
            NSLog(@"%@",image);
        });
    });
    
    //================================================================================================
    
    /**
     *  保存10000个随机数组
     */
    dispatch_async(concurrentQueue4, ^{
       
        dispatch_sync(concurrentQueue4, ^{
            
            
        });
        
        dispatch_sync(concurrentQueue4, ^{
            
            
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
        });
    });
    
    //================================================================================================
    
    double delayInSeconds = 2.0;
    /**
     *  绝对时间的抽象表示形式
     *
     *  @param DISPATCH_TIME_NOW 
     *  假设这个值为B，Delta parameter 值为 D，通过这个函数结束的时间就等于B+D。您
     *  可以设置此参数的值到DISPATCH_TIME_NOW 来把现在作为基时间，然后从现在使用
     *  Delta 参数来确定Delta。
     *
     *  @param NSEC_PER_SEC      这个参数是要增加到计算时间参数来获取函数结果的纳秒。
     *
     */
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue5 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    /**
     *  通过GCD 指定一个延迟，延迟到后，继续执行相关代码。
     *
     *  @param delayInNanoSeconds 
     *  在执行指定的Block Object(由第三个参数指定)之前GCD 必须在一个给定的分派队列
     *  (由第二个参数指定) 上等待的纳秒数。
     *
     *  @param concurrentQueue    
     *  Block Object (由第三个参数指定)在给定的延迟(由第一个参数指定)之后必须执行在其上
     *  执行的派送队列。
     *
     *  @param void               
     *  在指定的分派队列上等待一定纳秒后Block Object 会被调用；它没有返回值并且不接受
     *  参数
     *
     */
    dispatch_after(delayInNanoSeconds, concurrentQueue5, ^(void){
        
        /* Perform your operations here */
        
    });
    
    /**
     *  表示一个从现在开始3 秒的时间
     */
    dispatch_time_t delay1 = dispatch_time(DISPATCH_TIME_NOW, 3.0f * NSEC_PER_SEC);
    dispatch_after(delay1, concurrentQueue5, ^(void){
        
        /* Perform your operations here */
        
    });
    
    /**
     *  表示从现在开始半秒的时间
     */
    dispatch_time_t delay2 = dispatch_time(DISPATCH_TIME_NOW, (1.0 / 2.0f) * NSEC_PER_SEC);
    dispatch_after(delay2, concurrentQueue5, ^(void){
        
        /* Perform your operations here */
        
    });
    
    //================================================================================================
    
    /**
     *  Block Object 最多执行一次。
     */
    dispatch_once_t onceToken;
    void (^executedOnlyOnce)(void) = ^{
        
        static NSUInteger numberOfEntries = 0;
        numberOfEntries++;
        NSLog(@"Executed %lu time(s)", (unsigned long)numberOfEntries);
    };
    
    /**
     *  虽然我们使用dispatch_once 两次尝试调executedOnlyOnce Block
     *  Object，事实上GCD 对于这个Block Object 只执行了一次，因为两次传递到dispatch_once
     *  函数的标识符都一样。
     *
     */
    dispatch_queue_t concurrentQueue6 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_once(&onceToken, ^{
        
        dispatch_async(concurrentQueue6,executedOnlyOnce);
    });
    dispatch_once(&onceToken, ^{
        
        dispatch_async(concurrentQueue6,executedOnlyOnce);
    });
    
    //================================================================================================
    
    /**
     *  我们想知道什么时候GCD 会完成调用，那样就可以把信息展示给用户了。为了达到这个目的，我们应该使用一个组。
     *
     
     dispatch_group_create
     创建一个组句柄。一旦你使用完了这个组句柄，应该使用dispatch_release 函数将其释放。
     
     dispatch_group_async
     在一个组内提交一个代码块来执行。必须明确这个代码块属于哪个组，必须在哪个派送队列上执行。
     
     dispatch_group_notify
     允许你提交一个Block Object。一旦添加到这个组的任务完成执行之后，这个Block
     Object 应该被执行。这个函数也允许你明确执行Block Object 的分派队列。
     
     dispatch_release
     这个函数释放那任何一个你通过dispatch_group_create 函数创建的分派小组。
     
     *
     */
    dispatch_group_t taskGroup = dispatch_group_create();
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    /* Reload the table view on the main queue */
    dispatch_group_async(taskGroup, mainQueue, ^{
        
//        [self reloadTableView];
    });
    /* Reload the scroll view on the main queue */
    dispatch_group_async(taskGroup, mainQueue, ^{
        
//        [self reloadScrollView];
    });
    /* Reload the image view on the main queue */
    dispatch_group_async(taskGroup, mainQueue, ^{
        
//        [self reloadImageView];
    });
    /* At the end when we are done, dispatch the following block */
    dispatch_group_notify(taskGroup, mainQueue, ^{
        /* Do some processing here */
        [[[UIAlertView alloc] initWithTitle:@"Finished"
                                    message:@"All tasks are finished"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    });
    
    //================================================================================================
    
    /**
     *  创建你自己的串行分派队列
     *
     */
    dispatch_queue_t firstSerialQueue = dispatch_queue_create("com.pixolity.GCD.serialQueue1", 0);
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0;
             counter < 5;
             counter++){
            NSLog(@"First iteration, counter = %lu", (unsigned long)counter);
        }
    });
    
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0;
             counter < 5;
             counter++){
            NSLog(@"First iteration, counter = %lu", (unsigned long)counter);
        }
    });
    
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0;
             counter < 5;
             counter++){
            NSLog(@"First iteration, counter = %lu", (unsigned long)counter);
        }
    });
    
    //================================================================================================
}

#pragma mark - NSOperation

- (void)operationTest {
    
    /**
     *  使用Operation 同步运行任务
     */
    NSNumber *simpleObject = [NSNumber numberWithInteger:123];
    NSInvocationOperation *simpleOperation = [[NSInvocationOperation alloc]
                                              initWithTarget:self
                                              selector:@selector(simpleOperationEntry:)
                                              object:simpleObject];
    [simpleOperation start];
    
    NSBlockOperation *simpleOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"Main Thread = %@", [NSThread mainThread]);
        NSLog(@"Current Thread = %@", [NSThread currentThread]);
        NSUInteger counter = 0;
        for (counter = 0;
             counter < 1000;
             counter++){
            NSLog(@"Count = %lu", (unsigned long)counter);
        }
    }];
    [simpleOperation2 start];
    
    //================================================================================================
    
    /**
     *  使用Operation 异步运行任务
     */
    NSNumber *firstNumber = [NSNumber numberWithInteger:111];
    NSNumber *secondNumber = [NSNumber numberWithInteger:222];
    NSInvocationOperation *firstOperation =[[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(firstOperationEntry:)
                                            object:firstNumber];
    NSInvocationOperation *secondOperation = [[NSInvocationOperation alloc]
                                              initWithTarget:self
                                              selector:@selector(secondOperationEntry:)
                                              object:secondNumber];
    
    /**
     *  firstOperation执行后换secondOperation执行，Operations 之间的依赖
     */
    [firstOperation addDependency:secondOperation];
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    /* Add the operations to the queue */
    [operationQueue addOperation:firstOperation];
    [operationQueue addOperation:secondOperation];
    NSLog(@"Main thread is here");
    
    //================================================================================================
    
}

- (void)simpleOperationEntry:(id)paramObject {
    
    NSLog(@"Parameter Object = %@", paramObject);
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
    NSLog(@"Current Thread = %@", [NSThread currentThread]);
}

- (void)firstOperationEntry:(id)paramObject {
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"Parameter Object = %@", paramObject);
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
    NSLog(@"Current Thread = %@", [NSThread currentThread]);
}
- (void)secondOperationEntry:(id)paramObject {
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"Parameter Object = %@", paramObject);
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
    NSLog(@"Current Thread = %@", [NSThread currentThread]);
}


@end
