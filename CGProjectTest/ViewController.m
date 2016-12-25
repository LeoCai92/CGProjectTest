//
//  ViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/5/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "ViewController.h"
#import "MKPullCloseViewController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate,UIPopoverPresentationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *storyBoardID;
@property (nonatomic, strong) NSArray *filterArray;
@end

@implementation ViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self initNaviBarStyle];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

#pragma mark - NaviBarStyle
- (void)initNaviBarStyle{
    // 添加一个右边“+”
    UIBarButtonItem *rightAddButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightAddButtonEvent:)];
    self.navigationItem.rightBarButtonItem = rightAddButton;
}

#pragma mark - DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

#pragma mark - Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *Main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSString *storyBoardID = self.storyBoardID[indexPath.row];
    
    UIViewController *vc;
    if ([@"MKPullCloseTrasintionController" isEqualToString:storyBoardID]) {
        MKPullCloseViewController *pullCloseVC = [MKPullCloseViewController new];
        pullCloseVC.view.backgroundColor = [UIColor orangeColor];
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor orangeColor];
        tableView.alpha = 0.5f;
        [pullCloseVC.view addSubview:tableView];
//        UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:pullCloseVC];
        vc = pullCloseVC;
    }else{
        vc = [Main instantiateViewControllerWithIdentifier:storyBoardID];
    }
    
    vc.title = _titles[indexPath.row];
    if ([self isInFilterArrayWithStoryBoardID:storyBoardID]) {
        // 普通ViewController只有采用present方法，才能表现出动画
//        vc.modalPresentationStyle = UIModalPresentationPageSheet;
//        vc.preferredContentSize = CGSizeMake(200, 200);
        
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 实现该代理方法,返回UIModalPresentationNone值,可以在iPhone设备实现popover效果
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;//不适配(不区分ipad或iPhone)
}

#pragma mark - DataSource
// 导航栏显示的标题
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"AutoLayout+IB",
                    @"AutoLayout+Masonry",
                    @"原生AutoLayout",
                    @"CGProgressView",
                    @"CGScaleHeadView",
                    @"CGScaleHeadViewMasonry",
                    @"CGAnimation",
                    @"CGLeftIntricRightSlideTableView",
                    @"CGFolderTableViewCell",
                    @"CGMasonryExpandCell",
                    @"CGKeyboards",
                    @"CGCoordinates",
                    @"CGNotification",
                    @"CGTransition",
                    @"MKPullCloseTrasintionController",
                    @"CGGraphics"];
    }
    return _titles;
}

// 点击要跳转的相应控制器在UIStoryBoard中的ID
-(NSArray *)storyBoardID{
    if (!_storyBoardID) {
        _storyBoardID = @[@"CGCGAutoLayoutIBViewController",
                          @"CGAutoLayoutMasonryViewController",
                          @"CGAutoLayoutViewController",
                          @"CGProgressViewController",
                          @"CGScaleHeadViewViewController",
                          @"CGScaleHeadViewMasonryViewController",
                          @"CGAnimationViewController",
                          @"CGLeftIntricRightSlideViewController",
                          @"CGFolderTableViewCellViewController",
                          @"CGMasonryExpandCellViewController",
                          @"CGKeyboardsViewController",
                          @"CGCoordinatesViewController",
                          @"CGNotificationViewController",
                          @"CGTransitionViewController",
                          @"MKPullCloseTrasintionController",
                          @"CGGraphicsViewController"];
    }
    return _storyBoardID;
}

// 过滤数组，指定哪些控制器是以“present”方式展现
-(NSArray *)filterArray{
    if (!_filterArray) {
        _filterArray = @[@"CGTransitionViewController",
                         @"MKPullCloseTrasintionController"];
    }
    return _filterArray;
}

-(BOOL)isInFilterArrayWithStoryBoardID:(NSString *)storyBoardID{
    for (NSString *str in self.filterArray) {
        if ([str isEqualToString:storyBoardID]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Event
- (void)rightAddButtonEvent:(id)sender{
//    UIViewController *vc = [UIViewController new];
    // 0、获取CGTransitionViewController
    UIStoryboard *Main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSString *storyBoardID = @"CGTransitionViewController";
    UIViewController *vc = [Main instantiateViewControllerWithIdentifier:storyBoardID];
    vc.title = @"CGTransition";
//    vc.view.backgroundColor = [UIColor orangeColor];
    
    // 1、设置表现方式，modalPresentationStyle适用于iPad
    vc.modalPresentationStyle = UIModalPresentationPopover;
    
    // 2、设置表现样式
    vc.preferredContentSize = CGSizeMake(150, 300);
    
    // 3、UIModalPresentationPopover的锚点可以是其他的View
    vc.popoverPresentationController.barButtonItem = sender;
    // 3-1、设置popoverPresentationController的sourceRect和sourceView属性
    vc.popoverPresentationController.sourceRect = self.view.bounds;
//    vc.popoverPresentationController.sourceView = sender;
   
    // 4、设置代理
    vc.popoverPresentationController.delegate = self;
    
    // 5、弹出
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
