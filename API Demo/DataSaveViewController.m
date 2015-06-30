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
#import <AVFoundation/AVFoundation.h>

/*说明：
 
 */
@interface DataSaveViewController ()<AVAudioPlayerDelegate>

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

#pragma mark - 沙盒 文件系统 文件保存 文件读取 文件目录 文件删除 文件夹

- (void)documentsTest {
    
    /*说明：获取沙盒位置
     
     */
    NSBundle *bundle = [NSBundle mainBundle];
    NSLog(@"%@",bundle);//DLog
    
    /*说明：Documents目录
     该目录用于存储非常大的文件或需要非常频繁更新的数据，能够进行iTunes或iCloud的备份。
     
     */
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    /*说明：取出路径
     
     */
    NSString *myDocPath = [documentDirectory objectAtIndex:0];
    NSLog(@"%@",myDocPath);
    
    /**
     Documents folder
     
     URLsForDirectory：
     NSDocumentDirectory
     NSLibraryDirectory
     NSCachesDirectory
     
     */
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory
                                        inDomains:NSUserDomainMask];
    if ([urls count] > 0){
        
        NSURL *documentsFolder = urls[0];
        NSLog(@"%@", documentsFolder);
    } else {
        NSLog(@"Could not find the Documents folder.");
    }
    
    /*说明：Library目录，在Library目录下面有Preferences和Caches目录
     Preferences用于存放应用程序的设置数据，
     Caches与Documents很相似，可以存放应用程序的数据，用来存储缓存文件。
     
     */
    
    /*说明：tmp目录
     这是临时文件目录，用户可以访问它。它不能够进行iTunes或iCloud的备份。
     
     */
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSLog(@"%@",tmpDirectory);
    
    /**
     *  有一些文本信息需要临时保存 Temp 保存 创建文件
     */
    NSString *someText = @"Random string that won't be backed up.";
    NSString *destinationPath = [NSTemporaryDirectory()
                                 stringByAppendingPathComponent:@"MyFile.txt"];
    NSError *error = nil;
    BOOL succeeded = [someText writeToFile:destinationPath
                                atomically:YES
                                  encoding:NSUTF8StringEncoding
                                     error:&error];
    if (succeeded) {
        NSLog(@"Successfully stored the file at: %@", destinationPath);
    } else {
        NSLog(@"Failed to store the file. Error = %@", error);
    }
    
    /**
     *  在磁盘中创建一个文件夹 创建文件夹 创建目录
     *
     */
    NSFileManager *fileManager2 = [[NSFileManager alloc] init];
    NSString *tempDir2 = NSTemporaryDirectory();
    NSString *imagesDir2 = [tempDir2 stringByAppendingPathComponent:@"images"];
    NSError *error2 = nil;
    /**
     *  
     createDirectoryAtPath:
     要被创建文件夹的路径.
     
     withIntermediateDirectorys:
     一个Boolean 值,如果设置为YES,则在创建最深层文件前,将会创建所有的父
     文件夹.例如,如果你想在你应用tmp 文件夹下名叫data 的文件夹中创建一个
     名叫images 的文件夹,但是data 文件夹还不存在,则此时你可以很容易的通过
     设置withIntermediateDirectorys 为YES 来要求系统为你创建tmp/data/images/文件
     夹.
     
     attributes:
     一个传递给系统可以影响文件夹将如何创建的属性字典.此处我们不使用这些参
     数,是为了保持示例的简单,但你可以改变这些属性,如文件夹修改日期及时
     间,创建日期及时间及其他其他你所希望修改的属性.
     
     error:
     此参数接受一个NSObject 类型的错误对象,在创建文件时发生的任何错误将
     被此对象捕获（populated）.通常为此参数传递一个错误对象是一个好的主意,
     因为在方法返回失败（返回NO）时,你可以获取错误信息并判断发生了什么.
     
     */
    if ([fileManager2 createDirectoryAtPath:imagesDir2
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:&error2]) {
        
        NSLog(@"Successfully created the directory.");
    } else {
        
        NSLog(@"Failed to create the directory. Error = %@", error2);
    }
    
    /**
     枚举了应用的资源束文件夹下所有的文件,文件夹及符号链接 枚举文件 枚举文件夹

     */
    NSFileManager *fileManager3 = [[NSFileManager alloc] init];
    NSString *bundleDir3 = [[NSBundle mainBundle] bundlePath];
    NSError *error3 = nil;
    NSArray *bundleContents3 = [fileManager3 contentsOfDirectoryAtPath:bundleDir3
                                                                 error:&error3];
    if ([bundleContents3 count] > 0 && error3 == nil) {
        
        NSLog(@"Contents of the app bundle = %@", bundleContents3);
    } else if ([bundleContents3 count] == 0 && error3 == nil) {
        
        NSLog(@"Call the police! The app bundle is empty.");
    } else {
        
        NSLog(@"An error happened = %@", error3);
    }
    
    /**
     *  删除文件 删除文件夹
     *
     */
    NSString *txtFolder = [NSTemporaryDirectory() stringByAppendingPathComponent:@"txt"];
    [self deleteFilesInFolder:txtFolder];
    [self deleteFolder:txtFolder];
    
    /**
     *  磁盘中文件的安全处理
     */
    NSString *filePath = [[self cachesDirectory] stringByAppendingPathComponent:@"file.txt"];
    [self createFileIfDoesntExist:filePath];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    NSLog(@"fileHandle = %@", fileHandle);
}

