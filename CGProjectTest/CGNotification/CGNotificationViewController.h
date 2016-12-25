//
//  CGNotificationViewController.h
//  CGProjectTest
//
//  Created by LeoCai on 9/8/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGNotificationViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *notiTitles;

-(void)refreshNotiSwitchState;
@end
