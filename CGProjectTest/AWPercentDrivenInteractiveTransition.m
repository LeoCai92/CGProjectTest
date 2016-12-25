//
//  AWPercentDrivenInteractiveTransition.m
//
//  Created by Alek Astrom on 2014-04-27.
//
// Copyright (c) 2014 Alek Åström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "AWPercentDrivenInteractiveTransition.h"

@implementation AWPercentDrivenInteractiveTransition {
    __weak id<UIViewControllerContextTransitioning> _transitionContext;
    BOOL _isInteracting;
    CADisplayLink *_displayLink;
    UIViewController *_viewController;
    UIPanGestureRecognizer *_gesture;
//    CEInteractionOperation _operation;
}

#pragma mark - Initialization
- (instancetype)initWithAnimator:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    self = [super init];
    if (self) {
        [self _commonInit];
        _animator = animator;
    }
    return self;
}
- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}
- (void)_commonInit {
    _completionSpeed = 1;
}

#pragma mark - Public methods
- (BOOL)isInteracting {
    return _isInteracting;
}
- (CGFloat)duration {
    return [_animator transitionDuration:_transitionContext];
}
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSAssert(_animator, @"The animator property must be set at the start of an interactive transition");
    
    _transitionContext = transitionContext;
    [_transitionContext containerView].layer.speed = 0;
    
    [_animator animateTransition:_transitionContext];
}
- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    self.percentComplete = fmaxf(fminf(percentComplete, 1), 0); // Input validation
}
- (void)cancelInteractiveTransition {
    [_transitionContext cancelInteractiveTransition];
    [self _completeTransition];
}
- (void)finishInteractiveTransition {
    
    /*CALayer *layer = [_transitionContext containerView].layer;
     layer.speed = 1;
     
     CFTimeInterval pausedTime = [layer timeOffset];
     layer.timeOffset = 0.0;
     layer.beginTime = 0.0; // Need to reset to 0 to avoid flickering :S
     CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
     layer.beginTime = timeSincePause;*/
    
    [_transitionContext finishInteractiveTransition];
    [self _completeTransition];
}
- (UIViewAnimationCurve)completionCurve {
    return UIViewAnimationCurveLinear;
}

#pragma mark - Private methods
- (void)setPercentComplete:(CGFloat)percentComplete {
    _percentComplete = percentComplete;
    
    [self _setTimeOffset:percentComplete*[self duration]];
    [_transitionContext updateInteractiveTransition:percentComplete];
}
- (void)_setTimeOffset:(NSTimeInterval)timeOffset {
    [_transitionContext containerView].layer.timeOffset = timeOffset;
}
- (void)_completeTransition {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_tickAnimation)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)_tickAnimation {
    
    NSTimeInterval timeOffset = [self _timeOffset];
    NSTimeInterval tick = [_displayLink duration]*[self completionSpeed];
    timeOffset += [_transitionContext transitionWasCancelled] ? -tick : tick;
    
    if (timeOffset < 0 || timeOffset > [self duration]) {
        [self _transitionFinished];
    } else {
        [self _setTimeOffset:timeOffset];
    }
}
- (CFTimeInterval)_timeOffset {
    return [_transitionContext containerView].layer.timeOffset;
}
- (void)_transitionFinished {
    [_displayLink invalidate];
    
    CALayer *layer = [_transitionContext containerView].layer;
    layer.speed = 1;
    
    if (![_transitionContext transitionWasCancelled]) {
        CFTimeInterval pausedTime = [layer timeOffset];
        layer.timeOffset = 0.0;
        layer.beginTime = 0.0; // Need to reset to 0 to avoid flickering :S
        CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        layer.beginTime = timeSincePause;
    }
}

#pragma mark - 
- (void)wireToViewController:(UIViewController *)viewController {
    self.popOnRightToLeft = NO;
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
//                _shouldCompleteTransition = (fraction > 0.5);
                
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
                if (gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
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


@end
