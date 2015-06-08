//
//  iOSBookTest.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/11.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "iOSBookTest.h"

/*说明：
 
 */
@implementation iOSBookTest

#pragma mark - Objective-C基础教程

- (void)objectiveCJiChuJiaoCheng {
    
    
    /**
     *  
     1、输入控制台参数
     Edit Scheme → Arguments → Arguments Passed On Lauch
     argc保存argv数组的长度，argv[0]保存程序名，argv[1]为你信添加的参数。
     
     2、继承可以有效避免冗余代码。
     
     3、软件实体应该对拓展开放，而对修改关闭。
     在对其他对象的属性进行操作时，应该始终使用对象所提供的存取方法，永远不要直接改变其他对象属性的数值，应该使用setter方法进行更改。
     
     4、重写方法时，调用超类方法总是个不错的选择，这样可以实现更多的功能。
     
     5、在类中添加description方法就可以自定义NSLog()如何输出对象。
     
     6、防御性编程。
     
     7、如果在A.h中使用@class B，在B.h中使用@class A，那么这两个类就可以相互引用了。（继承关系不能使用@class）
     
     8、工厂方法：用来创建新对象的类方法称为工厂方法。
     
     9、应该等到调用者需要时再创建对象，这种技术被称为惰性求值。
     
     10、类中的某个初始化方法被指派为指定初始化函数。通常，接受参数最多的初始化方法最终成为指定初始化函数。
     
     *
     */
}

#pragma mark - iOS开发指南：从零基础到App Store上架（iOS7版 ）

/**
 *
 iOS开发指南：从零基础到App Store上架（iOS7版）第2版
 
 */
- (void)iOSKaiFaZhiNan {
    
    /**
     *
     一级目录
     
     1、生命周期
     2、表的使用
     3、电子书分页
     4、模式
     5、iPad专区
     6、分层架构
     7、图文混合排版
     8、设置和配置
     9、国际化
     10、sql的操作
     11、Core Data
     12、通讯录的操作
     13、解析XML
     
     */
    
    /*说明：
     二级目录
     
     1、应用生命周期
     2、视图生命周期
     3、UI状态保持和恢复
     
     1、简单表视图
     2、自定义单元格
     3、添加搜索栏
     4、添加索引
     5、分组与静态表
     6、删除和插入单元格
     7、移动单元格
     8、下拉刷新
     
     1、电子书分页实现
     
     1、单例模式：在一个iOS应用的生命周期中，有时候我们只需要某个类的一个实例。
     2、委托模式：为了降低一个对象的复杂度和耦合度。
     3、观察者模式：通知机制1对多，KVO机制1对1.
     4、MVC
     
     1、iPad专用API
     2、UIPopoverController控制器
     3、UISplitViewController控制器
     4、模态视图专用属性：modalPresentationStyle
     
     1、分层架构
     2、静态链接库
     
     1、文字图片混合排版
     
     1、创建Settings Bundle配置
     2、文本字段、滑块、开关、值列表和子界面设置项目。
     3、NSUserDefaults读取设置
     
     1、系统按钮和信息国际化
     2、应用名称国际化
     3、程序代码输出的静态文本国际化
     4、使用genstring工具
     5、xib 和故事板文件国际化
     6、图片、声音资源文件国际化
     
     1、sql的查询
     2、sql的增加
     3、sql的删除
     4、sql的修改
     
     1、Core Data分层架构设计
     2、Core Data查询数据
     3、Core Data增加数据
     4、Core Data删除数据
     5、Core Data修改数据
     
     1、低级API的通讯录增删改查联系人。
     2、高级API的通讯录增删改查联系人。
     
     1、使用NSXML解析XML文档。
     2、使用TBXML解析XML文档。https://github.com/71squared/TBXML
     
     1、高度、经度、维度测试。
     2、将经度、维度变成地点。
     3、将地点变成经度维度。
     4、在模拟器上测试地理位置。
     5、在地图上添加标注。
     6、跟踪用户位置变化。
     7、调用iOS 7苹果地图。（一个点需要标注）
     8、调用iOS 7苹果地图。（多个点需要标注）
     9、调用谷歌Web地图。
     
     1、收费策略（收费、应用内购买、广告）
     2、横幅广告（小矩形）
     3、插页广告（全屏）
     4、查看你的收入
     5、使用谷歌 AdMob 广告
     6、谷歌广告可以设置搜索关键字来推送相关的广告
     7、应用内购买 - 使用测试账号
     
     1、创建个人开发者证书的过程  
     
     1、Analyze
     2、Instruments
     
     1、内存优化(响应内存警告)
     2、资源优化(图片、音频)
     3、延迟加载
     4、序列化，数据库（表结构、查询、插入&删除优化），core data
     5、可重用对象
     6、多线程
     7、程序编译参数
     
     1、Gitolite服务器（在本地管理代码库，然后将结果推送给远程服务器）
     2、Git常用命令
     3、gitk图形界面（辅助管理Git）
     4、git分支
     5、git协同开发
     6、Xcode 5 中Git的配置与使用
     7、GitHub 代码托管服务（管理组织）
     
     1、把你的应用放到App Store上
     
     */
}

/**
 *  iOS 5 By Tutorials中文版
 */
- (void)iOS5ByTutorials {
    
    /**
     *  
     3.3. Cocos2D and Box2D
     3.4. 改进 Breakout
     3.5. 其他 C++ 说明
     3.6. 创建你自己的静态库
     
     
     
     
     
     
     
     
     
     */
}

#pragma mark - TODO

/*说明：工程架构，以后再补充
 
 */
- (void)iOSKaiFaZhiNan_gongchengjiagou {
    
    /*说明：
     
     base：放置最基础的父类，其他类从这里继承。
     common：放置一些公共代码，系统相关配置文件，常量文件等。
     util：放置一些工具类。
     exception：定义特殊异常
     
     
     
     */
}

#pragma mark - TODO

@end
