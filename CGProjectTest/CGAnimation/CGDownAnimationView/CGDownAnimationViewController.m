//
//  CGDownAnimationViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 9/7/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGDownAnimationViewController.h"
#import "Masonry.h"

@interface CGDownAnimationViewController ()
@property (strong, nonatomic) UILabel *animationView;
@property (assign, nonatomic) CGFloat viewHeight;
@property (assign, nonatomic) BOOL isAnimating;
@property (strong, nonatomic) UISwitch *isFolderSwitch;
@end

@implementation CGDownAnimationViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewHeight = 300.f;
    
    [self initNaviBar];
    
    [self.view addSubview:self.animationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - init views
-(UILabel *)animationView{
    if (!_animationView) {
        _animationView = [UILabel new];
        [self.view addSubview:_animationView];
        
        _animationView.backgroundColor = [UIColor orangeColor];
        _animationView.alpha = 0.35;
        _animationView.text = @"新公告";
        _animationView.textAlignment = NSTextAlignmentCenter;
        
        [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(0);
            make.top.mas_equalTo(self.view.mas_top).with.offset(-self.viewHeight);
            make.width.equalTo(@286);
            make.height.equalTo(@(self.viewHeight));
        }];

    }
    return _animationView;
}

-(UISwitch *)isFolderSwitch{
    if (!_isFolderSwitch) {
        _isFolderSwitch = [UISwitch new];
        [_isFolderSwitch addTarget:self action:@selector(isAnimation:)
                  forControlEvents:UIControlEventValueChanged];
    }
    return _isFolderSwitch;
}

-(void)initNaviBar{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:
                                  self.isFolderSwitch];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 
- (void)startAnimationWithOffset:(CGFloat)offset
{
    self.isAnimating = YES;
    [self.animationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(offset);
    }];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.33f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (offset > 0) {
            [self upAnimationViewWithOffset:offset];
        }
    }];
}

- (void)upAnimationViewWithOffset:(CGFloat)offset
{
    [self.animationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(-20);
    }];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.33f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self downAnimationViewWithOffset:offset];
    }];
}

- (void)downAnimationViewWithOffset:(CGFloat)offset
{
    [self.animationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(offset);
    }];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.33f animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - events
- (void)isAnimation:(UISwitch *)sender{
    
    if (sender.on) {
        //todo 开始动画
        [self startAnimationWithOffset:64.f];
        NSLog(@"Start Animation");
    }else{
        //todo 结束动画
        [self startAnimationWithOffset:-self.viewHeight];
        NSLog(@"Stop Animation");
    }
}


@end
