//
//  CGAnimationViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/30/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGAnimationViewController.h"

@interface CGAnimationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *storyBoardID;
@property (nonatomic, strong) UIView *testView;
@end

@implementation CGAnimationViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
    UIStoryboard *Animation = [UIStoryboard storyboardWithName:@"Animation" bundle:nil];
    UIViewController *vc = [Animation instantiateViewControllerWithIdentifier:self.storyBoardID[indexPath.row]];
    vc.title = _titles[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - init
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"CGScaleAnimation",
                    @"CGExpandAnimation",
                    @"CGDownAnimation",
                    @"CGLayerSpecialAnimation"];
    }
    return _titles;
}

-(NSArray *)storyBoardID{
    if (!_storyBoardID) {
        _storyBoardID = @[@"CGScaleAnimationViewController",
                          @"CGExpandAnimationViewController",
                          @"CGDownAnimationViewController",
                          @"CGLayerSpecialAnimationViewController"];
    }
    return _storyBoardID;
}

#pragma mark - test
- (void)sampleRotateTest{
    UIView *view = [UIView new];
    view.frame = CGRectMake(50, 150, 200, 200);
    view.backgroundColor = [UIColor orangeColor];
    self.testView = view;
    [self.view addSubview:view];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [view addGestureRecognizer:tapGesture];
    
    
    NSLog(@"view--->bounds:%@",NSStringFromCGRect(view.bounds));
    NSLog(@"layer--->bounds:%@",NSStringFromCGRect(view.layer.bounds));
    
    NSLog(@"view--->center:%@",NSStringFromCGPoint(view.center));
    NSLog(@"layer--->position:%@",NSStringFromCGPoint(view.layer.position));
    NSLog(@"layer--->anchorPoint:%@",NSStringFromCGPoint(view.layer.anchorPoint));
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    // 要注意触发动画
    /*
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2]; //动画时长
    [UIView setAnimationRepeatAutoreverses:YES];
    _testView.transform = CGAffineTransformMakeRotation(M_PI_2);
    NSLog(@"view--->bounds:%@",NSStringFromCGRect(_testView.bounds));
    NSLog(@"layer--->bounds:%@",NSStringFromCGRect(_testView.layer.bounds));
    
    NSLog(@"view--->center:%@",NSStringFromCGPoint(_testView.center));
    NSLog(@"layer--->position:%@",NSStringFromCGPoint(_testView.layer.position));
    NSLog(@"layer--->anchorPoint:%@",NSStringFromCGPoint(_testView.layer.anchorPoint));
    [UIView commitAnimations];
    */
//    [UIView animateWithDuration:0.3 animations:^{
//        _testView.transform = CGAffineTransformMakeRotation(M_PI_2);
//    } completion:^(BOOL finished) {
//        
//        
//    }];
    CGFloat angle = M_PI_2;
    __block int num = 1;
    [UIView animateWithDuration:0.3 delay:0. options:UIViewAnimationOptionCurveLinear animations:^{
        _testView.transform = CGAffineTransformMakeRotation(num * angle);
    } completion:^(BOOL finished) {
        num = -1 * num;
    }];
    /*
    // 创建抖动动画
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI)];//度数转弧度
    
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.3;
    keyAnimaion.repeatCount = MAXFLOAT;
    [self.testView.layer addAnimation:keyAnimaion forKey:nil];
    */
}


@end
