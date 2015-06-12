//
//  ObjectTest.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/6.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "ObjectTest.h"
#import "NSString+URLEncoding.h"

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

#pragma mark - FoundationKit

- (void)foundationTest {
    
    /**
     *  
     几何数据类型：
     
     NSRange、NSPoint、NSSize、NSRect
     *
     */
    
    NSRange range1;
    range1.location = 17;
    range1.length = 4;
    NSRange range2 = { 17 , 4 };
    NSRange range3 = NSMakeRange( 17 , 4 );
    NSLog(@"%d %d",range2.length,range3.length);
    
    /**
     *  
     字符串：
     
     NSString。
     stringWithFormat：格式化字符串。
     length：字符串的length方法获取字符串长度。
     isEqualToString：判断字符串相等。
     compare：字符串比较。
     hasPrefix：字符串以什么字符串开头。
     hasSuffix：字符串以什么字符串结尾。
     rangeOfString：包含某个字符串
     *
     */
    
    NSString *thing1 = @"name";
    NSString *thing2 = @"NAME";
    if ([thing1 compare:thing2 options:NSCaseInsensitiveSearch
         | NSNumericSearch] == NSOrderedSame) {
        
        NSLog(@"They are match!");
        
    }
    
    /**
     *  
     可变字符串：
     
     NSMutableString。
     stringWithCapacity：字符串的初始容量。
     appendString：末尾添加字符串。
     appendFormat：末尾添加格式化的字符串。
     deleteCharactersInRange：删除某个字符串。
     *
     */
    
    NSMutableString *friends;
    friends = [NSMutableString stringWithCapacity:50];
    [friends appendString:@"James BethLynn jack Evan"];
    
    NSRange jackRange;
    jackRange = [friends rangeOfString:@"jack"];
    jackRange.length++;
    
    [friends deleteCharactersInRange:jackRange];
    
    /**
     *  
     数组：
     
     NSArray
     arrayWithObjects：创建包含多个对象的数组。
     count：数组所包含的对象个数。
     objectAtIndex：数组指定位置的对象。
     componentsSeparatedByString：分割数组。
     componentsJoineByString：组合数组。
     *
     */
    
    /**
     *
     可变数组：
     
     NSMutaleArray
     arrayWithCapacity：创建具有初始容量的数组。
     addObject：添加对象。
     removeObjectAtIndex：删除某个位置的对象。
     *
     */
    
    /**
     *  
     枚举:
     
     NSEnumerator
     objectEnumerator
     reverseObjectEnumerator
     nextObject
     *
     */
    NSArray *array = [[NSArray alloc] init];
    for(NSString *string in array){
        
        NSLog(@"I found %@", string);
    }
    
    /**
     *  
     字典：
     
     NSDictionary
     dictionaryWithObjectsAndKeys
     objectForKey
     *
     */
    
    /**
     *  
     可变字典：
     
     NSMutableDictionary
     dictionaryWithCapacity
     setObject:forKey:
     removeObjectForKey
     *
     */
    
    /**
     *  
     NSNumber
     
     numberWithChar
     numberWithInt
     numberWithFloat
     numberWithBool
     
     charValue
     intValue
     floatValue
     boolValue
     stringValue
     *
     */
    
    /**
     *  
     NSValue
     
     valueWithPoint
     valueWithSize
     valueWithRect
     
     pointValue
     sizeValue
     rectValue
     *
     */
    NSValue *value;
    CGRect rect = {1,1,3,4};
    value = [NSValue value:&rect withObjCType:@encode(CGRect)];
    CGRect rect3;
    [value getValue:&rect3];
    NSLog(@"%f %f",rect3.origin.x,rect3.origin.y);
    
    /**
     *  
     NSNull
     
     [NSNull null]
     注：<null>是一种[NSNull null]对象，而(null)是一个真实存在的nil值。
     *
     */
    
    /**
     *  在mac主目录上查找以jpg结尾的文件目录字符串。
     */
    NSFileManager *manager;
    manager = [NSFileManager defaultManager];
    
    NSString *home;
    home = [@"~"stringByExpandingTildeInPath];
    
    NSMutableArray *files;
    files = [NSMutableArray arrayWithCapacity:42];
    
    for (NSString *filename in [manager enumeratorAtPath:home]) {
        
        if([[filename pathExtension] isEqualToString:@"jpg"]){
 
            [files addObject:filename];
        }
    }
    
    for (NSString *filename in files) {
        
        NSLog(@"%@",filename);
    }
    
    /**
     *  
     NSCopying：复制自身。
     NSCoding：对自身进行编码或解码。
     
     *
     */
}

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

#pragma mark - userDefault读取数据

- (void)userDefaultTest {
 
    /*说明：读取iPhone设置内容
     
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    /*说明：根据键取出布尔值
     
     */
    [defaults boolForKey:@"bool"];
    
    /*说明：根据键取出NSInteger值
     
     */
    [defaults integerForKey:@"integer"];
    
    /*说明：根据键取出float值
     
     */
    [defaults floatForKey:@"float"];
    
    /*说明：根据键取出double类型值
     
     */
    [defaults doubleForKey:@"double"];
    
    /*说明：根据键取出NSString类型值
     
     */
    [defaults stringForKey:@"string"];
    
    /*说明：根据键取出id类型值
     
     */
    [defaults objectForKey:@"object"];
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
}

- (void)download {
    
}

#pragma mark - 通知机制

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

#pragma mark - request请求

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
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *data  = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"请求完成... %@",data);
    
    /**
     异步请求sendAsynchronousRequest
     
     */
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
                               NSLog(@"请求完成... %@",data);
                               
                               NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:nil];
                               NSLog(@"%@",resDict);
                           }];
}

#pragma mark - NSURLConnection请求

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

#pragma mark - MKNetworkKit

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
     *  获得沙盒目录下的缓存目录，这个目录位于Library → Caches
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

#pragma mark - 判断系统版本号

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
}

#pragma mark - 栏

- (void)BarTest {
    
    /**
     *  
     
     状态栏 20
     导航栏 44
     工具栏 44
     标签栏 49
     
     iOS 7情况下，这些栏变成半透明，背景图片可以不需要考虑这些栏造成的影响。
     
     */
    
    /**
     *  
     隐藏状态栏
     在Info.plist文件中加入
     View controller-based status bar appearance
     设置值为NO，就可以在全局状态下控制状态栏是否隐藏。
     
     然后在单个视图控制器中调用：
     */
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    /**
     *  
     设置状态栏风格
     UIStatusBarStyleDefault。默认的黑色文字。
     UIStatusBarStyleLightContent。白色文字。
     */
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
}



@end
