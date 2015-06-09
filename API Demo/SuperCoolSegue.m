//
//  SuperCoolSegue.m
//  API Demo
//
//  Created by 杨毅辉 on 15/6/9.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "SuperCoolSegue.h"

@implementation SuperCoolSegue

/**
 *  自定义转场动画
 */
- (void)perform {
    
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    // Create a UIImage with the contents of the destination
    UIGraphicsBeginImageContext(destination.view.bounds.size);
    [destination.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *destinationImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Add this image as a subview to the tab bar controller
    UIImageView *destinationImageView = [[UIImageView alloc] initWithImage:destinationImage];
    [source.parentViewController.view addSubview:destinationImageView];
    
    // Scale the image down and rotate it 180 degrees (upside down)
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.1, 0.1);
    CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(M_PI);
    destinationImageView.transform = CGAffineTransformConcat(scaleTransform, rotateTransform);
    
    // Move the image outside the visible area
    CGPoint oldCenter = destinationImageView.center;
    CGPoint newCenter = CGPointMake(oldCenter.x - destinationImageView.bounds.size.width, oldCenter.y);
    destinationImageView.center = newCenter;
    
    // Start the animation
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^(void)
     {
         destinationImageView.transform = CGAffineTransformIdentity;
         destinationImageView.center = oldCenter;
     }
                     completion: ^(BOOL done)
     {
         // Remove the image as we no longer need it
         [destinationImageView removeFromSuperview];
         
         // Properly present the new screen
         [source presentViewController:destination animated:NO completion:nil];
     }];
}

@end
