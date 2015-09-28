//
//  KSSoundRecordTransition.m
//  KnowSomething
//
//  Created by 杨毅辉 on 15/9/11.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "KSSoundRecordTransition.h"

@interface KSSoundRecordTransition()

@property (assign ,nonatomic) BOOL isPresenting;

@end

@implementation KSSoundRecordTransition

- (id)initWithBool:(BOOL)ispresenting {
    
    self = [super init];
    if (self) {
        
        self.isPresenting = ispresenting;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
 
    if (self.isPresenting) {
        
        UIViewController *desController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *srcController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        UIView *containerView = [transitionContext containerView];
        containerView.layer.masksToBounds = YES;
        containerView.layer.cornerRadius = 10.0f;
        
        CGRect initialframe = [transitionContext finalFrameForViewController:desController];
        UIView *desControllerView = desController.view;
        desControllerView.alpha = 0.0;
        
        [containerView addSubview:desControllerView];
        containerView.frame = initialframe;
        
        UIView *srcControllerView = srcController.view;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             
                             desControllerView.alpha = 1.0;
                             srcControllerView.alpha = 0.7;
                             srcControllerView.transform = CGAffineTransformScale(srcController.view.transform, 0.92, 0.92);
                         }
                         completion:^(BOOL finished) {
                             
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    } else {
        
        UIViewController *desController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *srcController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

        UIView *srcControllerView = srcController.view;
        UIView *desControllerView = desController.view;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             
                             srcControllerView.alpha = 0.0;
                             desControllerView.alpha = 1;
                             desControllerView.transform = CGAffineTransformScale(srcController.view.transform, 1, 1);
                         }
                         completion:^(BOOL finished) {
                             
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled] || ![transitionContext isInteractive]];
                         }];
    }
}

@end
