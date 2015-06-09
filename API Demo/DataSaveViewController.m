//
//  DataSaveViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/11.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "DataSaveViewController.h"
#import "sqlite3.h"
#import <AudioToolbox/AudioServices.h>

/*说明：
 
 */
@interface DataSaveViewController ()

@end

@implementation DataSaveViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 文件的加载和保存

- (void)fileLoadAndSave {
    
    //NSDate
    
    NSDate *date = [NSDate date];
    NSLog(@"today is %@",date);
    //对于过去的时间，使用负的时间间隔。
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
    NSLog(@"yesterday is %@",yesterday);
    
    //NSData、NSMutableData
    const char *string = "Hi there,this is a C string";
    NSData *data = [NSData dataWithBytes:string length:strlen(string) + 1];
    NSLog(@"data is %@",data);
    NSLog(@"%ld byte string is '%s'",(unsigned long)[data length],[data bytes]);
    
    
}

#pragma mark - 控制器中的控件或数据的保存

/*说明：实现该控制器中的控件或数据的保存
 
 */
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    /*说明：按照指定键保存内容
     
     */
    [coder encodeObject:@"12345" forKey:@"kkkk"];
}

/*说明：实现该控制器中的控件或数据的恢复
 
 */
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    /*说明：按照指定键恢复内容
     
     */
    NSString *string = [coder decodeObjectForKey:@"kkkk"];
    
    NSLog(@"%@",string);
}

#pragma mark - 沙盒

- (void)boxPath {
    
    /*说明：获取沙盒位置
     
     */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths);
    
    /*说明：Documents目录
     该目录用于存储非常大的文件或需要非常频繁更新的数据，能够进行iTunes或iCloud的备份。
     
     */
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    /*说明：取出路径
     
     */
    NSString *myDocPath = [documentDirectory objectAtIndex:0];
    NSLog(@"%@",myDocPath);
    
    /*说明：Library目录，在Library目录下面有Preferences和Caches目录
     Preferences用于存放应用程序的设置数据，
     Caches与Documents很相似，可以存放应用程序的数据，用来存储缓存文件。
     
     */
    
    /*说明：tmp目录
     这是临时文件目录，用户可以访问它。它不能够进行iTunes或iCloud的备份。
     
     */
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSLog(@"%@",tmpDirectory);
}

#pragma mark - 持久化方式（本地存储）属性列表。

/*说明：属性列表。
 集合对象可以读写到属性列表文件中。
 
 使用场景：
 属性列表文件和对象归档一般用于存储少量数据。
 属性列表文件的访问要比对象归档的访问简单，Foundation框架集合对象都有对应的方法读写属性列表文件
 
 */
- (void)shuxingliebiaoSave1 {
    
    /*说明：
    + arrayWithContentsOfFile。它是类级构造方法，用于从属性列表文件中读取数据，创建NSArray对象。
    – initWithContentsOfFile。它是实例构造方法，用于从属性列表文件读取数据，创建NSArray对象。
    – writeToFile:atomically。该方法把NSArray对象写入到属性列表文件中，它的第一个参数是文件名（需要包含路径），
     atomically:参数的值为BOOL类型，用于通知Cocoa是否应该首先将文件内容保存在临时文件中，当文件成功保存后，再将该临时文件和原始文件交换。
     
    */
    
    /*说明：
     + dictionaryWithContentsOfFile。它是类级构造方法，用于从属性列表文件读取数据，创建NSDictionary对象。
     – initWithContentsOfFile。它是实例构造方法，用于从属性列表文件读取数据，创建NSDictionary对象。
     – writeToFile:atomically。将NSDictionary对象写入到属性列表文件中，它的第一个参数是文件名（需要包含路径），
     atomically:参数的值为BOOL类型，用于通知Cocoa是否应该首先将文件内容保存在临时文件中，当文件成功保存后，再将该临时文件和原始文件交换。
     
     */
}

/*说明：在documents目录下创建某个文件
 
 */
