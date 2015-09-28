//
//  LogViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/4.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "LogViewController.h"

/*说明：
 
 */
@interface LogViewController ()

@end

/*说明：专门用来放置NSLog的说明文件
 
 */
@implementation LogViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //TODO: do something 加入todo标识
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 打印更多信息

- (void)doSomeThing:(NSString *)string {
    
    /*说明：以下都是系统预留的定义词
     __func__               当前函数名称
     __PRETTY_FUNCTION__    当前函数名称
     __LINE__               代码所在行
     __FILE__               该文件所在位置
     string                 参数值
     
     */
    NSLog(@"\n Function: %s\n Pretty function: %s\n Line: %d\n File: %s\n Object: %@",__func__, __PRETTY_FUNCTION__, __LINE__, __FILE__, string);
    
    /*说明：获得当前选择器
     
     */
    NSLog(@"Current selector: %@", NSStringFromSelector(_cmd));
    
    /*说明：获得当前类
     
     */
    NSLog(@"Object class: %@", NSStringFromClass([self class]));
    
    /*说明：获得当前文件名
     
     */
    NSLog(@"Filename: %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent]);
}

#pragma mark - 移除NSAssert

- (void)assertRemoveTest {
    
    /**
     
     1、New Scheme创建一个新的Scheme，
     Edit Scheme → Info → Build Configuration → Release
     
     2、TARGETS → Build Settings → Preprocessor Macros
     配置它的Release为NS_BLOCK_ASSERTIONS
     
     3、选择新建的Scheme运行。
     
     如果要移除NSLog，可以查看MKNetworkKit.h
     *
     */
}

#pragma mark - XCTest框架定义的常用断言宏

- (void)assertTest {
    
    /**
     *  
     XCTest Assertions Documentation
     http://appleprogramming.com/blog/2013/12/26/xctest-assertions-documentation/
     
     无条件断言失败，遇到这句话后不会继续运行
     XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
     
     如果等式不相等就不会继续运行
     XCTAssertTrue([strTax doubleValue] == 45, @"期望值是：45 实际值是：%@", strTax);
     
     如果两个对象的值不相等就不会继续运行
     XCTAssertEqualObjects(strTax, @"0.00", @"期望值是：0.00 实际值是：%@", strTax);
     
     如果该对象为空就不会继续运行
     XCTAssertNotNil(self.masterViewController, @"MasterViewController非空");
     *
     */
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
