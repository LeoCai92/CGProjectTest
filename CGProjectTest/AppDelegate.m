//
//  AppDelegate.m
//  CGProjectTest
//
//  Created by LeoCai on 8/5/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "AppDelegate.h"
#import "CGNotificationViewController.h"

@interface AppDelegate ()<UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *notiTitles;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.backgroundColor = [UIColor purpleColor];
    //处理iOS8本地推送不能收到
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    _notiTitles = [NSMutableArray array];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    
    //判断应用程序当前的运行状态，如果是激活状态，则进行提醒，否则不提醒
    if (application.applicationState == UIApplicationStateActive){
        
    }
    
    if ([[notification.userInfo objectForKey:@"flag"] isEqualToString:@"alarm"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertTitle message:notification.alertBody delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:notification.alertAction, nil];
        [_notiTitles addObject:[notification.userInfo objectForKey:@"title"]];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UINavigationController *naviVC = (UINavigationController *)_window.rootViewController;
        CGNotificationViewController *notiVC = nil;
        if ([naviVC.topViewController isKindOfClass:[CGNotificationViewController class]]) {
            notiVC = (CGNotificationViewController *)naviVC.topViewController;
            
        }else{
            UIStoryboard *Main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            notiVC = [Main instantiateViewControllerWithIdentifier:@"CGNotificationViewController"];
            [naviVC pushViewController:notiVC animated:YES];
        }
        [notiVC setNotiTitles:_notiTitles];
        [notiVC refreshNotiSwitchState];
    }
}

@end
