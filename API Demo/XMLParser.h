//
//  XMLParser.h
//  API Demo
//
//  Created by 杨毅辉 on 15/5/16.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject<NSXMLParserDelegate>

/**
 *  数据集合
 */
yyhMutableArrayDef(dataArray);

/**
 *  当前解析的标签名字
 */
yyhStringDef(tagName);

/**
 *  开始解析
 */
- (void)startParser;

@end
