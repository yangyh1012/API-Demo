//
//  ObjectTest.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/6.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "ObjectTest.h"
#import "NSString+URLEncoding.h"
#import <CoreMotion/CoreMotion.h>
#import <objc/runtime.h>

/*说明：
 
 */
@implementation ObjectTest

#pragma mark - 单例设计

/*说明：单例设计，在一个iOS应用的生命周期中，有时候我们只需要某个类的一个实例。
 
 */
static ObjectTest *sharedManager = nil;
+ (ObjectTest *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
/*说明：
 UIApplication：提供了应用程序的集中控制点来保持应用的状态。
 
 NSURL *url = [NSURL URLWithString:@"http://www.51work6.com"];
 [[UIApplication sharedApplication] openURL:url];
 打开浏览器
 
 NSString* searchQuery = @"清华大学";
 searchQuery = [searchQuery stringByAddingPercentEscapesUsingEncoding:
 NSUTF8StringEncoding];
 NSString* urlString = [NSString stringWithFormat:
 @"http://maps.google.com/maps?q=%@", searchQuery];
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
 其中NSString的stringByAddingPercentEscapesUsingEncoding方法将字符串转换为URL编码
 
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];打电话
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:10086"]];发短信
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://eorient@sina.com"]];发邮件
 
 ------------------------------------------------------------------------------------------------------------------------------------
 
 UIAccelerometer：它可以访问重力加速计硬件设备，实时获得设备在x轴、y轴和z轴方向上的重力加速度。
 sharedAccelerometer
 
 NSUserDefaults：可以很方便地读取应用设置项目。
 standardUserDefaults
 
 NSNotificationCenter：提供信息广播通知，它采用观察者模式的通知机制。
 defaultCenter
 
 NSFileManager：提供了访问文件系统的通用操作，可以定位、创建、复制文件和文件夹。它还可以管理存储在iCloud上的数据。
 defaultManager
 
 NSBundle：提供了动态加载（或卸载）可执行代码、定位资源文件以及资源本地化、访问文件系统等功能。
 mainBundle
 
 //判断是否为iPhone设备
 [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone
 
 //获得当前测试设备IDFA
 [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
 
 */

#pragma mark - url相关方法

- (void)urlMethodTest {
    
    /*说明：用字符串创建一个URL对象
     URI的格式：<scheme> : <host> [ ? <query> ] [ # <fragment> ]
     
     */
    NSURL *url = [NSURL URLWithString:@"http://www.onevcat.com/2011/11/debug/;param?p=307#more-307::()123"];
    
    /*说明：协议名词
     
     */
    NSLog(@"Scheme: %@", [url scheme]);
    
    /*说明：主机名
     
     */
    NSLog(@"Host: %@", [url host]);
    
    /*说明：端口号
     
     */
    NSLog(@"Port: %@", [url port]);
    
    /*说明：路径，path可以有多个，每个用/连接，
     
     */
    NSLog(@"Path: %@", [url path]);
    
    /*说明：相对路径
     
     */
    NSLog(@"Relative path: %@", [url relativePath]);
    
    /*说明：路径组成数组
     
     */
    NSLog(@"Path components as array: %@", [url pathComponents]);
    
    /*说明：参数
     
     */
    NSLog(@"Parameter string: %@", [url parameterString]);
    
    /*说明：？号后面的字符串
     
     */
    NSLog(@"Query: %@", [url query]);
    
    /*说明：#号后面的字符串
     
     */
    NSLog(@"Fragment: %@", [url fragment]);
}

#pragma mark - plist配置文件

/*说明：配置文件设置
 
 */
- (void)plistFile {
    
    /*说明：工程属性文件Info.plist中的相关属性
     Application doesnot run in background
     设置为YES，使应用退出时终止程序的运行。
     
     */
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"provinces_cities"
                                           ofType:@"plist"];
    /*说明：获取属性列表文件中的全部数据
     
     */
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@",dict);
    
    /**
     *  获得info.plist文件
     */
    NSDictionary *infoDict = [bundle infoDictionary];
    NSLog(@"%@",infoDict);
    
    /*
     
     Status bar is initially hidden为YES，
     View controller-based status bar appearance为NO，
     将强制隐藏状态条。
     
     */
}

#pragma mark - 计时器

- (void)TimeTest {
    
    /*说明：
     seconds参数用于设定间隔时间，
     target用于指定发送消息给哪个对象，
     selector指定要调用的方法名，相当于一个函数指针，
     userInfo可以给消息发送参数，
     repeats表示是否重复。
     
     */
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(download)
                                                    userInfo:nil
                                                     repeats:YES];
    
    /*说明：停止计时器
     
     */
    [timer invalidate];
    
    /**
     *  5秒后执行pushSecondController方法。
     */
    [self performSelector:@selector(pushSecondController) withObject:nil afterDelay:5.0f];
    
    //================================================================================================
    
    SEL selectorToCall = @selector(download);
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:selectorToCall];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:self];
    [invocation setSelector:selectorToCall];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                         invocation:invocation
                                            repeats:YES];
    
    //================================================================================================
    
    /**
     *  创建一个未被调度的计时器
     *
     */
    timer = [NSTimer timerWithTimeInterval:1.0
                                    target:self
                                  selector:@selector(download)
                                  userInfo:nil
                                   repeats:YES];
    
    /**
     *  NSRunLoop 的类方法currentRunLoop 和mainRunLoop 将各自返回程序的当前
     *  和主要的事件处理循环
     */
    [[NSRunLoop currentRunLoop] addTimer:timer
                                 forMode:NSDefaultRunLoopMode];
    
    //================================================================================================
    
    /**
     *  创建一个未被调度的计时器
     */
    timer  = [NSTimer timerWithTimeInterval:1.0
                                 invocation:invocation
                                    repeats:YES];;

    [[NSRunLoop currentRunLoop] addTimer:timer
                                 forMode:NSDefaultRunLoopMode];
}

- (void)download {
    
}

- (void)pushSecondController {
    
    
}

#pragma mark - notification通知机制

