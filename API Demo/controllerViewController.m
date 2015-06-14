//
//  controllerViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/6/14.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "controllerViewController.h"

@implementation controllerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - UIActivityViewController

/**
 *  UIActivityViewController 分享控制器 显示分享选项
 */
- (void)activityViewControllerTest {
    
    /**
     applicationActivities为nil，表示显示的内容依赖于系统的分享选项
     
     */
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"12345"]
                                                                                        applicationActivities:nil];
    
    [self presentViewController:activityViewController
                       animated:YES
                     completion:^{
                         /* Nothing for now */
                     }];
}

#pragma mark - UINavigationController 导航控制器

- (void)navigationControllerTest {
    
    UIViewController *rootViewController = [[UIViewController alloc] initWithNibName:nil bundle:NULL];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    yyhLog(navigationController);
    
    
    
    
    /**
     *  设置导航栏标题
     */
    self.title = @"First Controller";
    
    /**
     *  要在导航控制器的当前视图中的标题中用一张图片代替文本
     *  该代码必须在一个内置导航控制器的视图控制器上执行。
     */
    UIImage *image = [UIImage imageNamed:@"FullSizeLogo.png"];
    yyhObjectInit(UIImageView, imageView);
    imageView.image = image;
    self.navigationItem.titleView = imageView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(performAdd:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(performAdd:)];
    /**
     自定义导航栏右边的按钮
     添加一个UISwitch，或者分段控件
     */
    UISwitch *simpleSwitch = [[UISwitch alloc] init];
    simpleSwitch.on = YES;
    [simpleSwitch addTarget:self
                     action:@selector(performAdd:)
           forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:simpleSwitch];
    
    /**
     指定是否以动画的方式显示按钮
     
     */
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:simpleSwitch];
    [self.navigationItem setRightBarButtonItem:rightBarButton animated:YES];
    
    
    
    /**
     将SecondViewController 的一个实例push 到栈中
     
     */
    UIViewController *secondController = [[UIViewController alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:secondController animated:YES];
    
    /**
     *  把它自动的pop 出栈
     */
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  你可以移除数组中任意位置的视图控制器。
 */
- (void)goBack {
    
    /* Get the current array of View Controllers */
    NSArray *currentControllers = self.navigationController.viewControllers;
    /* Create a mutable array out of this array */
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    /* Remove the last object from the array */
    [newControllers removeLastObject];
    /* Assign this array to the Navigation Controller with animation */
    [self.navigationController setViewControllers:newControllers animated:YES];
}

- (void)performAdd:(id)paramSender {
    
    NSLog(@"Action method got called.");
}

#pragma mark - 

- (void)tabBarControllerTest {
    
    /**
     UITabBarController添加两个UIViewController
     */
    UIViewController *firstViewController = [[UIViewController alloc] initWithNibName:nil bundle:NULL];
    UIViewController *secondViewController = [[UIViewController alloc] initWithNibName:nil bundle:NULL];
    NSArray *twoViewControllers = @[firstViewController,secondViewController];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:twoViewControllers];
    
    /**
     UITabBarController添加两个UINavigationController
     */
    UIViewController *firstViewController2 = [[UIViewController alloc] initWithNibName:nil bundle:NULL];
    UINavigationController *firstNavigationController =[[UINavigationController alloc] initWithRootViewController:firstViewController2];
    UIViewController *secondViewController2 = [[UIViewController alloc] initWithNibName:nil bundle:NULL];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController2];
    NSArray *twoNavControllers = @[firstNavigationController,secondNavigationController];
    UITabBarController *tabBarController2 = [[UITabBarController alloc] init];
    [tabBarController2 setViewControllers:twoNavControllers];
    
    /**
     *  tabBarController的标题
     */
    self.title = @"First";
    
    /**
     *  tabBarController的图片
     */
    self.tabBarItem.image = [UIImage imageNamed:@"SecondTab.png"];
}

@end