//========================================================================================================

/**
 *  从文件中读取和保存字符串
 */
- (void)saveAndReadStringFromPath {
    
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"];
    
    if ([self writeText:@"Hello, World!" toPath:filePath]) {
        
        NSString *readText = [self readTextFromPath:filePath];
        
        if ([readText length] > 0) {
            
            NSLog(@"Text read from disk = %@", readText);
        } else {
            
            NSLog(@"Failed to read the text from disk.");
        }
    } else {
        
        NSLog(@"Failed to write the file.");
    }
}

/**
 *  从文件中读取和保存数组
 *  只能保存 NSString，NSDictionary，NSArray，NSData，NSNumber，NSDate
 */
- (void)saveAndReadArrayFromPath {
    
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"];
    NSArray *arrayOfNames = @[@"Steve", @"John", @"Edward"];
    
    if ([arrayOfNames writeToFile:filePath atomically:YES]) {
        
        NSArray *readArray = [[NSArray alloc] initWithContentsOfFile:filePath];
        if ([readArray count] == [arrayOfNames count]) {
            
            NSLog(@"Read the array back from disk just fine.");
        } else {
            
            NSLog(@"Failed to read the array back from disk.");
        }
    } else {
        
        NSLog(@"Failed to save the array to disk.");
    }
}

/**
 *  从文件中读取和保存字典
 */
- (void)saveAndReadDictionaryFromPath {
    
    NSString *filePath = [NSTemporaryDirectory()
                          stringByAppendingPathComponent:@"MyFile.txt"];
    NSDictionary *dict = @{
                           @"first name" : @"Steven",
                           @"middle name" : @"Paul",
                           @"last name" : @"Jobs",
                           };
    if ([dict writeToFile:filePath atomically:YES]){
        NSDictionary *readDictionary = [[NSDictionary alloc]
                                        initWithContentsOfFile:filePath];
        /* Now compare the dictionaries and see if the one we read from disk
         is the same as the one we saved to disk */
        if ([readDictionary isEqualToDictionary:dict]){
            NSLog(@"The file we read is the same one as the one we saved.");
        } else {
            NSLog(@"Failed to read the dictionary from disk.");
        }
    } else {
        NSLog(@"Failed to write the dictionary to disk.");
    }
}

/**
 *  从文件中读取和保存字节
 */
