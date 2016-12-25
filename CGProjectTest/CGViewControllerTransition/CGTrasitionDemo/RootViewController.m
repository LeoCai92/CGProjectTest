//
//  RootViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 9/23/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "CEBaseInteractionController.h"

@interface RootViewController ()<UIViewControllerTransitioningDelegate>

@end
static int colorIndex = 0;
@implementation RootViewController{
    NSArray* _colors;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _colors = @[[UIColor redColor],
                [UIColor orangeColor],
                [UIColor yellowColor],
                [UIColor greenColor],
                [UIColor blueColor],
                [UIColor purpleColor]];
    
    self.view.backgroundColor = _colors[colorIndex];
    
    colorIndex  = (colorIndex + 1) % _colors.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowSettings"]) {
        UIViewController *toVC = segue.destinationViewController;
        toVC.transitioningDelegate = self;
    }
    
    [super prepareForSegue:segue sender:sender];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if (AppDelegateAccessor.settingsInteractionController) {
        [AppDelegateAccessor.settingsInteractionController wireToViewController:presented forOperation:CEInteractionOperationDismiss];
    }
    
    AppDelegateAccessor.settingsAnimationController.reverse = NO;
    return AppDelegateAccessor.settingsAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AppDelegateAccessor.settingsAnimationController.reverse = YES;
    return AppDelegateAccessor.settingsAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return AppDelegateAccessor.settingsInteractionController && AppDelegateAccessor.settingsInteractionController.interactionInProgress ? AppDelegateAccessor.settingsInteractionController : nil;
}

#pragma mark - dismiss
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
