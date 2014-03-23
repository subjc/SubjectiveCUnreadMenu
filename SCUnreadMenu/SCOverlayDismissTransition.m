//
//  SCOverlayDismissTransition.m
//  SCUnreadMenu
//
//  Created by Sam Page on 16/03/14.
//  Copyright (c) 2014 Subjective-C. All rights reserved.
//

#import "SCOverlayDismissTransition.h"

@implementation SCOverlayDismissTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *dissmissingViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration
                     animations:^{
                         dissmissingViewController.view.alpha = 0.f;
                     } completion:^(BOOL finished) {
                         BOOL transitionWasCancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:transitionWasCancelled == NO];
                     }];
}

@end