- (void)saveAndReadbyteFromPath {
    
    NSString *filePath = [NSTemporaryDirectory()
                          stringByAppendingPathComponent:@"MyFile.txt"];
    char bytes[4] = {'a', 'b', 'c', 'd'};
    NSData *dataFromBytes = [[NSData alloc] initWithBytes:bytes
                                                   length:sizeof(bytes)];
    if ([dataFromBytes writeToFile:filePath atomically:YES]){
        NSData *readData = [[NSData alloc] initWithContentsOfFile:filePath];
        if ([readData isEqualToData:dataFromBytes]){
            NSLog(@"The data read is the same data as was written to disk.");
        } else {
            NSLog(@"Failed to read the data from disk.");
        }
    } else {
        NSLog(@"Failed to save the data to disk.");
    }
}

- (BOOL)writeText:(NSString *)paramText toPath:(NSString *)paramPath {
    
    return [paramText writeToFile:paramPath
                       atomically:YES
                         encoding:NSUTF8StringEncoding
                            error:nil];
}

- (NSString *)readTextFromPath:(NSString *)paramPath {
    
    return [[NSString alloc] initWithContentsOfFile:paramPath
                                           encoding:NSUTF8StringEncoding
                                              error:nil];
}

//========================================================================================================

/**
 *  如何枚举文件夹并返回文件夹下的所有项目.你甚至知道如何获得不同项目的不同属性.
 */
- (void)pintDocumentsTest {
    
    /*  1  */
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSURL *bundleDir = [[NSBundle mainBundle] bundleURL];
    NSArray *propertiesToGet = @[
                                 NSURLIsDirectoryKey,
                                 NSURLIsReadableKey,
                                 NSURLCreationDateKey,
                                 NSURLContentAccessDateKey,
                                 NSURLContentModificationDateKey
                                 ];
    NSError *error = nil;
    
    /**
     *  
     contentsOfDirectoryAtURL
     准备遍历的文件夹路径.此路径需要传递为一个NSURL 实例.如果你不知道如
     何创建这个NSURL 实例,不要担心,我们将在后面讨论.
     
     includingPropertiesForKeys
     传递一个你希望IOS 系统为在目标文件夹下遍历到的文件,文件夹或其他项目返
     回的属性数组值.例如,你可以指定让项目的创建时间返回到结果数组中,此时
     指向遍历到项目的URL 实例的部分属性值将返回(在框架返回的NSURL 对象中).
     下面是可传递给这个数组
     最重要参数的列表：
     NSURLIsDirectoryKey
     稍后允许你判断遍历到的URL 所指对象是否是目录.
     NSURLIsReadableKey
     稍后允许你判断遍历到的URL 所指项目对你的应用是否可读.
     NSURLCreateionDateKey
     返回遍历到项目的创建日期.
     NSURLContentAccessDateKey
     返回遍历到项目内容的最后存取日期.
     NSURLContentModificationDateKey
     如同参数名所表示的,此参数允许你判断遍历返回的URL 所指项目的最后
     修改时间.
     
     options
     此参数只允许0 或NSDirectoryEnumerationSkipHiddenFiles 值传入.如果传入的
     后面这个参数,如同参数名称所示,所有文件在枚举时将被忽略.
     
     error
     一个对象的引用,当方法执行失败时,错误信息将存到此对象中.尽可能的传入
     一个错误对象通常是个好主意.即使方法执行失败时,你也可以通过失败信息获
     得更多的控制权.
     
     */
    NSArray *itemsInAppBundle = [manager contentsOfDirectoryAtURL:bundleDir
                                       includingPropertiesForKeys:propertiesToGet
                                                          options:0
                                                            error:&error];
    if (error != nil) {
        
        NSLog(@"An error happened = %@", error);
    }
    
    /*  2  */
    for (NSURL *paramURL in itemsInAppBundle){
    
        NSLog(@"Item name = %@", [paramURL lastPathComponent]);
        NSLog(@"Is a Directory? %@", [self isURLDirectory:paramURL]);
        NSLog(@"Is Readable? %@", [self isURLReadable:paramURL]);
        NSLog(@"Creation Date = %@",
              [self dateOfType:NSURLCreationDateKey inURL:paramURL]);
        NSLog(@"Access Date = %@",
              [self dateOfType:NSURLContentAccessDateKey inURL:paramURL]);
        NSLog(@"Modification Date = %@",
              [self dateOfType:NSURLContentModificationDateKey inURL:paramURL]);
        NSLog(@"-----------------------------------");
    }
}

