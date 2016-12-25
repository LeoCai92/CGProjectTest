//
//  CGScaleHeadViewMasonryViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/30/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGScaleHeadViewMasonryViewController.h"
#import "Masonry.h"


static CGFloat ParallaxHeaderHeight = 150.f+50.f;
static NSString *CellIdentifier = @"Cell";

@interface CGScaleHeadViewMasonryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *parallaxHeaderView;
@property (strong, nonatomic) MASConstraint *parallaxHeaderHeightConstraint;
@end

@implementation CGScaleHeadViewMasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNaviBarAppearance];
    
    [self configTableView];

    [self initView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

// 直接在scrollViewDidScroll:刷新
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if (_parallaxHeaderHeightConstraint) {
        if (scrollView.contentOffset.y < -ParallaxHeaderHeight) {
            _parallaxHeaderHeightConstraint.equalTo(@(- scrollView.contentOffset.y));
            [self initNaviBarAppearance];
        } else {
            _parallaxHeaderHeightConstraint.equalTo(@(ParallaxHeaderHeight));
            if (scrollView.contentOffset.y >= -64.f) {// 显示导航栏
                [UIView animateWithDuration:0.3 animations:^{
                    UINavigationBar *navigationBar = self.navigationController.navigationBar;
                    [navigationBar setBackgroundImage:nil
                                       forBarPosition:UIBarPositionAny
                                           barMetrics:UIBarMetricsDefault];
                    [navigationBar setShadowImage:[UIImage new]];
                    self.title = @"CGScaleHeadViewMasonry";

                }];
            }
        }
    }
}

#pragma mark - Private methods

- (void)configTableView {
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(ParallaxHeaderHeight, 0, 0, 0);
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)initView {
    _parallaxHeaderView = [UIImageView new];
    [self.view insertSubview:_parallaxHeaderView belowSubview:self.tableView];
    _parallaxHeaderView.layer.masksToBounds = YES;
    _parallaxHeaderView.contentMode = UIViewContentModeScaleAspectFill;
    _parallaxHeaderView.image = [UIImage imageNamed:@"head-leaf"];
    
    [_parallaxHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        _parallaxHeaderHeightConstraint = make.height.equalTo(@(ParallaxHeaderHeight));
    }];

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

@end