- (void)notificationTest {
    
    /*说明：
     name是通知的名字，
     object是投送通知时传递过来的对象，
     userInfo是投送通知时定义的字典对象，可借助于该参数传递数据。
     
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTerminate:)
                                                 name:@"AppWillTerminateNotification"
                                               object:nil];
    
    /**
     *
     *  可以检测到设备最近一次方向变化。
     
     NSCurrentLocaleDidChangeNotification
     这个通知在用户改变区域设置时发送，比如，用户在设备的设置页，将iOS 设备的语言
     从英文改为西班牙文。
     
     UIDeviceBatteryStateDidChangeNotification
     这个通知在iOS 设备上的电池状态变化时都会被发送。比如，当程序在前台时设备被接
     入到一台电脑，然后在后台被拔出时，程序会接收到这一通知（如果程序注册了此通知）。
     电池状态可以使用UIDevice 的batteryState 属性获得。
     
     UIDeviceProximityStateDidChangeNotification
     当接近感应器改变时会发送此通知。最后的状态可以通过UIDevice 的proximatyState 属
     性获得。
     
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    /**
     *  
     
     NSUserDefaultsDidChangeNotification
     这个通知在用户在iOS 设备的设置页(如果提供给用户任何设置项)改变了程序设置时触
     发。
     
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(settingsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
}

- (void)appWillTerminateTest {
    
    /*说明：注册 程序中断 通知。
     
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTerminate:)
                                                 name:@"AppWillTerminateNotification"
                                               object:nil];
    
    /*说明：触发 通知。
     
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppWillTerminateNotification"
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"2", nil]];
}

- (void)orientationChanged:(NSNotification *)paramNotification {
    
    NSLog(@"Orientation Changed");
}

- (void)settingsChanged:(NSNotification *)paramNotification {
    
    NSLog(@"Settings changed");
    NSLog(@"Notification Object = %@", [paramNotification object]);
}

- (void)dealloc
{
    /*说明：移除 通知。
     
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*说明：处理 通知。
 
 */
- (void)handleTerminate:(NSNotification*)notification{
    
    NSDictionary *theData = [notification userInfo];
    if (theData != nil) {
        
        NSDate *date = [theData objectForKey:@"TerminateDate"];
        NSLog(@"FlipsideViewController App Terminate Date: %@", date);
    }
}

const NSString *ResultOfAppendingTwoStringsNotification = @"ResultOfAppendingTwoStringsNotification";

- (void)notificationTest2 {
    
    /**
     *  注册通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appendingIsFinished:)
                                                 name:(NSString *)ResultOfAppendingTwoStringsNotification
                                               object:self];
    
    /**
     *  推送通知
     */
    yyhObjectInit(NSDictionary, userInfo);
    NSNotification *notificationObject = [NSNotification notificationWithName:(NSString *)ResultOfAppendingTwoStringsNotification
                                                                       object:self
                                                                     userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notificationObject];
    
    /**
     *  移除通知
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)appendingIsFinished:(NSNotification *)paramNotification {
    
    NSLog(@"Notification is received.");
    NSLog(@"Notification Object = %@", [paramNotification object]);
    NSLog(@"Notification User-Info Dict = %@", [paramNotification userInfo]);
}

#pragma mark - KVC机制

/**
 *  KVC具有这种自动包装功能。
 */
- (void)kvcTest {
    
    /**
     *  
     
     对象中有一个实例变量为 NSString *_make;
     没有为其提供存取的setter和getter方法。
     但是可以使用：
     */
    [self setValue:@"China"forKey:@"make"];
    NSString *make = [self valueForKey:@"make"];
    NSLog(@"%@",make);
    
    /**
     *  
     
     self有个实例变量叫sub_KVO_Demo，sub_KVO_Demo里面有个实例变量叫heightd。
     */
    [self setValue:@"888.8"forKeyPath:@"sub_KVO_Demo.heightd"];
    NSString *maked = [self valueForKeyPath:@"sub_KVO_Demo.heightd"];
    NSLog(@"%@",maked);
    
    /**
     *
     
     如果向NSArray请求一个键值，它实际上会查询数组中的每个对象来查找这个键值，然后将查询结果打包到另一个数组中并返回给你。
     */
    NSArray *names = [self valueForKeyPath:@"subArray.named"];
    NSLog(@"%@",names);
    
    /**
     *  
     
     计算数量。
     */
    NSNumber *count;
    count = [self valueForKeyPath:@"subArray.@count"];
    NSLog(@"We have %@ cars.",count);
    
    /**
     *  
     
     计算某些特定值的总和。
     (@avg则是计算平均值。还有@min或@max等等)
     */
    NSNumber *sum;
    sum = [self valueForKeyPath:@"subArray.@sum.yeard"];
    NSLog(@"We have %@ years.",sum);
    
    /**
     *
     
     @distinctUnionOfObjects、@unionOfObjects
     它们的返回值都是NSArray，区别是前者返回的元素都是唯一的，是去重以后的结果；后者返回的元素是全集。
     */
}

/**
 *  处理未定义的键
 *
 *  @param value 值
 *  @param key   键
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    /*
    if (_stuff == nil) {
        _stuff = [[NSMutableDictionary alloc] init];
    }
    [_stuff setValue:value forKey:key];
    */
}

/**
 *  处理未定义的键
 *
 *  @param key 键
 *
 *  @return 值
 */
- (id)valueForUndefinedKey:(NSString *)key {
    
    /*
    id value = [_stuff valueForKey:key];
    return (value);
    */
    return nil;
}

#pragma mark - KVO机制

- (void)kvoTest {
    
    /*说明：
     属性发生变化的对象需要发出消息addObserver:forKeyPath:options:context:给注册观察者，使观察者关注它的某个属性的变化。
     当对象属性变化时，观察者就会接收到通知，观察者需要重写方法observeValueForKeyPath:ofObject:change:context:以响应属性的变化。
     
     控制器A有个NSString属性status，有个Watcher对象属性。
     
     [self addObserver:self.watcher
            forKeyPath:@"status"
               options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
               context:@"Pass Context"];
     
     参数
     addObserver是要被关注的对象，
     forKeyPath是被关注对象的属性。
     options是为属性变化设置的选项，本例中被设定为 NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld，把属性新旧两个值都传递给观察者。
     context参数是上下文内容，类型为(void*)（C语言形式的任何指针类型），因此，如果传递“空”，应该是NULL而非nil。
     removeObserver:forKeyPath:
     那么在Watcher对象中，看observeValueForKeyPath方法。
     
     */
    
}

/*说明：
 observeValueForKeyPath参数是被关注的属性。
 ofObject是被关注的对象，
 change是字典类型，包含了属性变化的内容，这些内容与注册时属性变化设置的选项（options参数）有关。
 context是注册时传递的上下文内容。
 
 */
- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context {
    
    NSLog(@"Property '%@' of object '%@' changed: %@ context: %@",keyPath,object,change,context);
    NSLog(@"name old value:%@ , new value:%@",
          [change objectForKey:NSKeyValueChangeOldKey],[change objectForKey:NSKeyValueChangeNewKey]);
}

#pragma mark - NSPredicate谓词

- (void)predicateTest {
    
    /*
     
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name  == 'Herbie' "];
    
    BOOL match  = [predicate evaluateWithObject:car];
    NSLog(@"%s",(match ? "YES" : "NO"));//三元运算式
    
    predicate  = [NSPredicate predicateWithFormat:@"engine.horsepower > 150"];
    
    //检查对象集合
    for(Car *car in [garage cars]) {
        if([predicate evaluateWithObject:car]){
            NSLog(@"%@",car.name);
        }
    }
     
    */
    
    /*
     
    filteredArrayUsingPredicate是NSArray数组中的一种类别方法，它将循环过滤数组内容，
    根据谓词计算每个对象的值，并将值为YES的对象累积到将被返回的新数组中。
     
    NSArray *result = [cars filteredArrayUsingPredicate:predicate];
    NSArray *names = [results valueForKey:@"name"];
     
    */
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"engine.horsepower > %d",50];
    
    predicate = [NSPredicate predicateWithFormat:@"name == %@",@"Herbie"];
    
    //使用%K指定键路径
    predicate = [NSPredicate predicateWithFormat:@"%K == %@",@"name",@"Herbie"];
    
    //将变量名放入字符串
    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:@"name == $NAME"];
    NSDictionary *varDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Herbie",@"NAME",nil];
    predicate = [predicateTemplate predicateWithSubstitutionVariables:varDict];
    
    //使用不同的对象作为变量名称，例如NSNumber。
    predicateTemplate = [NSPredicate predicateWithFormat:@"engine.horsepower > $POWER"];
    varDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:150],@"POWER",nil];
    predicate = [predicateTemplate predicateWithSubstitutionVariables:varDict];
    
    //运算符：{ >、>=、<、<=、!=、AND、OR、NOT、&&、||、! }
    predicate = [NSPredicate predicateWithFormat:@"(engine.horsepower > 50) AND (engine.horsepower < 200)"];
    predicate = [NSPredicate predicateWithFormat:@"name < 'Newton' "];
    
    // { BETWEEN、IN }
    predicate = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN { 50 , 200 }"];
    
    NSArray *betweens = [NSArray arrayWithObjects:[NSNumber numberWithInt:50],[NSNumber numberWithInt:200],nil];
    predicate = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN %@",betweens];
    
    //使用不同的对象作为变量名称，例如NSNumber。
    predicateTemplate = [NSPredicate predicateWithFormat:@"engine.horsepower BETWEEN $POWERS"];
    varDict = [NSDictionary dictionaryWithObjectsAndKeys:betweens,@"POWERS",nil];
    predicate = [predicateTemplate predicateWithSubstitutionVariables:varDict];
    
    //in
    predicate = [NSPredicate predicateWithFormat:@"name IN {'Herbie','Snugs','Badger','Flap'}"];
    
    /*
     
    如果没有键路径呢？只是一个简单NSArray，我们就用SELF代替：
    NSArray *names = [cars valueForKey:@"name"];
    predicate = [NSPredicate predicateWithFormat:@"SELF IN { 'Herbie','Snugs','Badger','Flap' }";
    results = [names filteredArrayUsingPredicate:predicate];
    
    */
     
    //取两个数组的交集运算
    NSArray *name1 = [NSArray arrayWithObjects:@"Herbie",@"Badger",@"Judge",@"Elvis",nil];
    NSArray *name2 = [NSArray arrayWithObjects:@"Judge",@"Paper Car",@"Badger",@"Finto",nil];
    predicate = [NSPredicate predicateWithFormat:@"SELF IN %@",name1];
    NSArray *results = [name2 filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",results);
    
    /**
     *  
     
     字符串运算符
     BEGINSWITH：检查某个字符串是否以另一个字符串开头。
     ENDSWITH：检查某个字符串是否以另一个字符串结尾。
     CONTAINS：检查某个字符串是否在另一个字符串内部。
     
     LIKE运算符
     
     *
     */
}