/**
 *  
 此方法将获得URL对象的字符串布尔值（Yes 或 No）属性.例如：URL是否是
 一个目录的信息是存储为一个二进制的布尔值,因此,如果想要打印一个布尔值
 到控制台,我们需要先把它转化为字符串.对每一个URL,我们将查询两个项
 目,将返回包含NSURLIsDirectoryKey及NSURLIsReadableKey布尔值的
 NSNumber实例.所以代替写两次代码,此方法将为我们进行NSNumber转换到字
 符串Yes或No.
 
 *
 */
- (NSString *)stringValueOfBOOLProperty:(NSString *)paramProperty
                                  ofURL:(NSURL *)paramURL {
    NSNumber *boolValue = nil;
    NSError *error = nil;
    [paramURL getResourceValue:&boolValue
                        forKey:paramProperty
                         error:&error];
    if (error != nil){
        NSLog(@"Failed to get property of URL. Error = %@", error);
    }
    return [boolValue isEqualToNumber:@YES] ? @"Yes" : @"No";
}

/**
 *  
 传入一个URL检测是否是一个目录.此方法内部使用
 stringValueOfBOOLProperty:ofURL,且传入NSURLIsDirectroyKey给它.
 
 *
 */
- (NSString *)isURLDirectory:(NSURL *)paramURL {
    
    return [self stringValueOfBOOLProperty:NSURLIsDirectoryKey ofURL:paramURL];
}

/**
 *  
 判断对给定的URL,你的应用是否有存取权限.此方法内部同样使用
 stringValueOfBOOLProperty:ofURL,且传入NSURLIsDirectroyKey给它.
 
 *
 */
- (NSString *)isURLReadable:(NSURL *)paramURL {
    
    return [self stringValueOfBOOLProperty:NSURLIsReadableKey ofURL:paramURL];
}

/**
 *  
 由于我们将对每个URL检测三次的属性类型是NSDate类型,我们简单的把相关代
 码封装在此方法中,这些代码对URL将传入键值并返回与键值相应的日期.
 
 *
 */
- (NSDate *)dateOfType:(NSString *)paramType inURL:(NSURL *)paramURL {
    
    NSDate *result = nil;
    NSError *error = nil;
    [paramURL getResourceValue:&result
                        forKey:paramType
                         error:&error];
    if (error != nil){
        NSLog(@"Failed to get property of URL. Error = %@", error);
    }
    return result;
}

//========================================================================================================

/* Deletes all files/folders in a given path 删除已经创建的文件 */
- (void)deleteFilesInFolder:(NSString *)paramPath {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:paramPath
                                                         error:&error];
    if (error == nil) {
        
        error = nil;
        for (NSString *fileName in contents) {
            /* We have the filename, to delete it,
             we have to have the full path */
            NSString *filePath = [paramPath stringByAppendingPathComponent:fileName];
            if ([fileManager removeItemAtPath:filePath error:&error] == NO){
                
                NSLog(@"Failed to remove item at path %@. Error = %@",fileName,error);
            }
        }
    } else {
        
        NSLog(@"Failed to enumerate path %@. Error = %@", paramPath, error);
    }
}

/* Deletes a folder with a given path 删除tmp/txt 文件夹 */
- (void)deleteFolder:(NSString *)paramPath {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error = nil;
    if ([fileManager removeItemAtPath:paramPath error:&error] == NO) {
        
        NSLog(@"Failed to remove path %@. Error = %@", paramPath, error);
    }
}

//========================================================================================================

/**
 *  对文件持续写入 NSFileHandle
 */
