//
//  CGAutoLayoutViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/12/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGAutoLayoutViewController.h"

@interface CGAutoLayoutViewController ()
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@property (strong, nonatomic) UILabel *label3;
@end

@implementation CGAutoLayoutViewController

CGFloat padding = 10;
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark - init subviews
-(void)initSubviews{
    
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    
    [self layoutLabel1];
    [self layoutLabel2];
    [self layoutLabel3];
}

#pragma mark - lazy subviews
-(UILabel *)label1{
    if (!_label1) {
        _label1 = [UILabel new];
        _label1.text = @"label1";
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.backgroundColor = [UIColor orangeColor];
    
    }
    return _label1;
}

-(void)layoutLabel1{
    // 禁止将 AutoresizingMask 转换为 Constraints
    _label1.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_label2 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [self.view addConstraint:widthConstraint];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:115];
    [_label1 addConstraint:heightConstraint];
    // 添加 left 约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    [self.view addConstraint:leftConstraint];
    // 添加 right 约束
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_label2 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10];
    [self.view addConstraint:rightConstraint];
    // 添加 top 约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64];
    [self.view addConstraint:topConstraint];
}

-(UILabel *)label2{
    if (!_label2) {
        _label2 = [UILabel new];
        _label2.text = @"label2";
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.backgroundColor = [UIColor brownColor];
    }
    return _label2;
}

-(void)layoutLabel2{
    // 禁止将 AutoresizingMask 转换为 Constraints
    _label2.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_label2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_label1 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [self.view addConstraint:widthConstraint];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_label2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:115];
    [_label2 addConstraint:heightConstraint];
    // 添加 right 约束
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_label2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
    [self.view addConstraint:rightConstraint];
    // 添加 top 约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64];
    [self.view addConstraint:topConstraint];
}

-(UILabel *)label3{
    if (!_label3) {
        _label3 = [UILabel new];
        _label3.text = @"label3";
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.backgroundColor = [UIColor purpleColor];
    }
    return _label3;
}

-(void)layoutLabel3{
    // 禁止将 AutoresizingMask 转换为 Constraints
    _label3.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 添加 left 约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_label3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    [self.view addConstraint:leftConstraint];
    // 添加 right 约束
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_label3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
    [self.view addConstraint:rightConstraint];
    // 添加 top 约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_label3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_label1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10];
    [self.view addConstraint:topConstraint];
    // 添加 bottom 约束
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_label3 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10];
    [self.view addConstraint:bottomConstraint];
}

@end
