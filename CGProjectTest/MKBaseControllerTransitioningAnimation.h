//
//  MKPullCloseControllerAnimation.h
//  CGProjectTest
//
//  Created by LeoCai on 11/19/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MKBaseControllerTransitioningAnimation : NSObject <UIViewControllerAnimatedTransitioning>
/**
 动画的方向
 */
@property (nonatomic, assign) BOOL reverse;

/**
 动画执行的时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 由子类去实现转场动画

 @param transitionContext 转场上下文
 @param fromVC            presenting controller
 @param toVC              presented controller
 @param fromView          presenting view
 @param toView            presented view
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                   fromVC:(UIViewController *)fromVC
                     toVC:(UIViewController *)toVC
                 fromView:(UIView *)fromView
                   toView:(UIView *)toView;

@end