- (void)fileHandleTest {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"file.txt"];
    BOOL fileIsCreated = NO;
    if ([fileManager fileExistsAtPath:filePath] == NO) {
        fileIsCreated = [fileManager createFileAtPath:filePath
                                             contents:nil
                                           attributes:nil];
    }
    
    if (fileIsCreated == YES) {
        
        /* Open the file handle */
        
        /**
         *  
         
         fileHandleForUpdatingAtPath:
         打开文件并获得读写权限,此将把文件指针放在文件的起始处.
         
         fileHandleForReadingAtPath:
         打开文件并只具有读取权限.
         
         fileHandleForWritingAtPath:
         打开文件并只具有写权限.
         
         */
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        
        if (fileHandle != nil) {
            NSString *stringToWrite = @"Hello, World!";
            
            /* Write the data */
            [fileHandle writeData:[stringToWrite dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSLog(@"Wrote to the file.");
            
        } else {
            NSLog(@"Failed to create the file handle.");
        }
        
        /* Close the file handle */
        [fileHandle closeFile];
        
        /* Delete the file now that we no longer need it */
        [fileManager removeItemAtPath:filePath error:nil];
        
    } else {
        NSLog(@"Failed to create the file on disk.");
    }
}

//========================================================================================================

/**
 *  返回你应用资源束中Library/Caches/目录路径.
 */
- (NSString *)cachesDirectory {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];//要改为类的成员变量
    NSArray *caches = [fileManager URLsForDirectory:NSCachesDirectory
                                          inDomains:NSUserDomainMask];
    if ([caches count] > 0){
        NSURL *result = caches[0];
        return [result path];
    } else {
        return nil;
    }
    
}

/**
 *  
 传入一个文件的路径,如果此文件不存在将创建它.文件创建时把将文件属性
 NSFileProtectionKey 的值设置为NSFileProtectionComplete,这样在设备锁定时,文件
 也将被锁定,即使我们锁定设备时文件已经被打开.
 
 *
 */
- (void)createFileIfDoesntExist:(NSString *)paramPath {
    
    /**
     
     NSFileProtectionCompeteUnlessOpen
     文磁盘件将被加密且只有设备解锁后你的应用才能访问.用户可以再次锁定设备,
     但只要你处理过文件,则可以继续对文件进行读写.
     
     NSFileProtectionComplete
     磁盘文件被加密且只有用户在解锁设备情况下才能存取.你在设备未锁定状态处理
     一个文件,当设备再次锁定后,你将不能对文件进行读写.
     
     NSFileProtectionCompleteUntilFirstUserAuthentication
     磁盘文件被加密,但在用户解锁设备一次后,即可对文件进行读写.从这次设备解锁
     后之后,都可以对文件进行读写,即使用户再次锁定设备,也不会影响你及文件的句
     柄.
     
     */
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];//要改为类的成员变量
    NSDictionary *attributes = @{NSFileProtectionKey : NSFileProtectionComplete};
    
    if ([fileManager fileExistsAtPath:paramPath] == NO){
        [fileManager createFileAtPath:paramPath
                                  contents:nil
                                attributes:attributes];
    }
    
}

