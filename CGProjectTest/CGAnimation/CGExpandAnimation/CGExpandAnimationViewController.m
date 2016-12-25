//
//  CGExpandAnimationViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/31/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGExpandAnimationViewController.h"
#import "Masonry.h"

@interface CGExpandAnimationViewController ()
@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) BOOL isExpanded;
@end

@implementation CGExpandAnimationViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isExpanded = NO;
    [self.view addSubview:self.growingButton];
}

- (void)updateViewConstraints {
    // 这里使用update也是一样的。
    // remake会将之前的全部移除，然后重新添加
    [self.growingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        if (self.isExpanded) {
            make.bottom.mas_equalTo(0);
        } else {
            make.bottom.mas_equalTo(-350);
        }
    }];
    
    [super updateViewConstraints];
}

#pragma maark - lazy sibviews
-(UIButton *)growingButton{
    if (!_growingButton) {
        _growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
        _growingButton.layer.borderColor = UIColor.greenColor.CGColor;
        _growingButton.layer.borderWidth = 3;
        _growingButton.backgroundColor = [UIColor redColor];
        [_growingButton addTarget:self action:@selector(onGrowButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _growingButton;
}

- (void)onGrowButtonTaped:(UIButton *)sender {
    self.isExpanded = !self.isExpanded;
    if (!self.isExpanded) {
        [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
    } else {
        [self.growingButton setTitle:@"点我收起" forState:UIControlStateNormal];
    }
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
//        [self.view layoutIfNeeded];
    }];
}

@end
