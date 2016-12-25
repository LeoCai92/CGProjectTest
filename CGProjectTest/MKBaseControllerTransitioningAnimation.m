//
//  MKBaseControllerTransitioningAnimation.m
//  CGProjectTest
//
//  Created by LeoCai on 11/19/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "MKBaseControllerTransitioningAnimation.h"

@implementation MKBaseControllerTransitioningAnimation

#pragma mark - init
- (id)init
{
    if (self = [super init]) {
        self.duration = 0.5f;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;

    [self animateTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
}

#pragma mark - Animation
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                   fromVC:(UIViewController *)fromVC
                     toVC:(UIViewController *)toVC
                 fromView:(UIView *)fromView
                   toView:(UIView *)toView
{
}

@end