- (void)createEditableCopyOfDatabaseIfNeededPlist {
    
    /*说明：获取documents目录中的某个文件
     
     */
    NSString *writableDBPath = [self applicationDocumentsDirectoryFilePlist];
    
    /*说明：创建文件管理器
     
     */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    /*说明：判断指定目录的文件是否存在
     
     */
    BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
    if (!dbexits) {
        
        /*说明：不存在时则从资源目录拷贝一份到documents目录中
         
         */
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NotesList.plist"];
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSAssert1(0, @"错误写入文件：'%@'。", [error localizedDescription]);
        }
    }
}

/*说明：获取documents目录中的某个文件
 
 */
- (NSString *)applicationDocumentsDirectoryFilePlist {
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    
    return path;
}

#pragma mark - 持久化方式（本地存储）属性列表。 序列化，减小文件大小

- (void)createEditableCopyOfDatabaseIfNeededBinary {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDBPath = [self applicationDocumentsDirectoryFileBinary];
    
    BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
    if (!dbexits) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NotesList.plist"];
        
        //读取资源文件中源plist文件
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:defaultDBPath];
        
        [self write:array toFilePath:writableDBPath];
        
    }
}

- (NSString *)applicationDocumentsDirectoryFileBinary {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.binary"];
    
    return path;
}

/**
 *  从NSMutableData对象中反序列化处理属性列表对象
 *
 */
- (NSMutableArray*)readFromArray: (NSString*)path
{
    //从文件读取到NSMutableData
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    //反序列化到属性列表对象（NSMutableArray）
    
    /**
     *  
     NSPropertyListImmutable。属性列表包含不可变对象。
     NSPropertyListMutableContainers。属性列表父节点是可变类型，子节点是不可变类型。
     NSPropertyListMutableContainersAndLeaves。属性列表父节点和子节点都是可变类型。
     
     */
    NSMutableArray* array = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainersAndLeaves format: NULL error:NULL];
    
    return array;
}

/**
 *  把NSMutableArray数据序列化后写入到文件中
 *
 */
- (void)write:(NSMutableArray*)array toFilePath: (NSString*)path
{
    //把属性列表对象（NSMutableArray）序列化为NSData
    
    /**
     *  
     NSPropertyListXMLFormat_v1_0。指定属性列表文件格式是XML格式，仍然是纯文本类型，不会压缩文件。
     NSPropertyListBinaryFormat_v1_0。指定属性列表文件格式为二进制格式，文件是二进制类型，会压缩文件。
     NSPropertyListOpenStepFormat。指定属性列表文件格式为ASCII码格式，对于旧格式的属性列表文件，不支持写入操作。
     
     */
    NSData * data = [NSPropertyListSerialization dataWithPropertyList:array format:NSPropertyListBinaryFormat_v1_0 options:NSPropertyListMutableContainersAndLeaves error:NULL];
    
    //写入到沙箱目录的序列化文件
    BOOL success = [data writeToFile:path atomically:YES];
    
    if (!success) {
        NSAssert(0, @"错误写入文件");
    }
}

#pragma mark - 持久化方式（本地存储）对象归档。

/*说明：对象归档。(这个过程成为编码和解码，或称为序列化和反序列化。)
 对象状态可以保存到归档文件中。
 
 使用场景：
 而对象归档是借助NSData实现的，使用起来比较麻烦。
 归档技术可以实现数据的持久化，不过在大量数据和频繁读写的情况下，它就不太合适了。
 
 对一个对象进行完整归档需要满足的条件为：
 该对象的类必须实现NSCoding协议，
 而且每个成员变量应该是基本数据类型或
 都是实现NSCoding协议的某个类的实例。
 
 */
- (void)duixiangguidangSave2 {
    
    
    /*说明：
     文件名换成：NotesList.archive
     
     */
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    
    NSMutableArray* array  = [[NSMutableArray alloc] init];
    [array addObject:@"1"];
    
    /*说明：
     归档过程。
     
     */
    NSMutableData * theData = [NSMutableData data];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
    [archiver encodeObject:array forKey:@"NotesList"];
    [archiver finishEncoding];
    
    [theData writeToFile:path atomically:YES];
    
    /*说明：
     反归档过程。
     
     */
    NSMutableArray *listArray = [[NSMutableArray alloc] init];
    NSData  *otherData =[NSData dataWithContentsOfFile:path];
    if([otherData length] > 0) {
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:otherData];
        listArray = [unArchiver decodeObjectForKey:@"NotesList"];
        [unArchiver finishDecoding];
    }
}

