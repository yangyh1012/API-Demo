//
//  FoundationTest.m
//  API Demo
//
//  Created by 杨毅辉 on 15/6/13.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "FoundationTest.h"

@implementation FoundationTest

#pragma mark - 几何数据类型

- (void)rangePointSizeRectTest {
    
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
}

#pragma mark - 字符串

- (void)stringTest {
    
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
     
     *
     */
    NSString *thing1 = @"name";
    NSString *thing2 = @"NAME";
    if ([thing1 compare:thing2 options:NSCaseInsensitiveSearch
         | NSNumericSearch] == NSOrderedSame) {
        
        NSLog(@"They are match!");
        
    }
    
    /**
     *  把一个NSString转换成C库里的字符串
     */
    const char *cString = [@"Objective-C String" UTF8String];
    NSLog(@"cString = %s",cString);
    
    /**
     *  把C字符串转换成NSString
     */
    NSString *objectString = [NSString stringWithUTF8String:"C String"];
    NSLog(@"objectString = %@",objectString);
    
    /**
     *  rangeOfString：包含某个字符串，在一个字符串中查找一个另外的字符串。
     */
    NSString *haystack = @"My Simple String";
    NSString *needle = @"Simple";
    //不关心大小写
    NSRange range = [haystack rangeOfString:needle options:NSCaseInsensitiveSearch];
    if (range.location == NSNotFound){
        /* Could NOT find needle in haystack */
    } else {
        /* Found the needle in the haystack */
        NSLog(@"Found %@ in %@ at location %lu",
              needle,
              haystack,
              (unsigned long)range.location);
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
    
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"My MacBook"];
    /* Add string to the end of this string */
    [mutableString appendString:@" Pro"];
    /* Remove the "My " string from the string */
    [mutableString replaceOccurrencesOfString:@"My " withString:[NSString string] /* Empty string */
                                      options:NSCaseInsensitiveSearch /* Case-insensitive */
                                        range:NSMakeRange(0, [mutableString length])]; /* All to the end */
    NSLog(@"mutableString = %@", mutableString);
}

#pragma mark - 数组

- (void)arrayTest {
    
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
    yyhArrayInit(array)
    for(NSString *string in array){
        
        NSLog(@"I found %@", string);
    }
    
    NSArray *array1 = @[@"My String", @123, @-123];
    NSLog(@"array = %@", array1[0]);
    
    /**
     *  数组排序
     */
    NSMutableArray *myArray = [NSMutableArray arrayWithArray:@[@"String 2",@"String 4",@"String 1",@"String 3"]];
    [myArray sortUsingComparator: ^NSComparisonResult(__strong id obj1, __strong id obj2) {
        
        NSString *string1 = (NSString *)obj1;
        NSString *string2 = (NSString *)obj2;
        return [string1 compare:string2];
    }];
    NSLog(@"myArray = %@", myArray);
    
    
}

#pragma mark - 字典

- (void)dictionaryTest {
    
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
    
    NSDictionary *person = @{
                             @"First Name" : @"Anthony",
                             @"Last Name" : @"Robbins",
                             @"Age" : @51
                             };
    NSLog(@"First Name = %@", person[@"First Name"]);
    NSLog(@"Last Name = %@", person[@"Last Name"]);
    NSLog(@"Age = %@", person[@"Age"]);
    
    /**
     *  遍历字典 block
     */
    NSDictionary *person1 = @{
                             @"First Name" : @"Anthony",
                             @"Last Name" : @"Robbins",
                             @"Age" : @51
                             };
    [person1 enumerateKeysAndObjectsUsingBlock:
     ^(__strong id key, __strong id obj, BOOL *stop) {
         
         NSLog(@"Key = %@, Object For Key = %@", key, obj);
     }];
    
    /**
     *  遍历字典 快速枚举
     */
    for (id keyInDictionary in [person allKeys]){
        
        id objectForKey = [person objectForKey:keyInDictionary];
        NSLog(@"Key = %@, Object For Key = %@", keyInDictionary, objectForKey);
    }
    
    /**
     *  遍历字典 枚举
     */
    NSEnumerator *keys = [person keyEnumerator];
    id keyInDictionary = nil;
    while ((keyInDictionary = [keys nextObject]) != nil) {
        
        id objectForKey = [person objectForKey:keyInDictionary];
        NSLog(@"Key = %@, Object For Key = %@", keyInDictionary, objectForKey);
    }
}

#pragma mark - 数值

