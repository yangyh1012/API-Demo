//
//  ViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/4.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        NSLog(@"init ViewController");
    }
    
    return self;
}

/*说明：
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*说明：
     资源文件目录

     */
    NSBundle *bundle = [NSBundle mainBundle];
    NSLog(@"%@",bundle);//DLog

    /*说明：
     documents文件目录
     
     */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths);//DLog

    
}

/**
 *  提供给测试工程使用
 *
 *  @param string 小数的字符串
 *
 *  @return 含1位小数点的字符串
 */
- (NSString *)testValue:(NSString *)string {
    
    double d = [string doubleValue];
    
    NSString *str = [NSString stringWithFormat:@"%.1f",d];
    
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"dealloc ViewController");
}

/**
 *  子视图 子视图控制器
 */
- (void)containerView {
    
    UIViewController *keysViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    /**
     *  iOS 5 添加子视图
     */
    UIViewController *menusViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    menusViewController.navigationItem.title = @"Shortcuts By Menu";
    UINavigationController *menusNav = [[UINavigationController alloc] initWithRootViewController:menusViewController];
    menusNav.view.frame = self.view.bounds;//self.view换成其他子视图，比如self.leftView
    [self.view addSubview:menusNav.view];
    
    [self addChildViewController:menusNav];
    [menusNav didMoveToParentViewController:self];
    
    /**
     *  iOS 5 子视图转换
     */
    [self addChildViewController:keysViewController];
    [self transitionFromViewController:menusViewController toViewController:keysViewController duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        [menusViewController.view removeFromSuperview];
        keysViewController.view.frame = self.view.bounds;//self.view换成其他子视图，比如self.leftView
        [self.view addSubview:keysViewController.view];
    } completion:^(BOOL finished) {
        [keysViewController didMoveToParentViewController:self];
        [menusViewController removeFromParentViewController];
    }];
    
    
    /**
     *  iOS 6 添加子视图
     */
    
    UINavigationController *navControllerLeft = [self.storyboard instantiateViewControllerWithIdentifier:@"ShortcutsNav"];
    UIViewController *shortcutsByKey = navControllerLeft.viewControllers[0];
    shortcutsByKey.navigationItem.title = @"Keys";
    navControllerLeft.view.frame = self.view.bounds;//self.view换成其他子视图，比如self.leftView
    [self.view addSubview:navControllerLeft.view];
    
    /**
     *  iOS 6 子视图转换
     */
    [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        [menusViewController.view removeFromSuperview];
        keysViewController.view.frame = self.view.bounds;//self.view换成其他子视图，比如self.leftView
        [self.view addSubview:keysViewController.view];
    } completion:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"Source Controller = %@", [segue sourceViewController]);
    NSLog(@"Destination Controller = %@", [segue destinationViewController]);
    NSLog(@"Segue Identifier = %@", [segue identifier]);
    
    if ([segue.identifier isEqualToString:@"viewcontrollerSegue"]) {
        
        //UINavigationController *navigationController = segue.destinationViewController;
        //ViewController *viewController = [[navigationController viewControllers] objectAtIndex:0];
        //NSLog(@"%@",viewController);
    }
}

/**
 *  我们需要确保我们的视图控制器会告诉运行进行时它将会能够处理所有的方向
 */
- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return YES;
}

@end