/*说明：bo对象必须实现
 NSCoding 协议
 
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    /*说明：
     
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_content forKey:@"content"];
    */
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    /*说明：
    
    self.date = [aDecoder decodeObjectForKey:@"date"];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    
    */
    
    return self;
}

#pragma mark - 持久化方式（本地存储）SQLite数据库。

/*说明：SQLite数据库。
 SQLite是一个开源嵌入式关系型数据库。
 
 使用场景：
 SQLite数据库和Core Data一般用于有几个简单表关系的大量数据的情况。
 
 */
- (void)sqliteshujukuSave3 {
    
    /*说明：
     加入库
     libsqlite3.dylib
     
     导入头文件
     #import "sqlite3.h"
     
     */
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.sqlite3"];
    
    sqlite3 *db;
    
    /*说明：打开数据库
     
     第一个参数是数据库文件的完整路径，需要注意的是在SQLite3函数中接受的是char*的UTF-8类型数据，
     需要将NSString*类型的数据转换为UTF-8类型，这可以使用NSString*的UTF8String方法实现；
     
     第二个参数为sqlite3指针变量db的地址；返回值是int类型。
     
     */
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSAssert(NO,@"数据库打开失败。");
    } else {
        
        char *err;
        NSString *createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Note (cdate TEXT PRIMARY KEY, content TEXT);"];
        
        /*说明：创建数据库
         
         第一个参数是sqlite3指针变量db，
         第二个参数是要执行的SQL语句，
         第三个参数是要回调的函数，
         第四个参数是要回调函数的参数，
         第五个参数是执行出错的字符串。
         
         */
        if (sqlite3_exec(db,[createSQL UTF8String],NULL,NULL,&err) != SQLITE_OK) {
            
            sqlite3_close(db);
            NSAssert1(NO, @"建表失败, %s", err);
        }
        
        /*说明：关闭数据库
         
         */
        sqlite3_close(db);
    }
}

- (void)sqlSentence {
    
    /*说明：要创建数据库，需要经过如下3个步骤。
     
    (1) 使用sqlite3_open函数打开数据库。
    (2) 使用sqlite3_exec函数执行Create Table语句，创建数据库表。
    (3) 使用sqlite3_close函数释放资源。
    */
    
    /*说明：数据查询
     
     (1) 使用sqlite3_open函数打开数据库。
     (2) 使用sqlite3_prepare_v2函数预处理SQL语句。
     (3) 使用sqlite3_bind_text函数绑定参数。
     (4) 使用sqlite3_step函数执行SQL语句，遍历结果集。
     (5) 使用sqlite3_column_text等函数提取字段数据。
     (6) 使用sqlite3_finalize和sqlite3_close函数释放资源。
     */
    
    /*说明：读取字段函数
     
     sqlite3_column_blob()
     sqlite3_column_double()
     sqlite3_column_int()
     sqlite3_column_int64()
     sqlite3_column_text()
     sqlite3_column_text16()
     */
    
    /*说明：修改数据
     
     (1) 使用sqlite3_open函数打开数据库。
     (2) 使用sqlite3_prepare_v2函数预处理SQL语句。
     (3) 使用sqlite3_bind_text函数绑定参数。
     (4) 使用sqlite3_step函数执行SQL语句。
     (5) 使用sqlite3_finalize和sqlite3_close函数释放资源。
     
     */
    
    /*说明：调用sqlite3_exec函数设置数据是否同步
     如果PRAGMA synchronous = OFF，则表示关闭了数据同步，
     不等待数据保存到存储介质就可继续执行插入操作，这在大量数据插入时可以大大提高速度。
     
     sqlite3_open(DATABASE, &db);
     sqlite3_exec(db, "PRAGMA synchronous = OFF", NULL, NULL, &err);
     
     也可以是PRAGMA synchronous = NORMAL 或 PRAGMA synchronous = FULL
     
    */
}



