//
//  UINaviViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 10/13/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "UINaviViewController.h"
#import "CEReversibleAnimationController.h"
#import "CECubeAnimationController.h"
#import "CEBaseInteractionController.h"
#import "CEHorizontalSwipeInteractionController.h"
#import "CEHorizontalSwipeInteractionControllerOrigin.h"
#import "AWPercentDrivenInteractiveTransition.h"

@interface UINaviViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) CEReversibleAnimationController *animationController;
@property (nonatomic, strong) CEBaseInteractionController *interactionController;
@property (nonatomic, strong) CEHorizontalSwipeInteractionControllerOrigin *interactionControllerOrigin;
@property (nonatomic, strong) AWPercentDrivenInteractiveTransition *awInteractiveTransition;
@end

@implementation UINaviViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _animationController = [CECubeAnimationController new];
    _animationController.reverse = YES;
    _interactionController = [CEHorizontalSwipeInteractionController new];
    _interactionControllerOrigin = [CEHorizontalSwipeInteractionControllerOrigin new];
    
    _awInteractiveTransition = [[AWPercentDrivenInteractiveTransition alloc]initWithAnimator:_animationController];
    // 1、代理设置
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate
// 2、动画控制器设置
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if(operation ==  UINavigationControllerOperationPop){
        _animationController.reverse = NO;
    }else{
        _animationController.reverse = YES;
    }
    return _animationController;
}

// 3、手势控制器
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    return _interactionController.interactionInProgress?_interactionController:nil;
//    return _interactionControllerOrigin;
//    return _awInteractiveTransition;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (_interactionController) {
        [_interactionController wireToViewController:viewController forOperation:CEInteractionOperationPop];
    }
}

@end
