//
//  ViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/4.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *mainSwitch;

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
    
    if ([segue.identifier isEqualToString:@"viewcontrollerSegue"]) {
        
        //UINavigationController *navigationController = segue.destinationViewController;
        //ViewController *viewController = [[navigationController viewControllers] objectAtIndex:0];
        //NSLog(@"%@",viewController);
    }
}

@end
