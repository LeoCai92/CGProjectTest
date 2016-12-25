//
//  CGTransitionViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 9/23/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGTransitionViewController.h"
#import "Masonry.h"
#import "CEReversibleAnimationController.h"
#import "CECubeAnimationController.h"
#import "CECardsAnimationController.h"
#import "CEVerticalSwipeInteractionController.h"
#import "MKPullCloseControllerAnimation.h"

@interface CGTransitionViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIButton *naviBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *storyBoardID;
@property (nonatomic, strong) CEReversibleAnimationController *reversibleAnimation;
@property (nonatomic, strong) CEBaseInteractionController *baseInteractionAnimation;
@property (nonatomic, strong) MKPullCloseControllerAnimation *pullCloseAnimation;
@end

@implementation CGTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 开启自定义动画
    [self openCustomAnimation];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self initNaviBar];
    
}

- (void)dealloc{
    // 非交互式转场动画
    _reversibleAnimation = nil;
    // 交互式转场动画
    _baseInteractionAnimation = nil;
}

#pragma mark - init view
-(void)initNaviBar{
    [self.view addSubview:self.naviBar];
    if (_baseInteractionAnimation) {
        self.naviBar.enabled = NO;
    }
}

#pragma mark - lazy subviews
-(UIButton *)naviBar{
    if (!_naviBar) {
        _naviBar = [UIButton new];
        [self.view addSubview:_naviBar];
        
        [_naviBar setTitle:@"Dismiss" forState:UIControlStateNormal];
        _naviBar.backgroundColor = [UIColor orangeColor];
        [_naviBar addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(64.f);
        }];
        
    }
    return _naviBar;
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
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *Animation = [UIStoryboard storyboardWithName:@"Animation" bundle:nil];
    UIViewController *vc = [Animation instantiateViewControllerWithIdentifier:self.storyBoardID[indexPath.row]];
    vc.title = _titles[indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - init
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"CGModalTransition",
                    @"CGTransitionDemo",
                    @"TabBarViewController",
                    @"WXSTransition"];
    }
    return _titles;
}

-(NSArray *)storyBoardID{
    if (!_storyBoardID) {
        _storyBoardID = @[@"CGModalTransitionController",
                          @"NavigationController",
                          @"TabBarViewController",
                          @"CGWXSTransitionNavigationController"];
    }
    return _storyBoardID;
}

#pragma mark - CustomAnimation
- (void)openCustomAnimation{
    self.transitioningDelegate = self;
    
    // 非交互式转场动画
//    _reversibleAnimation = [[CECardsAnimationController alloc]init];
    _pullCloseAnimation = [MKPullCloseControllerAnimation new];
    
    // 交互式转场动画
    _baseInteractionAnimation = [[CEVerticalSwipeInteractionController alloc]init];
    
    
    // UIViewControllerTransitioningDelegate
    // UIViewControllerInteractiveTransitioning
    // UIViewControllerContextTransitioning
    // UIPercentDrivenInteractiveTransition
}

#pragma mark - NonInteractiveAnimation
// Presentations
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    NSLog(@"--------presenting------->%@",presenting);
    NSLog(@"--------presented-------->%@",presented);
    NSLog(@"--------source-------->%@",source);
    
    //3、如果存在交互式转场动画，给控制器设置交互手势
    if (self.transitioningDelegate && _baseInteractionAnimation) {
        [_baseInteractionAnimation wireToViewController:presented forOperation:CEInteractionOperationDismiss];
    }

    //1 使用系统默认动画效果
//    presented.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    return nil;//1-1 如果返回值为“nil”则使用系统默认的转场动画
    return _pullCloseAnimation;//2 此处包含一个自定义的动画对象
    
}

// Dismissals
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    NSLog(@"--------dismissed-------->%@",dismissed);
    
    _pullCloseAnimation.reverse = YES;
    return _pullCloseAnimation;
    
}

#pragma mark - InteractiveAnimation
// Presentations
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{

    
    return _baseInteractionAnimation.interactionInProgress?_baseInteractionAnimation:nil;
}

// Dismissals
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    _pullCloseAnimation.reverse = YES;
    return _baseInteractionAnimation;
}

#pragma mark - dismiss
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