#pragma mark - JSON解析

/**
 *  JSON解析
 */
- (void)jsonTest {
    
    /**
     *  
     NSJSONReadingOptions定义：
     
     NSJSONReadingMutableContainers。指定解析返回的是可变的数组或字典。如果以后需要修改结果，这个常量是合适的选择。
     NSJSONReadingMutableLeaves。指定叶节点是可变字符串。
     NSJSONReadingAllowFragments。指定顶级节点可以不是数组或字典。
     */
    NSString* path = [[NSBundle mainBundle] pathForResource:@"jsonTestData" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    if (jsonData) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingMutableContainers
                                                       error:&error];
        
        if (!jsonObj || error) {
            
            NSLog(@"JSON解码失败");
        }
        NSArray *listData = [jsonObj objectForKey:@"Record"];
        
        NSLog(@"%@",listData);
    }
    
    /**
     *  生成Json Data
     */
    NSDictionary *loan = @{@"name":@"yangyh",@"location":@{@"country":@"America"},@"number":[NSNumber numberWithFloat:1.0f]};
    NSDictionary* info = @{@"who": loan[@"name"],
                           @"where": loan[@"location"][@"country"],
                           @"what": loan[@"number"]};
    //convert object to data
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
    NSString *text = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",text);
    
    /**
     *  把Array 和Dictionaries 序列化成JSON 对象
     */
    NSMutableDictionary *dictionary =
    [NSMutableDictionary dictionaryWithDictionary:@{
                                                    @"First Name" : @"Anthony",
                                                    @"Last Name" : @"Robbins",
                                                    @"Age" : @51
                                                    }];
    NSArray *arrayOfAnthonysChildren = @[
                                         @"Anthony's Son 1",
                                         @"Anthony's Daughter 1",
                                         @"Anthony's Son 2",
                                         @"Anthony's Son 3",
                                         @"Anthony's Daughter 2"
                                         ];
    [dictionary setValue:arrayOfAnthonysChildren forKey:@"children"];
    
    NSError *error3 = nil;
    NSData *jsonData3 = [NSJSONSerialization
                        dataWithJSONObject:dictionary
                        options:NSJSONWritingPrettyPrinted
                        error:&error3];
    if ([jsonData3 length] > 0 && error3 == nil) {
        
        NSLog(@"Successfully serialized the dictionary into data = %@",jsonData);
        
        //打印json内容
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        NSLog(@"JSON String = %@", jsonString);
        
        
        id jsonObject = [NSJSONSerialization
                         JSONObjectWithData:jsonData
                         options:NSJSONReadingAllowFragments
                         error:&error];
        if (jsonObject != nil && error == nil) {
            
            NSLog(@"Successfully deserialized...");
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
                NSLog(@"Deserialized JSON Dictionary = %@", deserializedDictionary);
            } else if ([jsonObject isKindOfClass:[NSArray class]]) {
                
                NSArray *deserializedArray = (NSArray *)jsonObject;
                NSLog(@"Deserialized JSON Array = %@", deserializedArray);
            } else {
            /* Some other object was returned. We don't know how to deal
             with this situation as the deserializer only returns dictionaries
             or arrays */
            }
        }
        else if (error != nil){
            NSLog(@"An error happened while deserializing the JSON data.");
        }
    }
    else if ([jsonData length] == 0 && error == nil) {
        
        NSLog(@"No data was returned after serialization.");
    }
    else if (error != nil) {
        
        NSLog(@"An error happened = %@", error);
    }
    
    /**
     *  把JSON 数据反序列化为Arrays 和Dictionaries
     */
}

/**
 *  定义一个全局队列
 */
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

/**
 *  定义一个主线程
 */
#define kMainQueue dispatch_get_main_queue()

- (void)jsonBlockTest {
    
    dispatch_async(kBgQueue, ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        
        dispatch_async(kMainQueue, ^{
            
            if (data) {
                
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data //1
                                                                     options:kNilOptions
                                                                       error:&error];
                if (!json || error) {
                    
                    NSLog(@"JSON解码失败");
                }
                
                NSArray* latestLoans = json[@"loans"]; //2
                NSLog(@"loans: %@", latestLoans);
            }
        });
    });
}

#pragma mark - request请求 网络 NSURLConnection请求

