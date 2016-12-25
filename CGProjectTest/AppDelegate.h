//
//  AppDelegate.h
//  CGProjectTest
//
//  Created by LeoCai on 8/5/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEBaseInteractionController.h"
#import "CEReversibleAnimationController.h"

// a macro for easy access to the singleton app-delegate. Yes, I know some people
// consider the an anti-pattern, but this is just a simple test app, so let's
// not stress about it? ;-)
#define AppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CEReversibleAnimationController *settingsAnimationController;
@property (strong, nonatomic) CEReversibleAnimationController *navigationControllerAnimationController;
@property (strong, nonatomic) CEBaseInteractionController *navigationControllerInteractionController;
@property (strong, nonatomic) CEBaseInteractionController *settingsInteractionController;


@end

