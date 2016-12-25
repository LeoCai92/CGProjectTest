//
//  CGNotificationTableViewCell.m
//  CGProjectTest
//
//  Created by LeoCai on 9/8/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGNotificationTableViewCell.h"

@implementation CGNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - event
- (IBAction)swipeSwitchOnOrOffNotification:(id)sender {
    
    UISwitch *notiSwitch = (UISwitch *)sender;
    if (notiSwitch.on) {
        // 开启通知
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        
        //1、设置本地通知的触发时间（如果要立即触发，无需设置），这里设置为3s后
        notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:3];
        
        //2、设置通知的内容
        notification.alertTitle=_titleLable.text;
        notification.alertBody=_titleLable.text;
        
        //3、设置通知动作按钮的标题
        notification.alertAction = @"查看";
        
        //4、设置本地通知的时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1;
        
        //5、设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
        notification.userInfo=@{@"flag":@"alarm",
                                @"title":_titleLable.text};
        
        //6、设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
        notification.soundName=UILocalNotificationDefaultSoundName;
        
        //7、在规定的日期触发通知
        [[UIApplication sharedApplication]scheduleLocalNotification:notification];
        
        //8、立即出发一个通知
//        [[UIApplication sharedApplication]presentLocalNotificationNow:notification];
    }else{
        // 关闭通知
        UIApplication *app=[UIApplication sharedApplication];
        NSArray *array=[app scheduledLocalNotifications];
        NSLog(@"%zd",array.count);
        
        for (UILocalNotification * local in array) {
            NSDictionary *dic= local.userInfo;
            if ([dic[@"flag"] isEqualToString:@"alarm"]) {
                //删除指定的通知
                [app cancelLocalNotification:local];
            }
        }
        //也可以使用[app cancelAllLocalNotifications]删除所有通知;
    }
}


#pragma mark - 
-(void)setNotiSwitchState:(BOOL)state{
    self.notiSwitch.on = state;
    
}

@end