- (void)requestTest {
    
    /**
     同步请求：sendSynchronousRequest
     
     别的构造方法：
     NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url
                                                   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                               timeoutInterval:5.0];
     cachePolicy部分用于设置缓存策略，timeoutInterval部分用于设置请求超时时间，以秒为单位。
     
     缓存策略有7种：
     NSURLRequestUseProtocolCachePolicy。NSURLRequest默认的缓存策略，由协议定义。
     NSURLRequestReloadIgnoringCacheData。忽略缓存直接从原始地址请求。
     NSURLRequestReloadIgnoringLocalCacheData。等同NSURLRequestReloadIgnoringCacheData情况。
     NSURLRequestReturnCacheDataElseLoad。只有在没有缓存数据时从原始地址请求。
     NSURLRequestReturnCacheDataDontLoad。只使用缓存数据，如果不存在缓存，就会抛出异常，请求失败，用于离线模式。
     NSURLRequestReloadIgnoringLocalAndRemoteCacheData。忽略本地和远程的缓存数据，直接从原始地址请求。
     NSURLRequestReloadRevalidatingCacheData。验证本地缓存数据与远程数据是否相同，如果相同，则使用本地缓存数据，否则请求远程数据。
     
     */
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://m.weather.com.cn/data/101010100.html"];
    NSURL *url2 = [NSURL URLWithString:[strURL URLEncodedString]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url2];
    NSData *data2  = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//创建同步请求
    NSLog(@"请求完成... %@",data2);
    
    //阻塞主线程的同步请求
    NSString *urlAsString = @"http://www.yahoo.com";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSLog(@"Firing synchronous url connection...");
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    if ([data length] > 0 && error == nil) {
        
        NSLog(@"%lu bytes of data was returned.", (unsigned long)[data length]);
    }
    else if ([data length] == 0 && error == nil) {
        
        NSLog(@"No data was returned.");
    }
    else if (error != nil) {
        
        NSLog(@"Error happened = %@", error);
    }
    NSLog(@"We are done.");
    
    //不会阻塞主线程的同步请求
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        
        NSURL *url = [NSURL URLWithString:urlAsString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                             returningResponse:&response
                                                         error:&error];
        if ([data length] > 0 && error == nil) {
            
            NSLog(@"%lu bytes of data was returned.", (unsigned long)[data length]);
        }
        else if ([data length] == 0 && error == nil) {
            
            NSLog(@"No data was returned.");
        }
        else if (error != nil) {
            
            NSLog(@"Error happened = %@", error);
        }
    });
    NSLog(@"We are done.");
    
    
    //异步请求
//    NSString *urlAsString = @"http://www.apple.com";
//    NSURL *url = [NSURL URLWithString:urlAsString];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    //最大限度的等待30 秒，超时时间
    NSURLRequest *urlRequest2 = [NSURLRequest requestWithURL:url
                                                 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                             timeoutInterval:30.0f];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response,
                                                                                        NSData *data,
                                                                                        NSError *error) {
         
         if ([data length] > 0 && error == nil) {
             
             NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"HTML = %@", html);
             
             /* Get the documents directory */
             NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                           NSUserDomainMask,
                                                                           YES) objectAtIndex:0];
             /* Append the file name to the documents directory */
             NSString *filePath = [documentsDir stringByAppendingPathComponent:@"apple.html"];
             /* Write the data to the file */
             [data writeToFile:filePath atomically:YES];
             NSLog(@"Successfully saved the file to %@", filePath);
         }
         else if ([data length] == 0 && error == nil) {
             
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil) {
             
             NSLog(@"Error happened = %@", error);
         }
     }];
    NSLog(@"urlRequest2 %@",urlRequest2);
    
    
    /**
     异步请求sendAsynchronousRequest
     
     */
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue2
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
                               NSLog(@"请求完成... %@",data);
                               
                               NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:nil];
                               NSLog(@"%@",resDict);
                           }];
    
    
    //NSMutableURLRequest
    NSMutableURLRequest *mutableUrlRequest = [NSMutableURLRequest new];
    [mutableUrlRequest setTimeoutInterval:30.0f];
    [mutableUrlRequest setURL:url];
    
    //通过HTTP协议向服务器发送一个GET请求
    NSString *urlAsString5 = @"http://pixolity.com/get.php";
    urlAsString5 = [urlAsString5 stringByAppendingString:@"?param1=First"];
    urlAsString5 = [urlAsString5 stringByAppendingString:@"&param2=Second"];
    NSURL *url5 = [NSURL URLWithString:urlAsString5];
    NSMutableURLRequest *urlRequest5 = [NSMutableURLRequest requestWithURL:url5];
    [urlRequest5 setTimeoutInterval:30.0f];
    [urlRequest5 setHTTPMethod:@"GET"];
    NSOperationQueue *queue5 = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest5 queue:queue5 completionHandler:^(NSURLResponse *response,
                                                                                          NSData *data,
                                                                                          NSError *error) {
        
     }];
    
    //通过HTTP协议向服务器发送一个POST请求
    [urlRequest5 setTimeoutInterval:30.0f];
    [urlRequest5 setHTTPMethod:@"POST"];
    [urlRequest5 setHTTPMethod:@"DELETE"];//通过NSURLConnection 发生一个HTTP DELETE 请求，删除一个资源
    [urlRequest5 setHTTPMethod:@"PUT"];//通过NSURLConnection 发送一个HTTP PUT 请求，放置一些资源
    NSString *body5 = @"bodyParam1=BodyValue1&bodyParam2=BodyValue2";
    [urlRequest5 setHTTPBody:[body5 dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue6 = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest5 queue:queue6 completionHandler:^(NSURLResponse *response,
                                                                                          NSData *data,
                                                                                          NSError *error) {

     }];
}

//===================================================================================================

/**
 *  NSURLConnection异步的get请求
 */
- (void)URLConnectionTestForGet {
    
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://iosbook1.com/service/mynotes/webservice.php?email=%@&type=%@&action=%@",@"<你的iosbook1.com用户邮箱>",@"JSON",@"query"];
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (connection) {
        
//        _datas = [NSMutableData new];
    }
}

/**
 *  NSURLConnection异步的post请求
 */
- (void)URLConnectionTestForPost {
    
    NSString *strURL = [[NSString alloc] initWithFormat:@"http://iosbook1.com/service/mynotes/webservice.php"];
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"<你的iosbook1.com用户邮箱>",@"JSON",@"query"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        
//        _datas = [NSMutableData new];
    }
}

//--------------NSURLConnectionDelegate----------

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
//    [_datas appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void)connectionDidFinishLoading: (NSURLConnection*) connection {
    
//    NSLog(@"请求完成...");
//    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
//    [self reloadView:dict];
}

#pragma mark - MKNetworkKit网络请求

/**
 *  
 1、为你的每一个特别的REST服务器请求子类化MKNetworkEngine。
 2、你的View层不应该知道url路径以及需要的参数。
 3、你应该定义你的block的方法类似于CurrencyResponseBlock这样的来给viewController传回值。
 
 */

/**
 *  Get请求
 */
