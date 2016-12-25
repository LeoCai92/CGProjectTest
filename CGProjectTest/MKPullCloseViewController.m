//
//  MKPullCloseViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 11/19/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "MKPullCloseViewController.h"
#import "MKPullCloseControllerAnimation.h"
#import "CEBaseInteractionController.h"
#import "CEVerticalSwipeInteractionController.h"

@interface MKPullCloseViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) MKPullCloseControllerAnimation *pullCloseAnimation;
@property (nonatomic, strong) CEBaseInteractionController *baseInteractionAnimation;
@end

@implementation MKPullCloseViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置转场代理
    self.transitioningDelegate = self;
    // 非交互式转场动画
    _pullCloseAnimation = [MKPullCloseControllerAnimation new];
    
    // 交互式转场动画
    _baseInteractionAnimation = [[CEVerticalSwipeInteractionController alloc]init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NonInteractiveAnimation
// Presentations
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //  如果存在交互式转场动画，给控制器设置交互手势
    if (self.transitioningDelegate && _baseInteractionAnimation) {
        [_baseInteractionAnimation wireToViewController:presented forOperation:CEInteractionOperationDismiss];
    }
    
    return _pullCloseAnimation;
}

// Dismissals
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _pullCloseAnimation.reverse = YES;
    
    return _pullCloseAnimation;
}

#pragma mark - InteractiveAnimation
// Presentations
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    
    return _baseInteractionAnimation.interactionInProgress?_baseInteractionAnimation:nil;
}

// Dismissals
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    _pullCloseAnimation.reverse = YES;
    
    return _baseInteractionAnimation;
}


@end
