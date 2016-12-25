//
//  CGNotificationTableViewCell.h
//  CGProjectTest
//
//  Created by LeoCai on 9/8/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UISwitch *notiSwitch;


-(void)setNotiSwitchState:(BOOL)state;
@end