- (void)networkTestForGet {
    
    NSString *path = [[NSString alloc] initWithFormat:@"/data/101010100.html"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"m.weather.com.cn" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        
        NSLog(@"responseData : %@", [operation responseString]);
        NSData *data  = [operation responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"MKNetwork请求错误 : %@", resDict);
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        
        NSLog(@"MKNetwork请求错误 : %@", [err localizedDescription]);
    }];
    
    /**
     *  发起请求
     */
    [engine enqueueOperation:op];
}

/**
 *  Post请求
 */
- (void)networkTestForPost {
 
    NSString *path = [[NSString alloc] initWithFormat:@"/service/mynotes/webservice.php"];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:@"<你的iosbook1.com用户邮箱>" forKey:@"email"];
    [param setValue:@"JSON" forKey:@"type"];
    [param setValue:@"query" forKey:@"action"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"iosbook1.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        
        NSLog(@"responseData : %@", [operation responseString]);
        NSData *data  = [operation responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"MKNetwork请求错误 : %@", resDict);
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork请求错误 : %@", [err localizedDescription]);
    }];
    [engine enqueueOperation:op];
}

/**
 *  图片下载（原作者采用下载文件的方式，封装了一些方法）
 */
- (void)networkTestForDownload {
    
    UIProgressView *progressView = [[UIProgressView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] init];
    
    /**
     *  获得沙盒目录下的缓存目录，这个目录位于Library → Caches Caches目录
     */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = paths[0];
    
    /**
     *  文件目录末尾追加文件
     */
    NSString *downloadPath = [cachesDirectory stringByAppendingPathComponent:@"touxiang.jpg"];
    
    NSString *path = [[NSString alloc] initWithFormat:@"/users/upload_avatars/105257/360f04f503c5.jpg?imageMogr/thumbnail/90x90/quality/100"];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"upload.jianshu.io" customHeaderFields:nil];
    MKNetworkOperation *downloadOperation = [engine operationWithPath:path params:nil httpMethod:@"POST"];
    
    /**
     *  指定下载图片的位置
     */
    [downloadOperation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:downloadPath append:YES]];
    
    [downloadOperation onDownloadProgressChanged:^(double progress) {
        
        /**
         *  将下载进度进行日志输出，其中的progress取值的范围是0.0~1.0之间。
         */
        NSLog(@"download progress: %.2f", progress*100.0);
        progressView.progress = progress;
    }];
    
    /**
     *  监听下载进度，改变进度条的进度。
     *
     */
    [downloadOperation addCompletionHandler:^(MKNetworkOperation *operation) {
        
        NSLog(@"download file finished!");
        NSData *data = [operation responseData];
        
        if (data) {
            
            //返回数据失败
            
        } else {
            
            //返回数据成功
            UIImage *img = [UIImage imageWithContentsOfFile:downloadPath];
            imageView.image = img;
        }
        
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork请求错误 : %@", [err localizedDescription]);
    }];
    
    if (downloadOperation) {
        
        [engine enqueueOperation:downloadOperation];
    } else {
        
        NSLog(@"downloadOperation值为nil");
    }
}

/**
 *  文件下载
 */
- (void)networkTestForUpload {
 
    /**
     *  所要上传的文件
     */
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"jpg"];
    

    NSString *path = [[NSString alloc] initWithFormat:@"/service/upload.php"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:@"<你的iosbook1.com用户邮箱>" forKey:@"email"];
    [param setValue:@"JSON" forKey:@"type"];
    [param setValue:@"query" forKey:@"action"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"iosbook1.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    
    /**
     *  将文件添加到请求中，
     *  forKey：为所要上传的文件路径设置一个key
     *  mimeType：指定文件类型
     */
    [op addFile:filePath forKey:@"file" mimeType:@"jpg"];
    
    /**
     *  冻结操作，会在网络离线不通时自动保存数据到本地，然后在网络上线之后自动上传保存的数据。
     */
    [op setFreezable:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        
        NSLog(@"download file finished!");
        NSData *data = [operation responseData];
        
        if (data) {
            
            
        }
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork请求错误 : %@", [err localizedDescription]);
    }];

    if (op) {
        
        [engine enqueueOperation:op];
    } else {
        
        NSLog(@"op值为nil");
    }
}

#pragma mark - version判断系统版本号

- (void)versionTest {
    
    /**
     *  判断当前操作系统的版本号是否大于iOS 6.1，即是否为iOS 7操作系统
     */
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        
        
    }
    
    /**
     *  判断iOS系统的版本号
     */
    NSLog(@" iOS System Version  = %@",[[UIDevice currentDevice] systemVersion]);
    
    /**
     *  判断iOS系统的版本号
     */
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion >= 8.0) {
    
    }
}

#pragma mark - ARC与MRC

- (void)arcAndMrc {
    
    
}

#pragma mark - BuildSetting

- (void)buildSetting {
    
    /**
     *
     ARC与MRC
     
     在工程中选择：
     Build Setting → Objective-C Automatic Reference Counting
     设置为YES就是采用ARC，设置为NO，就是不用ARC。
     
     还有两种情况：
     1、旧项目是MRC，引入的文件是ARC。
     2、新项目用ARC，引入的文件是MRC。
     解决：
     1、编译选项加入-fobjc-arc。
     2、编译选项加入-fno-objc-arc。
     
     
     
     
     
     Xcode中，第三方PNG优化工具pngcrush
     编译参数Compress PNG Files为YES
     
     
     
     
     
     Optimization Level编译参数决定了程序在编译过程中的两个指标：编译速度和内存的占用，
     也决定了编译之后可执行结果的两个指标：速度和文件大小。
     
     -O0。默认级别。不进行任何优化，直接将源代码编译到执行文件中，结果不进行任何重排，编译时间比
     较长。主要用于调试程序，可以进行设置断点、改变变量、计算表达式等调试工作。图20-43所示的Debug
     情况就是-O0级别。
     
     -O1（或-O）。最常用的优化级别，不考虑速度和文件大小权衡问题。与-O0级别相比，它生成的文件更小，
     可执行的速度更快，编译时间更少。
     
     -O2。在-O1级别基础上再进行优化，增加指令调度的优化。与-O1级别相比，它生成的文件大小没有变大，
     编译时间变长了，编译期间占用的内存更多了，但程序的运行速度有所提高。该级别是应用程序发布时的
     最理想级别，在增加文件大小的情况下提供了最大优化。
     
     -O3。在-O2和-O1级别上进行优化，该级别可能会提高程序的运行速度，但是也会增加文件的大小。
     
     -Os。这种级别用于在有限的内存和磁盘空间下生成尽可能小的文件。由于使用了很好的缓存技术，它在
     某些情况下也会有很快的运行速度。该级别常用于发布iOS设备时，图20-43所示的就是Release为-Os级别
     的情况。
     
     -Ofast。它是一种更为激进的编译参数，它以牺牲浮点数的精度为代价。
     
     
     
     
     
     */
}

#pragma mark - bridge 桥接

