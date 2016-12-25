//
//  CGScaleHeadViewViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/23/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGScaleHeadViewViewController.h"

//获取设备的物理高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define kHeadViewHeight 150.f+50.f
#define kRows 20

@interface CGScaleHeadViewViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *headImageView;
@end

@implementation CGScaleHeadViewViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    
    [self initNaviBarAppearance];
    
    [self initTableView];
    
    [self initHeadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init subviews
-(void)initNaviBarAppearance{
    self.title = @"";
    UINavigationBar *appearance = self.navigationController.navigationBar;
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [appearance setTitleTextAttributes:dictionary];
    //设置阴影为透明（去除下面的阴影线）
    [appearance setShadowImage:[UIImage new]];
    //设置返回等功能按钮为白色
//    [appearance setTintColor:[UIColor whiteColor]];
    //隐藏返回文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [appearance setBackgroundImage:[UIImage new]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:[UIImage new]];
}


-(void)initTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
}

-(void)initHeadView{
    UIView *view = [[UIView alloc] initWithFrame:self.headImageView.frame];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = view;
    [self.view insertSubview:self.headImageView belowSubview:self.tableView];
}

#pragma mark - lazy subviews
-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadViewHeight)];
        _headImageView.image = [UIImage imageNamed:@"head-leaf.jpg"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.backgroundColor = [UIColor orangeColor];
        _headImageView.clipsToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadImageView:)];
        [_headImageView addGestureRecognizer:tap];
    }
    return _headImageView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return kRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageView.image = [UIImage imageNamed:@"green_tree_environment"];
    cell.textLabel.text = [NSString stringWithFormat:@"tree  %zd",indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return;
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%f",y);
    CGRect frame = _headImageView.frame;
    if (y <= 0.f) {
        frame.origin.y = 0;
        frame.size.height = -y+kHeadViewHeight;
        self.tableView.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kHeadViewHeight - scrollView.contentOffset.y+20);
        _headImageView.frame = frame;
        [self initNaviBarAppearance];
    }else{
        frame.origin.y = -y;
        frame.size.height = kHeadViewHeight;
        _headImageView.frame = frame;
        if (y >= 64.f) {// 显示导航栏
            UINavigationBar *navigationBar = self.navigationController.navigationBar;
            [navigationBar setBackgroundImage:nil
                               forBarPosition:UIBarPositionAny
                                   barMetrics:UIBarMetricsDefault];
            [navigationBar setShadowImage:[UIImage new]];
            self.title = @"CGScaleHeadView";
        }
    }
}

-(void)tapHeadImageView:(UITapGestureRecognizer *)sender{
    NSLog(@"tabHeadImageView");
}

@end