- (void)writeToFile {
    
    NSString *filePath = [[self cachesDirectory] stringByAppendingPathComponent:@"file.txt"];
    [self createFileIfDoesntExist:filePath];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];//要改为类的成员变量
    
    UIBackgroundTaskIdentifier backgroundTask;//要改为类的成员变量
    
    @try {
        
        NSLog(@"Attempting to write to the file...");
        [fileHandle writeData: [@"Hello World" dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Successfully wrote to the file. Make sure you have a passcode\
              set on your device. This method should have failed!");
    }
    @catch (NSException *exception) {
        
        NSLog(@"Failed to write to file. Is it locked?");
    }
    @finally {
        
        NSLog(@"Finishing our background task...");
        [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
    }
}

/**
 *  延迟10 秒执行一个写入操作计划
 *
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSString *filePath = [[self cachesDirectory] stringByAppendingPathComponent:@"file.txt"];
    [self createFileIfDoesntExist:filePath];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];//要改为类的成员变量
    
    __block UIBackgroundTaskIdentifier backgroundTask;//要改为类的成员变量
    
    if (fileHandle == nil){
        NSLog(@"The file wasn't opened. No point trying to write to it!");
        return;
    }
    
    NSLog(@"Scheduling writing to file in 10 seconds...");
    backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
                               backgroundTask = UIBackgroundTaskInvalid;
                           }];
    
    [self performSelector:@selector(writeToFile)
               withObject:nil
               afterDelay:10.0f];
    
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
    NSFileManager *fileManager = [NSFileManager defaultManager];//不是线程安全
    
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
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//不是线程安全
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
- (void)write:(NSMutableArray*)array toFilePath:(NSString*)path
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
    
    //========================================================================================================
    
    //archiveRootObject 归档方法    unarchiveObjectWithFile 反归档方法
    
    /* Define the name and the last name we are going to set in the object */
//    NSString *const kFirstName = @"Steven";
//    NSString *const kLastName = @"Jobs";
    
    /* Determine where we want to archive the object */
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"steveJobs.txt"];
    
    /* Instantiate the object */
//    Person *steveJobs = [[Person alloc] init];
//    steveJobs.firstName = kFirstName;
//    steveJobs.lastName = kLastName;
//    
//    /* Archive the object to the file */
//    [NSKeyedArchiver archiveRootObject:steveJobs toFile:filePath];
//    
//    /* Now unarchive the same class into another object */
//    Person *cloneOfSteveJobs = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    
//    /* Check if the unarchived object has the same first name and last name
//     as the previously-archived object */
//    if ([cloneOfSteveJobs.firstName isEqualToString:kFirstName] &&
//        [cloneOfSteveJobs.lastName isEqualToString:kLastName]) {
//        
//        NSLog(@"Unarchiving worked");
//    } else {
//        
//        NSLog(@"Could not read the same values back. Oh no!");
//    }
    
    /* We no longer need the temp file, delete it */
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager removeItemAtPath:filePath error:nil];
    
}

/*说明：bo对象必须实现
 NSCoding 协议
 
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    /*说明：此方法将给你一个编码器对象.此编码器对象你可以像一个词典那样使用,可以简单的通过你所选择的键值
     存储数值进去.
     
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_content forKey:@"content"];
    */
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]){
        
    /*说明：当你使用NSKeyedUnarchiver对象反归档你的对象时,此方法将被调用.你可以很简单的通过传递进来的
     NSCoder对象获取你回的数值
    
    self.date = [aDecoder decodeObjectForKey:@"date"];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    
    */
        
    }
    
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

- (void)coreDataTest {
    
    /**
     *  
     
     Persistent store coordinator
     这是物理数据存储的物理文件和程序之间的联系的桥梁。这个桥梁将负责管理不同对象的上下文。
     
     Managed object model
     这跟一个数据库的框架的概念是一样的。他可以代表一个数据库的桌面或者在创建的数据库里的不同管理对象类型。
     
     Managed object context
     这是程序员和管理对象模式之间的桥梁。
     
     Managed object
     这和表格里的列很相似。我们将管理对象插入到管理对象上下文并保存它。
     
     Entity
     这和数据库的表格相似。
     
     Attribute
     在entity（实体）里定义一个栏。
     
     *
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

/**
 *  AVFoundation.framework 和 MediaPlayer.framework
 */
- (void)musicTest3 {
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:@"MySong" ofType:@"mp3"];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        /* Start the audio player */
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        /* Did we get an instance of AVAudioPlayer? */
        if (audioPlayer != nil){
            /* Set the delegate and start playing */
            audioPlayer.delegate = self;
            if ([audioPlayer prepareToPlay] &&
                [audioPlayer play]){
                /* Successfully started playing */
            } else {
                /* Failed to play */
            }
        } else {
            /* Failed to instantiate AVAudioPlayer */
        }
    });
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    NSLog(@"Finished playing the song");
    
    /* The [flag] parameter tells us if the playback was successfully
     finished or not */
    
    AVAudioPlayer *audioPlayer;
    if ([player isEqual:audioPlayer]){
        
        audioPlayer = nil;
    } else {
        
        /* Which audio player is this? We certainly didn't allocate
         this instance! */
    }
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