- (void)bridgeTest {
    
    /**
     *  http://bit.ly/j65Ceo 可桥接的类型
     *
     */
    
    /**
     *  __bridge_transfer 将CFURLCreateStringByAddingPercentEscapes的内存所有权交给ARC
     *  这种类型转换会在赋值后将等号右边的变量释放。
     *
     */
    NSString *test = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                           NULL,
                                                                                           (__bridge CFStringRef)@"112345",
                                                                                           NULL,
                                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                           CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    //或者
    
    NSString *test1 = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                              NULL,
                                                              (__bridge CFStringRef)@"112345",
                                                              NULL,
                                                              CFSTR("!*'();:@&=+$,/?%#[]"),
                                                              CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    NSLog(@"%@,%@",test,test1);
    
    
    /**
     * __bridge_retained
     * 这个转换方式类似__bridge_transfer，唯一的差别就是会保留等号右边的变量。
     */
    NSString *s1 = [[NSString alloc] initWithFormat:@"Hello, %@!", @"111"];
    CFStringRef s2 = (__bridge_retained CFStringRef)s1;//夺取ARC对于s1的所有权。使ARC不用释放s1
    CFRelease(s2);
    
    //或者
    
    CFStringRef s3 = CFBridgingRetain(s1);
    CFRelease(s3);
}



#pragma mark - Block


- (void)blockTest {
    
    /**
     *  __weak使得block不保留self，避免self被引用。造成循环引用。
     */
    __weak id weakSelf = self;
    
    //self.animatedView.block = ^(){
    void (^block)(void) = ^(){
        
        /**
         *  当自身被dealloc时，这个方法中的self也会变成nil。但是，
         *  如果这个block被异步调用，self变成nil之后，这段代码还在运行，
         *  就可能调用了self的一些可能导致崩溃的方法。
         *  所以，要加入这句话。
         */
        id strongSelf = weakSelf;
        
        if ( strongSelf != nil ){
            
            // do stuff with strongSelf
        }
    };
    block();
    
    /* 1 两数相减*/
    NSInteger (^subtract)(NSInteger,NSInteger) = ^(NSInteger paramValue,NSInteger paramFrom) {
        
        return paramFrom - paramValue;
    };
    subtract(1,2);
    
    /* 2 带参数的block */
    NSString *(^intToString)(NSUInteger) = ^(NSUInteger paramInteger) {
        
        return @"";
    };
    NSString *string = intToString(10);
    NSLog(@"string = %@", string);
    
    /* 3 不带参数的block */
    void (^simpleBlock)(void) = ^{
        
        
    };
    simpleBlock();
    
    /* 4 __block修饰的block */
    __block NSUInteger outsideVariable = 10;
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"obj1",@"obj2", nil];
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        outsideVariable = 20;
        
        NSLog(@"%@",self.testStr);
        
        return NSOrderedSame;
    }];
    
    /* 5 block的定义和调用 */
    IntToStringConverter inlineConverter = ^(NSUInteger paramInteger) {
        
        return @"";
    };
    [self convertIntToString:1 usingBlockObject:inlineConverter];
    [self convertIntToString:1 usingBlockObject:^NSString *(NSUInteger paramInteger) {
        
        return @"";
    }];
    
    /* 6 调用self的block */
    correctBlockObject(self);
    
    /* 7 数值不变的block */
    NSUInteger integerValue = 10;
    void (^BlockWithNoParams)(void) = ^{
        
        NSLog(@"%lu",(unsigned long)integerValue);
    };
    integerValue = 20;
    BlockWithNoParams();
    NSLog(@"%lu",(unsigned long)integerValue);
    
    /* 8 block中调用block */
    NSString *trimmedString = trimWithOtherBlock(@" O'Reilly ");
    NSLog(@"Trimmed string = %@",trimmedString);
}

//===================

typedef NSString *(^IntToStringConverter)(NSUInteger paramInteger);

- (NSString *)convertIntToString:(NSUInteger)paramInteger usingBlockObject:(IntToStringConverter)paramBlockObject {
    
    return paramBlockObject(paramInteger);
}

//===================

void (^correctBlockObject)(id) = ^(id self){
    
    [self setTestStr:@"123"];
    [self testStr];
    NSLog(@"%@",self);
};

//===================

NSString *(^trimString)(NSString *) = ^(NSString *inputString) {
    
    NSString *result = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return result;
};

NSString *(^trimWithOtherBlock)(NSString *) = ^(NSString *inputString) {
  
    return trimString(inputString);
};

#pragma mark - Bundle

- (void)BundleTest {
    
    /**
     *  获取bundle中的文件
     *  imageWithContentsOfFile
     */
    NSString *alanSugarFilePath = [[NSBundle mainBundle] pathForResource:@"AlanSugar"
                                                                  ofType:@"png"];
    if ([alanSugarFilePath length] > 0){
        
        UIImage *image = [UIImage imageWithContentsOfFile:alanSugarFilePath];
        if (image != nil){
            
            NSLog(@"Successfully loaded the file as an image.");
        } else {
            
            NSLog(@"Failed to load the file as an image.");
        }
    } else {
        
        NSLog(@"Could not find this file in the main bundle.");
    }
    
    /**
     *  获取bundle中的文件
     *  initWithContentsOfFile
     */
    if ([alanSugarFilePath length] > 0){
        
        NSError *readError = nil;
        NSData *dataForFile = [[NSData alloc] initWithContentsOfFile:alanSugarFilePath
                                                             options:NSMappedRead
                                                               error:&readError];
        if (readError == nil && dataForFile != nil){
            
            NSLog(@"Successfully loaded the data.");
        } else if (readError == nil && dataForFile == nil){
            
            NSLog(@"No data could be loaded.");
        } else {
            
            NSLog(@"An error occured while loading data. Error = %@", readError);
        }
    } else {
        
        NSLog(@"Could not find this file in the main bundle.");
    }
    
    /**
     *  从其他文件包加载数据
     */
    NSString *resourcesBundlePath = [[NSBundle mainBundle] pathForResource:@"Resources"
                                                                    ofType:@"bundle"];
    if ([resourcesBundlePath length] > 0){
        
        NSBundle *resourcesBundle = [NSBundle bundleWithPath:resourcesBundlePath];
        if (resourcesBundle != nil){
            
            NSString *pathToAlanSugarImage = [resourcesBundle pathForResource:@"AlanSugar"
                                                                       ofType:@"png"
                                                                  inDirectory:@"Images"];
            
            if ([pathToAlanSugarImage length] > 0){
                
                UIImage *image = [UIImage imageWithContentsOfFile:pathToAlanSugarImage];
                if (image != nil){
                    
                    NSLog(@"Successfully loaded the image from the bundle.");
                } else {
                    
                    NSLog(@"Failed to load the image.");
                }
            } else {
                
                NSLog(@"Failed to find the file inside the bundle.");
            }
        } else {
            
            NSLog(@"Failed to load the bundle.");
        }
    } else {
        
        NSLog(@"Could not find the bundle.");
    }
    
    /**
     *  查找资源文件包下图片文件夹里所有.png 文件的路径
     */
    if ([resourcesBundlePath length] > 0){
        
        NSBundle *resourcesBundle = [NSBundle bundleWithPath:resourcesBundlePath];
        if (resourcesBundle != nil){
            
            NSArray *PNGPaths = [resourcesBundle pathsForResourcesOfType:@"png"
                                                             inDirectory:@"images"];
            
            [PNGPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                 NSLog(@"Path %lu = %@", (unsigned long)idx+1, obj);
             }];
        } else {
            
            NSLog(@"Failed to load the bundle.");
        }
    } else {
        
        NSLog(@"Could not find the bundle.");
    }
}

