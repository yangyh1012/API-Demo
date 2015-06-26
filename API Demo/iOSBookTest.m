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

#pragma mark - iOS 5 By Tutorials中文版

/**
 *  iOS 5 By Tutorials中文版
 */
- (void)iOS5ByTutorials {
    
    /**
     *  
     （未看）3.3. Cocos2D and Box2D
     （未看）3.4. 改进 Breakout
     （未看）3.5. 其他 C++ 说明
     （未看）3.6. 创建你自己的静态库
     
     （未看）5.4. Storyboards 如何在iPad项目中使用（关于UISplitViewController）
     （未看）5.5.如何在一个应用中使用多个Storyboards文件
     
     （未看）第 6 章 初级iCloud
     （未看）第 7 章 中级iCloud
     
     （未看）第 8 章 初级OpenGL ES 2.0
     （未看）第 9 章 中级OpenGL ES 2.0
     
     （未看）10.9. 自定义UITextField、定制UITextField
     （未看）11.9. 定制弹出框
     
     （未看）第 12 章 初级Twitter
     （未看）第 13 章 中级Twitter
     （未看）第 14 章 初级Newsstand
     （未看）第 15 章 中级Newsstand
     （未看）第 16 章 初级UIPageViewController
     （未看）第 17 章 中级UIPageViewController
     （未看）第 18 章 初级回合制游戏
     （未看）第 19 章 中级回合制游戏
     
     （未看）第 20 章 初级Core Image（1、滤镜 2、从相簿获取图片 3、保存到相簿）
     （未看）第 21 章 中级Core Image（1、混合滤镜 3、人脸检测）
     
     （未看）第 25 章 使用iOS字典（字典）
     （未看）第 26 章 新的AddressBook APIs（通讯录）
     （未看）第 27 章 新的LocationAPIs（定位）
     （未看）第 28 章 新的Game Center APIs（游戏中心）
     （未看）第 29 章 新的CalendarAPIs（日历）
     （未看）第 30 章 新的Linguistic TaggerAPIs（语义识别）
     
     */
}

#pragma mark - iOS 6 Programming Cookbook中文版

- (void)iOS6ProgrammingCookbook {
    
    /**
     *
     （未看）1.9. 自定义UISegmentedControl
     （未看）1.25. 使用UISplitViewController 显示Master-Detail 视图
     （未看）1.26. 使用UIPageViewController 启用分页
     （未看）1.27. 使用UIPopoverController 显示弹出画面（弹出框）
     （未看）1.12.3. 继承NSOperation（使用Operation 同步运行任务）
     （未看）1.13.3. 继承NSOperation（使用Operation 异步运行任务）
     （未看）第7 章 定位和地图
     （未看）1.11. 将Twitter 的功能集成到你的应用中
     （未看）1.12. 通过NSXMLParser 来解析XML
     （未看）第10 章 音频和视频
     （未看）第11 章 通讯录
     
     */
    
    /*
     第7 章 定位和地图
        1.1. 创建一个地图的视图
        1.2. 处理Map 视图上的事件
        1.3. 精确定位设备的位置
        1.4. 在地图视图上添加锚点
        1.5. 在地图上添加不同颜色的锚点
        1.6. 在地图视图上添加自定义的锚点
        1.7. 通过一个有意义的地址得到一组经纬度数据
        1.8. 通过一组经纬度数据得到一个地点名称
     */
    
    /*
     第10 章 音频和视频
        1.2. 处理播放音频时的中断
        1.3. 录制音频
        1.4. 处理录制音频过程中的中断
        1.5. 在其他活动声音上面播放音频
        1.6. 播放视频文件
        1.7. 从视频文件中捕获缩略图
        1.8. 访问音乐库
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
