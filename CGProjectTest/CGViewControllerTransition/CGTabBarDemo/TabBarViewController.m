//
//  TabBarViewController.m
//  TabBarDemo
//
//  Created by Colin Eberhardt on 18/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "TabBarViewController.h"
#import "CEFoldAnimationController.h"
#import "CECubeAnimationController.h"
#import "CEHorizontalSwipeInteractionController.h"
#import "Masonry.h"
#import "CECubeAnimationController.h"

@interface TabBarViewController () <UITabBarControllerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIButton *dismissButton;
@end

@implementation TabBarViewController {
    CECubeAnimationController *_animationController;
    CEHorizontalSwipeInteractionController *_swipeInteractionController;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
//        self.transitioningDelegate = self;
        [self.view addSubview:self.dismissButton];
        
        // create the interaction / animation controllers
        _swipeInteractionController = [CEHorizontalSwipeInteractionController new];
        _animationController = [CECubeAnimationController new];
//        _animationController.folds = 3;
        
        // observe changes in the currently presented view controller
        [self addObserver:self
               forKeyPath:@"selectedViewController"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    return self;
}

-(void)dealloc{
    
    // 注意要及时的清除掉Observer，否则容易引起crash
    [self removeObserver:self forKeyPath:@"selectedViewController"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedViewController"] )
    {
    	// wire the interaction controller to the view controller
        [_swipeInteractionController wireToViewController:self.selectedViewController
                                             forOperation:CEInteractionOperationTab];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    _animationController.reverse = fromVCIndex < toVCIndex;
    return _animationController;
//    return [[CECubeAnimationController alloc]init];
}

-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return _swipeInteractionController.interactionInProgress ? _swipeInteractionController : nil;
}

#pragma mark - lazy subviews
-(UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton new];
        [self.view addSubview:_dismissButton];
        
        [_dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
        _dismissButton.backgroundColor = [UIColor orangeColor];
        [_dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        
        [_dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(64.f);
        }];
    }
    return _dismissButton;
}

#pragma mark - dismiss
- (void)dismiss:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
