//
//  AnimateViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/13.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "AnimateViewController.h"

@interface AnimateViewController ()

@end

@implementation AnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIView animateWithDuration:0.3f animations:^{
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - block 动画

- (void)blockAnimationTest {
    
    UIView *daysView;
    UIView *_lionImage;
    UIView *_downLionImage;
    CGPoint point;
    
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        daysView.alpha = 1.0f;
        daysView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            daysView.transform = CGAffineTransformIdentity;
            daysView.frame = CGRectMake(point.x - 150.0/2, point.y + 10.0, 150, 100);
        } completion:nil];
    }];
    
    [UIView animateWithDuration:5.0 delay:0.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        [_lionImage setFrame:CGRectMake(185, 347, 115, 76)];
        [_lionImage setAlpha:0.0];
    } completion:nil];
    
    [UIView animateWithDuration:5.0 delay:4.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        [_downLionImage setFrame:CGRectMake(94, 70, 115, 76)];
    } completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            _downLionImage.transform = CGAffineTransformMakeScale(2.05f, 2.05f);
        } completion:nil];
    }];
}

#pragma mark - 粒子系统

/**
 *  创建下落的雪花
 */
- (void)emitterLayerTest {
    
    //创建发射源
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //粒子发射位置
    snowEmitter.emitterPosition = CGPointMake((self.view.frame.size.width)/2.0,100);
    //发射源的尺寸大小
    snowEmitter.emitterSize = CGSizeMake(320, 10);
    //发射模式
    snowEmitter.emitterMode = kCAEmitterLayerSurface;
    //发射源的形状
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    //粒子重叠时将出现很炫的效果
//    snowEmitter.renderMode = kCAEmitterLayerAdditive;
    
    //创建粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake.name = @"snow";
    //每秒钟发射的粒子数量
    snowflake.birthRate = 1.0;
    //一个粒子从发射到消失的时间
    snowflake.lifetime = 120.0;
    //将粒子的生命周期限制在一定的范围内
//    snowflake.lifetimeRange = 0.5;
    //设置粒子的颜色或图片
    snowflake.contents = (id)[[UIImage imageNamed:@"snow"] CGImage];
    //设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor colorWithRed:0.200 green:0.258 blue:0.543 alpha:1.000] CGColor];
    
    //粒子速度
    snowflake.velocity = 10.0;
    //粒子速度的变化范围
    snowflake.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake.yAcceleration = 1;
    //单元发射的角度范围
    snowflake.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    
    //粒子大小的变化率
//    snowflake.scaleSpeed = 0.3;
    //粒子的旋转速度
//    snowflake.spin = 0.5;
    
    //创建粒子
    CAEmitterCell *snowflake1 = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake1.name = @"snow1";
    //每秒钟发射的粒子数量
    snowflake1.birthRate = 1.0;
    //一个粒子从发射到消失的时间
    snowflake1.lifetime = 120.0;
    //粒子速度
    snowflake1.velocity =10.0;
    //粒子的速度范围
    snowflake1.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake1.yAcceleration = 1;
    //周围发射角度
    snowflake1.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake1.spinRange = 0.25 * M_PI;
    //设置粒子的颜色或图片
    snowflake1.contents = (id)[[UIImage imageNamed:@"snow"] CGImage];
    //设置雪花形状的粒子的颜色
//    snowflake1.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    //粒子阴影
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    //粒子边缘的颜色
    snowEmitter.shadowColor = [[UIColor redColor] CGColor];
    
    snowEmitter.emitterCells = [NSArray arrayWithObjects:snowflake,snowflake1,nil];
    
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
