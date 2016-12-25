//
//  SwipeINteractionController.m
//  ILoveCatz
//
//  Created by Colin Eberhardt on 22/08/2013.
//  Copyright (c) 2013 com.razeware. All rights reserved.
//

#import "CEHorizontalSwipeInteractionControllerOrigin.h"
#import "CECubeAnimationController.h"

@implementation CEHorizontalSwipeInteractionControllerOrigin {
    BOOL _shouldCompleteTransition;
    UIViewController *_viewController;
    UIPanGestureRecognizer *_gesture;
    CEInteractionOperation _operation;
    
    id<UIViewControllerContextTransitioning> _transitionContext;
    CECubeAnimationController *_cubeAnimationController;
}

-(void)dealloc {
    [_gesture.view removeGestureRecognizer:_gesture];
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //    _transitionContext = transitionContext;
    //    _cubeAnimationController = [CECubeAnimationController new];
    //
    //    // 提供动画
    //    [_cubeAnimationController animateTransition:transitionContext];
    
    // 提供交互式手势
    //    [self prepareGestureRecognizerInView:toVC.view];
    _transitionContext = transitionContext;
    
}


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return [_cubeAnimationController transitionDuration:transitionContext];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    [_cubeAnimationController animateTransition:transitionContext];
}
- (void)wireToViewController:(UIViewController *)viewController forOperation:(CEInteractionOperation)operation{
    self.popOnRightToLeft = NO;
    _operation = operation;
    _viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}


- (void)prepareGestureRecognizerInView:(UIView*)view {
    _gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:_gesture];
}

//- (CGFloat)completionSpeed
//{
//    return 1 - self.percentComplete;
//}

- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    switch (gestureRecognizer.state) {
            /*
        case UIGestureRecognizerStateBegan: {
            UIView *containerView = [_transitionContext containerView];
            if (_transitionContext) {
                containerView.layer.speed = 0;
            }
            BOOL rightToLeftSwipe = vel.x < 0;
            [_cubeAnimationController animateTransition:_transitionContext];
            // perform the required navigation operation ...
            
            if (_operation == CEInteractionOperationPop) {
                // for pop operation, fire on right-to-left
                if ((self.popOnRightToLeft && rightToLeftSwipe) ||
                    (!self.popOnRightToLeft && !rightToLeftSwipe)) {
                    self.interactionInProgress = YES;
                    [_viewController.navigationController popViewControllerAnimated:YES];
                }
            } else if (_operation == CEInteractionOperationTab) {
                // for tab controllers, we need to determine which direction to transition
                if (rightToLeftSwipe) {
                    if (_viewController.tabBarController.selectedIndex < _viewController.tabBarController.viewControllers.count - 1) {
                        self.interactionInProgress = YES;
                        _viewController.tabBarController.selectedIndex++;
                    }
                    
                } else {
                    if (_viewController.tabBarController.selectedIndex > 0) {
                        self.interactionInProgress = YES;
                        _viewController.tabBarController.selectedIndex--;
                    }
                }
            } else {
                // for dismiss, fire regardless of the translation direction
                self.interactionInProgress = YES;
                [_viewController dismissViewControllerAnimated:YES completion:nil];
            }
            
            break;
        }
             */
        case UIGestureRecognizerStateBegan:{
            UIView *containerView = [_transitionContext containerView];
            containerView.layer.speed = 0;

//            [_cubeAnimationController animateTransition:_transitionContext];
        }
        case UIGestureRecognizerStateChanged: {
            if (self.interactionInProgress) {
                // compute the current position
                CGFloat fraction = fabsf(translation.x / 200.0);
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                _shouldCompleteTransition = (fraction > 0.5);
                
                // if an interactive transitions is 100% completed via the user interaction, for some reason
                // the animation completion block is not called, and hence the transition is not completed.
                // This glorious hack makes sure that this doesn't happen.
                // see: https://github.com/ColinEberhardt/VCTransitionsLibrary/issues/4
                if (fraction >= 1.0)
                    fraction = 0.99;
                [self updateInteractiveTransition:fraction];
                
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (self.interactionInProgress) {
                self.interactionInProgress = NO;
                if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                    [self cancelInteractiveTransition];
                    
                }
                else {
                    [self finishInteractiveTransition];
                    
                }
            }
            break;
        default:
            break;
    }
}

#pragma mark -
- (void)updateInteractiveTransition:(CGFloat)percentComplete{
    [_transitionContext updateInteractiveTransition:percentComplete];
}

- (void)cancelInteractiveTransition{
    [_transitionContext cancelInteractiveTransition];
}

- (void)finishInteractiveTransition{
    [_transitionContext finishInteractiveTransition];
}

@end
