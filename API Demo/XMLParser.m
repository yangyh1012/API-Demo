//
//  XMLParser.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/16.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

/**
 *  开始解析
 */
- (void)startParser {
    
    /**
     *  在别的文件使用
     
     XMLParser *parser = [XMLParser new];
     [parser startParser];
     
     */
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"NotesTestData" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    /**
     NSXMLParser是解析类，它有3个构造方法：
     
     initWithContentsOfURL:。
     可以使用URL对象创建解析对象。本例中采用该方法先从资源文件中加载对象，获得URL对象，再使用URL对象构建解析对象。
     
     initWithData:。
     可以使用NSData创建解析对象。
     
     initWithStream:。
     可以使用IO流对象创建解析对象。
     
     :returns: <#return value description#>
     */
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - NSXMLParserDelegate

/**
 *  文档开始的时候触发
 *
 *  @param parser <#parser description#>
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    _dataArray = [NSMutableArray new];
}

/**
 *  文档出错的时候触发
 *
 *  @param parser     <#parser description#>
 *  @param parseError <#parseError description#>
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSLog(@"%@",parseError);
}

/**
 *  遇到一个开始标签时候触发
 *
 *  @param parser        <#parser description#>
 *  @param elementName   <#elementName description#>
 *  @param namespaceURI  命名空间
 *  @param qName         限定名
 *  @param attributeDict 字典类型的属性集合
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
                namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    _tagName = elementName;
    if ([_tagName isEqualToString:@"Note"]) {
        
        NSString *tagId = [attributeDict objectForKey:@"id"];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:tagId forKey:@"id"];
        [_dataArray addObject:dict];
    }
}

/**
 *  @Description 遇到字符串时候触发
 *
 *  @param parser A parser object.
 *  @param string A string representing the complete or partial textual content of the current element.
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    /**
     *  替换回车符和空格
     */
    string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        
        return;
    }
    
    NSMutableDictionary *dict = [_dataArray lastObject];
    
    if ([_tagName isEqualToString:@"CDate"] && dict) {
        
        [dict setObject:string forKey:@"CDate"];
    }
    
    if ([_tagName isEqualToString:@"Content"] && dict) {
        
        [dict setObject:string forKey:@"Content"];
    }
    
    if ([_tagName isEqualToString:@"UserID"] && dict) {
        
        [dict setObject:string forKey:@"UserID"];
    }
}

/**
 *  遇到结束标签时候出发
 *
 *  @param parser       <#parser description#>
 *  @param elementName  <#elementName description#>
 *  @param namespaceURI <#namespaceURI description#>
 *  @param qName        <#qName description#>
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
                namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    self.tagName = nil;
}

/**
 *  遇到文档结束时候触发
 *
 *  @param parser <#parser description#>
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"%@",self.dataArray);
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.notes userInfo:nil];
    self.dataArray = nil;
}

@end
