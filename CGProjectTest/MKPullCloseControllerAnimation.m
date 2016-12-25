//
//  MKPullCloseControllerAnimation.m
//  CGProjectTest
//
//  Created by LeoCai on 11/19/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "MKPullCloseControllerAnimation.h"

@implementation MKPullCloseControllerAnimation

#pragma mark - Animation
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    if(self.reverse){
        [self executeReverseAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    } else {
        [self executeForwardsAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
    
}

-(void)executeForwardsAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView
{
    // 1、将toView添加到转场发生的地方------containerView
    UIView* containerView = [transitionContext containerView];
    
    // positions the to- view off the bottom of the sceen
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    __block CGRect offScreenFrame = frame;
    offScreenFrame.origin.y = offScreenFrame.size.height;
    toView.frame = offScreenFrame;
    [containerView insertSubview:toView aboveSubview:fromView];
    
    [UIView animateWithDuration:self.duration animations:^{
        offScreenFrame.origin.y = 0;
        toView.frame = offScreenFrame;
    } completion:^(BOOL finished) {
        // 最后注意通知转场结束
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}

-(void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView
{
    // 1、转场发生的地方
    UIView *containerView = [transitionContext containerView];
    // 将toView提前放到fromView的下面
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = frame;
    [containerView insertSubview:toView belowSubview:fromView];
    
    // 2、执行动画
    __block CGRect offScreenFrame = frame;
    [UIView animateWithDuration:self.duration animations:^{
        offScreenFrame.origin.y = frame.size.height;
        fromView.frame = offScreenFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