- (void)numberTest {
    
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
    
    NSNumber *signedNumber = @-123456;
    NSNumber *unsignedNumber = @123456;
    NSNumber *floatNumber = @123456.123456f;
    NSNumber *doubleNumber = @123456.1234567890;
    
    NSInteger signedValue = [signedNumber integerValue];
    NSUInteger unsignedValue = [unsignedNumber unsignedIntegerValue];
    CGFloat floatValue = [floatNumber floatValue];
    double doubleValue = [doubleNumber doubleValue];
    
    NSLog(@"signedValue = %ld, \n"\
          "unsignedValue = %lu \n"\
          "floatValue = %f \n"\
          "doubleValue = %f",
          (long)signedValue,
          (unsigned long)unsignedValue,
          floatValue,
          doubleValue);
    
    /* Convert an unsigned integer inside an NSNumber to NSString */
    NSString *stringValueOfNumber = [NSString stringWithFormat:@"%lu",(unsigned long)[unsignedNumber unsignedIntegerValue]];
    NSLog(@"String from Number = %@", stringValueOfNumber);
}

#pragma mark - NSSet

- (void)setTest {
    
    /**
     *  sets 中相同对象只能被添加一次
     */
    NSString *hisName = @"Robert";
    NSString *hisLastName = @"Kiyosaki";
    NSString *herName = @"Kim";
    NSString *herLastName = @"Kiyosaki";
    NSSet *setOfNames = [[NSSet alloc] initWithObjects:
                         hisName,
                         hisLastName,
                         herName,
                         herLastName, nil];
    NSLog(@"Set = %@", setOfNames);
    
    /**
     *  addObject:方法类像set 添加一个新的对象
     */
    NSMutableSet *setOfNames1 = [[NSMutableSet alloc] initWithObjects:
                                hisName,
                                hisLastName, nil];
    [setOfNames1 addObject:herName];
    [setOfNames1 addObject:herLastName];
    
    /**
     *  想从一个set 中删除一个字符串，可以将字符串传递给removeObject:方法，即使新字符串是内存中的不同变量。
     */
    NSMutableSet *setOfNames2 = [[NSMutableSet alloc] initWithObjects:
                                hisName,
                                hisLastName,
                                herName,
                                herLastName, nil];
    [setOfNames2 removeObject:@"Kiyosaki"];
    NSLog(@"Set = %@", setOfNames2);
    
    /**
     *  快速遍历一个set 中所有的对象
     *
     */
    [setOfNames enumerateObjectsUsingBlock:^(__strong id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSString class]]){
            
            NSString *string = (NSString *)obj;
            
            if ([string isEqualToString:@"Kiyosaki"]){
                
                NSLog(@"Found %@ in the set", string);
                *stop = YES;
            }
        }
    }];
    
    /**
     *  在set 中获取一个随机的对象
     */
    NSString *string = [setOfNames anyObject];
    NSLog(@"Found %@ in the set", string);
}

#pragma mark - value

- (void)valueTest {
    
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
}

#pragma mark - Foundation Kit

- (void)foundationTest {
    
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
    
    /**
     *  isEqual:方法来比较两个对象
     */
    yyhObjectInit(NSObject, object1);
    NSObject *object2 = object1;
    
    if ([object1 isEqual:object2]){
        NSLog(@"Both objects are equal.");
    } else {
        NSLog(@"Objects are not equal.");
    }
    
    /**
     *  检测实例或类方法是否可用
     *
     *  instancesRespondToSelector:
     *  respondsToSelector:
     */
    if ([NSArray instanceMethodForSelector:@selector(sortUsingComparator:)]) {
        //检测某个类是否含有某个实例方法。
    }
    
    yyhObjectInit(NSArray, array);
    if ([array respondsToSelector:@selector(sortUsingComparator:)]) {
        //检测这个类是否含有某个实例方法。
    }
    
    if ([NSArray respondsToSelector:@selector(arrayWithObjects:)]) {
        //检测某个类的类方法。
    }
    
    /**
     *  确认类是否可在运行期使用
     *
     *  NSClassFromString
     */
    if (NSClassFromString(@"NSJSONSerialization") != nil){
        /* You can use this class */
        //        [NSJSONSerialization JSONObjectWithData:... /* Put data here */
        //                                        options:... /* Put options here */
        //                                          error:...]; /* Handle errors here */
    } else {
        /* That class is not available */
    }
    
    //或者
    
    id myObj = [[NSClassFromString(@"MySpecialClass") alloc] init];
    NSLog(@"%@",myObj);
}

@end
