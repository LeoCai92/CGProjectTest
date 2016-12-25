//
//  CGNotificationViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 9/8/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

/**
 * 通知三步走
 * 1、AppDelegate：注册通知
 * 2、添加UILocalNotification对象：
 * 3、处理通知：AppDelegate--->didReceiveLocalNotification
 */
#import "CGNotificationViewController.h"
#import "CGNotificationTableViewCell.h"

#define kNotificationCellIdentify @"CGNotificationTableViewCell"

@interface CGNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titles;
@end

@implementation CGNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib *notiNib = [UINib nibWithNibName:kNotificationCellIdentify bundle:nil];
    [self.tableView registerNib:notiNib forCellReuseIdentifier:kNotificationCellIdentify];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:nil
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNotificationCellIdentify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLable.text = self.titles[indexPath.row];
    if ([self isNotificationClosedWithTitle:self.titles[indexPath.row]]) {
        [cell setNotiSwitchState:NO];// 如果到期就关闭
    }
    
    return cell;
}
#pragma mark - Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)refreshNotiSwitchState{
    
    [self.tableView reloadData];
}

-(BOOL)isNotificationClosedWithTitle:(NSString *)title{
    
    for (NSString *str in _notiTitles) {
        if ([str isEqualToString:title]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - init
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"DeadLineNotification"];
    }
    return _titles;
}

-(void)setNotiTitles:(NSMutableArray *)notiTitles{
    _notiTitles = notiTitles;
}

@end