#pragma mark - 多任务 后台 后台运行

- (void)multitaskTest {
    
    if ([self isMultitaskingSupported]) {
        
        NSLog(@"Multitasking is supported.");
        
    } else {
        
        NSLog(@"Multitasking is not supported.");
    }
}

/**
 *  判断是否支持多任务
 *
 */
- (BOOL)isMultitaskingSupported {
    
    BOOL result = NO;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        
        result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    return result;
}

//========================================================================================================================

/**
 *  程序进入前台时触发该方法
 *
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid){
       
        [self endBackgroundTask];
    }
}

/**
 *  程序进入后台时触发该方法
 *
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    if ([self isMultitaskingSupported] == NO) {
        
        return;
    }
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                    target:self
                                                  selector:@selector(timerMethod:)
                                                  userInfo:nil
                                                   repeats:YES];
    
    /**
     *  结束background_task任务
     *
     */
    self.backgroundTaskIdentifier =
    [application beginBackgroundTaskWithExpirationHandler:^(void) {
        
        [self endBackgroundTask];
    }];
}

/**
 *  程序进入后台时，会一直执行此方法
 *
 */
- (void)timerMethod:(NSTimer *)paramSender {
    
    /**
     *  获取设备后台处理时间，是个倒计时，大概3分钟，
     *  这个属性指明了在完成任务前程序拥有多少秒。
     */
    NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
    
    if (backgroundTimeRemaining == DBL_MAX) {
        
        NSLog(@"Background Time Remaining = Undetermined");
    } else {
        
        NSLog(@"Background Time Remaining = %.02f Seconds",backgroundTimeRemaining);
    }
}

/**
 *  当后台处理时间结束时调用这个方法
 */
- (void)endBackgroundTask {
    
    __weak ObjectTest *weakSelf = self;
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^(void) {
        
        ObjectTest *strongSelf = weakSelf;
        if (strongSelf != nil) {
            
            [strongSelf.myTimer invalidate];//关闭计时器
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];//结束任务
            strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }
    });
}