#pragma mark - 持久化方式（本地存储）Core Data。

/**
 *  
 说明：Core Data。
 它是一种对象关系映射技术（ORM），本质上也是通过SQLite存储的。
 
 使用场景：
 SQLite数据库和Core Data一般用于有几个简单表关系的大量数据的情况。
 
 */
- (void)coredataSave4 {
    
    /*说明：查询返回记录数的限制
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     //限制一次提取记录数
     [request setFetchLimit:10];
     //限制提取记录偏移量
     [request setFetchOffset:5];
     
     这两条语句相当于SELECT * FROM Note Limit 10 Offset 5;。
     
    */
    
    /*说明：设置pragma指令
     NSMutableDictionary *pragmaOptions = [NSMutableDictionary dictionary];
     [pragmaOptions setObject:@"OFF" forKey:@"synchronous"];
     [pragmaOptions setObject:@"OFF" forKey:@"count_changes"];
     [pragmaOptions setObject:@"MEMORY" forKey:@"journal_mode"];
     [pragmaOptions setObject:@"MEMORY" forKey:@"temp_store"];
     NSDictionary *storeOptions = [NSDictionary dictionaryWithObject:pragmaOptions forKey:NSSQLitePragmasOption];
     NSPersistentStore *store;
     NSError *error = nil;
     store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:storeOptions error:&error];
     
     */
    
    /*说明：
     
     
     */
}

#pragma mark - 音频 声音 声

- (void)musicTest {
    
    /**
     *  
     
     背景音乐优化：
     $ afconvert -f AIFC -d ima4 Fx08822_cast.wav
     
     音乐特效优化：
     $ afconvert -f caff -d LEI16 Fx08822_cast.wav
     
     音频文件在使用本地资源情况下，
     应用于背景音乐时AIFC格式是首选，
     应用于音乐特效时CAFF格式是首选。
     如果是资源来源与网络，最好采用MP3格式文件。
     
     *
     */
}

- (void)musicTest2 {
    
    /**
     *  音效的调用 声效 音效
     */
    NSString *filename = @"";
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    
    SystemSoundID theSoundID;
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
    if (error == kAudioServicesNoError) {
        
        
    }
    
    /**
     *  播放声效
     */
    AudioServicesPlaySystemSound(theSoundID);
    
    /**
     *  释放资源，清理声音对象
     */
    AudioServicesDisposeSystemSoundID(theSoundID);
}

#pragma mark - 图片 处理  图片处理 图片、图像视图

- (void)imageTest {
    
    /**
     *  背景图
     */
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_sand"]]];
    
    /**
     *  截图 截屏，其中self.view是这个图的范围
     */
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    /**
     *  将图片写入文档保存
     */
    NSData *data = UIImagePNGRepresentation(image);
    if (data != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filename = [[paths lastObject] stringByAppendingPathComponent:@"Cool.png"];
        
        NSError *error;
        if (![data writeToFile:filename options:NSDataWritingAtomic error:&error])
        {
            NSLog(@"Error: %@", error);
        }
    }
}

- (void)createImageView {
    
    /*说明：
     图片拉伸方法 iOS 5 伸缩
     
     */
    UIImage *image1 = [[UIImage imageNamed:@"test"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    
    /*说明：
     图片拉伸方法 iOS 6
     
     UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
     UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
     
     说明：
     http://blog.csdn.net/q199109106q/article/details/8615661
     
     */
    UIImage *image2 = [[UIImage imageNamed:@"test"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16) resizingMode:UIImageResizingModeStretch];
    
    NSLog(@"%@ %@",image1,image2);
    
    /**
     *
     + imageNamed:方法会在内存中建立缓存，这些缓存直到应用停止才清除。
     如果是贯穿整个应用的图片（如图标、logo等），推荐使用+ imageNamed:创建；如果是仅使用一次的图片，
     推荐使用下面的语句：
     
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"animal-2" ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    NSLog(@"%@ %@",image,image2);
}

#pragma mark -

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
