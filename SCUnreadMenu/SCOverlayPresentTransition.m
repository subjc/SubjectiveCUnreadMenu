//
//  SCOverlayTransition.m
//  SCUnreadMenu
//
//  Created by Sam Page on 16/03/14.
//  Copyright (c) 2014 Subjective-C. All rights reserved.
//

#import "SCOverlayPresentTransition.h"

@implementation SCOverlayPresentTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *presentingViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *overlayViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:presentingViewController.view];
    [containerView addSubview:overlayViewController.view];

    overlayViewController.view.alpha = 0.f;
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration
                     animations:^{
                         overlayViewController.view.alpha = 0.9f;
                     } completion:^(BOOL finished) {
                         BOOL transitionWasCancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:transitionWasCancelled == NO];
                     }];
}

@end