/**
 *  在plist文件中加入 Application does not run in background ，关闭多任务。
 *  不支持多任务时，点击home键，先运行 applicationDidEnterBackground: 方法。
 *  再运行 applicationWillTerminate: 这个方法。
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 本地推送 本地通知 UILocalNotification

- (void)localNoticationTest {
    
    /**
     *  在iOS8中要实现badge、alert和sound等都需要用户同意才能，因为这些都算做Notification“通知”，
     *  为了防止有些应用动不动给用户发送“通知”骚扰用户，所以在iOS8时，要“通知”必须要用户同意才行。
     */
    float sysVersion = [[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion >= 8.0) {
        
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    /**
     *  放在didFinishLaunchingWithOptions方法中
     */
    NSDictionary *launchOptions;
    id scheduledLocalNotification = [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (scheduledLocalNotification != nil){
        
        /* We received a local notification while
         our application wasn't running. You can now typecase the
         ScheduledLocalNotification variable to UILocalNotification and
         use it in your application */
        
        NSString *message = @"Local Notification Woke Us Up";
        [[[UIAlertView alloc] initWithTitle:@"Notification"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
    } else {
        
        NSString *message =@"A new instant message is available. \
        Would you like to read this message?";
        
        /* If a local notification didn't start our application,
         then we start a new local notification */
        
        [self localNotificationWithMessage:message
                         actionButtonTitle:@"Yes"
                               launchImage:nil
                          applicationBadge:1
                            secondsFromNow:10.0f
                                  userInfo:nil];
        
        message = @"A new Local Notification is set up \
        to be displayed 10 seconds from now";
        
        [[[UIAlertView alloc] initWithTitle:@"Set Up"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
    }
}

- (BOOL)localNotificationWithMessage:(NSString *)paramMessage
                   actionButtonTitle:(NSString *)paramActionButtonTitle
                         launchImage:(NSString *)paramLaunchImage
                    applicationBadge:(NSInteger)paramApplicationBadge
                      secondsFromNow:(NSTimeInterval)paramSecondsFromNow
                            userInfo:(NSDictionary *)paramUserInfo {
    
    if ([paramMessage length] == 0) {
        
        return NO;
    }
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    //设置提醒的文字内容
    notification.alertBody = paramMessage;
    notification.alertAction = paramActionButtonTitle;
    
    if ([paramActionButtonTitle length]> 0) {
        /* Make sure we have the action button for the user to press
         to open our application */
        notification.hasAction = YES;
    } else {
        notification.hasAction = NO;
    }
    
    /* Here you have a chance to change the launch image of your application
     when the notification's action is viewed by the user */
    notification.alertLaunchImage = paramLaunchImage;
    
    //设置重复间隔
    notification.repeatInterval = kCFCalendarUnitDay;
    
    //通知提示音 使用默认的
    notification.soundName= UILocalNotificationDefaultSoundName;
    
    //设置应用程序右上角的提醒个数
    notification.applicationIconBadgeNumber ++;
    
    /* Change the badge number of the application once the notification is
     presented to the user. Even if the user dismisses the notification,
     the badge number of the application will change */
    notification.applicationIconBadgeNumber = paramApplicationBadge;
    
    //设定通知的userInfo，用来标识该通知
    notification.userInfo = paramUserInfo;
    
    /* We need to get the system time zone so that the alert view
     will adjust its fire date if the user's time zone changes */
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //使用系统时区
    notification.timeZone = timeZone;
    
    /* Schedule the delivery of this notification x seconds from now */
    NSDate *today = [NSDate date];

    NSDate *fireDate = [today dateByAddingTimeInterval:paramSecondsFromNow];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSUInteger dateComponents =
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:dateComponents
                                               fromDate:fireDate];
    
    /* Here you have a chance to change these components. That's why we
     retrieved the components of the date in the first place. */
    fireDate = [calendar dateFromComponents:components];
    
    //设置通知的提醒时间
    notification.fireDate = fireDate;
    
    //取消所有进行中的本地通知的发送。
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //将通知添加到系统中
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    return YES;
}

/**
 *  本地通知时间到时，触发该方法
 *
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    NSString *message = @"The Local Notification is delivered.";
    
    [[[UIAlertView alloc] initWithTitle:@"Local Notification"
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
    
}

#pragma mark - 保存和加载状态 保存和加载程序的状态

/**
 *  将用户的分数保存到磁盘
 */
- (void)saveUserScore {
    /* Save the user score here */
}

/**
 *  保存当前关卡的数据到磁盘。
 */
- (void)saveLevelToDisk {
    /* Save the current level and the user's location on map to disk */
}

/**
 *  将游戏引擎置为暂停状态
 */
- (void)pauseGameEngine {
    /* Pause the game engine here */
}

- (void)loadUserScore {
    /* Load the user's location back to memory */
}

- (void)loadLevelFromDisk {
    /* Load the user's previous location on the map */
}

- (void)resumeGameEngine {
    /* Resume the game engine here */
}

/**
 *  要放在AppDelegate.m的文件中
 *  来电时，应用会进入非激活状态，但不会进入后台，要注意
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    
    [self pauseGameEngine];
}

/**
 *  要放在AppDelegate.m的文件中
 *  来电时，应用会进入非激活状态，但不会进入后台，要注意
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [self resumeGameEngine];
}

/**
 *  要放在AppDelegate.m的文件中
 */
- (void)applicationDidEnterBackground2:(UIApplication *)application {
    
    [self saveUserScore];
    [self saveLevelToDisk];
    [self pauseGameEngine];
}

/**
 *  要放在AppDelegate.m的文件中
 */
- (void)applicationWillEnterForeground2:(UIApplication *)application {
    
    [self loadUserScore];
    [self loadLevelFromDisk];
    [self resumeGameEngine];
}

#pragma mark - 字体 UIFont

- (void)fontTest {
    
    /**
     *  枚举字体 枚举出设备的所有字体
     */
    for (NSString *familyName in [UIFont familyNames]) {
        
        NSLog(@"Font Family = %@", familyName);
    }
    
    /**
     *  在每个family 内部枚举字体名字，比如
     *  Helvetica Neue 是字体family，HelveticaNeue-Bold 是这个family 中的一个字体名字。
     */
    for (NSString *familyName in [UIFont familyNames]) {
        
        NSLog(@"Font Family = %@", familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            
            NSLog(@"\t%@", fontName);
        }
    }
    
    /**
     *  加载字体
     */
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold"
                                            size:12.0f];
    
    
    /**
     *  从你代码运行的设备上加载系统字体，不管这些字体是什么。
     */
    UIFont *font1 = [UIFont systemFontOfSize:12.0f];
    
    /**
     *  粗体
     */
    UIFont *font2 = [UIFont boldSystemFontOfSize:12.0f];
    
    NSLog(@"%@ %@ %@",helveticaBold,font1,font2);
}

#pragma mark - 颜色 UIColor

- (void)colorTest {
    
    UIColor *steelBlueColor = [UIColor colorWithRed:0.3f green:0.4f blue:0.6f alpha:1.0f];
    
    /**
     *  返回一个CGColorRef 类型的颜色对象，这是一个Core Graphics 颜色引用（Color Reference）对象。
     */
    CGColorRef colorRef = [steelBlueColor CGColor];
    
    /**
     *  得到构成颜色对象的组成部分。
     */
    const CGFloat *components = CGColorGetComponents(colorRef);
    
    /**
     *  确定我们用来构造颜色（red+green+其他）的组件数量。
     */
    NSUInteger componentsCount = CGColorGetNumberOfComponents(colorRef);
    NSUInteger counter = 0;
    for (counter = 0; counter < componentsCount; counter++) {
        
        NSLog(@"Component %lu = %.02f",(unsigned long)counter + 1,components[counter]);
    }
}

/**
 *  通过颜色十六进制字串生成颜色对象的方法
 */
UIColor* UIColorFromHex(NSInteger colorInHex) {
    
    // colorInHex should be value like 0xFFFFFF
    return [UIColor colorWithRed:((float) ((colorInHex & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((colorInHex & 0xFF00)   >> 8))  / 0xFF
                            blue:((float)  (colorInHex & 0xFF))            / 0xFF
                           alpha:1.0];
}

#pragma mark - 核心运动 加速计 陀螺仪 CoreMotion.framework

- (void)hardwareTest {
    
    /* 1 */
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    if ([motionManager isAccelerometerAvailable]) {//检测加速计硬件是否可用
        
        NSLog(@"Accelerometer is available.");
    } else{
        
        NSLog(@"Accelerometer is not available.");
    }
    if ([motionManager isAccelerometerActive]) {//检测加速计硬件是否正在向程序发送更新（即是否是激活的）
        
        NSLog(@"Accelerometer is active.");
    } else {
        
        NSLog(@"Accelerometer is not active.");
    }
    
    /* 2 */
    if ([motionManager isGyroAvailable]) {//检测陀螺仪硬件是否可用
        
        NSLog(@"Gryro is available.");
    } else {
        
        NSLog(@"Gyro is not available.");
    }
    if ([motionManager isGyroActive]) {//检测陀螺仪是否在向你的程序发送更新（即是否是激活的）
        
        NSLog(@"Gryo is active.");
    } else {
        
        NSLog(@"Gryo is not active.");
    }
    
    /* 3 */
    if ([motionManager isAccelerometerAvailable]){//获取加速器的数据
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [motionManager startAccelerometerUpdatesToQueue:queue
         withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             
             NSLog(@"X = %.04f, Y = %.04f, Z = %.04f",
                   accelerometerData.acceleration.x,
                   accelerometerData.acceleration.y,
                   accelerometerData.acceleration.z);
         }];
        
    } else {
        
        NSLog(@"Accelerometer is not available.");
    }
    
    /* 4 */
    if ([motionManager isGyroAvailable]) {//获取陀螺仪的数据
        
        if ([motionManager isGyroActive] == NO) {
            
            [motionManager setGyroUpdateInterval:1.0f / 40.0f];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [motionManager startGyroUpdatesToQueue:queue
             withHandler:^(CMGyroData *gyroData, NSError *error) {
                 
                 NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
                 NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
                 NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
             }];
            
        } else {
            
            NSLog(@"Gyro is already active.");
        }
    } else {
        
        NSLog(@"Gyro isn't available.");
    }
}

/**
 *  检测iOS 设备的摇晃
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake){
        NSLog(@"Detected a shake");
    }
}

#pragma mark - Method Swizzling

/**
 *  加入#import <objc/runtime.h>  
 */
- (void)methodSwizzlingTest {
    
    Method ori_Method =  class_getInstanceMethod([NSArray class], @selector(lastObject));
    Method my_Method = class_getInstanceMethod([NSArray class], @selector(myLastObject));
    method_exchangeImplementations(ori_Method, my_Method);
    
    NSArray *array1 = @[@"0",@"1",@"2",@"3"];
    NSString *string = [array1 lastObject];
    NSLog(@"TEST RESULT : %@",string);
    
    //然后NSArray的lastObject方法的实现与myLastObject方法的实现互换。
    
    
}

/**
 *  给NSArray添加一个分类
 *  NSArray+Swizzle
 *  然后写上下面这个方法
 */
- (id)myLastObject {
    
    id ret = [self myLastObject];
    NSLog(@"**********  myLastObject *********** ");
    return ret;
}

- (id)lastObject {
    
    //实现的内容
    
    return self;
}

//================================== 互换前和互换后的分界线 ==================================

- (id)x_myLastObject {
    
    //实现的内容
    
    return self;
}

- (id)x_lastObject {
    
    id ret = [self x_myLastObject];
    NSLog(@"**********  myLastObject *********** ");
    return ret;
}

#pragma mark -

@end
