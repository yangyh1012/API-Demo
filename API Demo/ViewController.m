//
//  ViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/4.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "ViewController.h"
#import <iAd/iAd.h>

@interface ViewController ()<ADBannerViewDelegate>


@end

@implementation ViewController

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
}



@end
