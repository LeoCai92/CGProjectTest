//
//  CGScaleAnimationViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/30/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGScaleAnimationViewController.h"
#import "Masonry.h"

@interface CGScaleAnimationViewController ()
@property (nonatomic, strong) UIButton *reducingButton;
@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, strong) UILabel *scaleView;
@property (nonatomic, assign) CGFloat scacle;
@property (strong, nonatomic) UISwitch *isHeartBeatSwitch;
@property (assign, nonatomic) BOOL isHeartBeat;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CGScaleAnimationViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNaviBar];
    
    [self.view addSubview:self.scaleView];
    [self.view addSubview:self.reducingButton];
    [self.view addSubview:self.growingButton];
}

#pragma mark - init views
-(UISwitch *)isHeartBeatSwitch{
    if (!_isHeartBeatSwitch) {
        _isHeartBeatSwitch = [UISwitch new];
        [_isHeartBeatSwitch addTarget:self action:@selector(isHeartBeatCell:) forControlEvents:UIControlEventValueChanged];
    }
    return _isHeartBeatSwitch;
}

-(void)initNaviBar{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.isHeartBeatSwitch];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(UIButton *)reducingButton{
    if (!_reducingButton) {
        _reducingButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _reducingButton.tag = CGReducingButton;
        [_reducingButton setTitle:@"点我缩小" forState:UIControlStateNormal];
        
        [_reducingButton addTarget:self action:@selector(onGrowButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_reducingButton];
        
        [_reducingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY).offset(-20.f);
            make.width.mas_equalTo(100.f);
            make.height.mas_equalTo(50.f);
        }];
        
    }
    return _reducingButton;
}

-(UIButton *)growingButton{
    if (!_growingButton) {
        _growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _growingButton.tag = CGGrowingButton;
        [_growingButton setTitle:@"点我放大" forState:UIControlStateNormal];
        
        [_growingButton addTarget:self action:@selector(onGrowButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_growingButton];
        
        [_growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY).offset(20.f);
            make.width.mas_equalTo(100.f);
            make.height.mas_equalTo(50.f);
        }];

    }
    return _growingButton;
}

-(UIView *)scaleView{
    if (!_scaleView) {
        _scaleView = [UILabel new];
        _scaleView.layer.borderColor = UIColor.greenColor.CGColor;
        _scaleView.layer.borderWidth = 3;
        _scaleView.text = @"大家好";
        _scaleView.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_scaleView];
        self.scacle = 1.0;
        
        [_scaleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            // 初始宽、高为100
            make.width.height.mas_equalTo(100.f);
            // 最大放大到整个view
            make.width.height.lessThanOrEqualTo(self.view);
        }];
    }
    return _scaleView;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(heartBeat) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - updateViewConstraints
- (void)updateViewConstraints {//重写该方法
    [super updateViewConstraints];
    
    _scaleView.font = [UIFont systemFontOfSize:20*self.scacle];
    _scaleView.textAlignment = NSTextAlignmentCenter;
    [self.scaleView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(100 * self.scacle);//更新约束
    }];
    
}

- (void)onGrowButtonTaped:(UIButton *)sender {
    if (sender) {
        if (sender.tag == CGReducingButton) {
            if (self.scacle > 1.0) {
                self.scacle -= 0.5;
            }
        }else if (sender.tag == CGGrowingButton){
            self.scacle += 0.5;
        }
    }
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - events
-(void)isHeartBeatCell:(UISwitch *)sender{
    _isHeartBeat = sender.isOn;
    if (sender.on) {
        [self.timer fire];
        self.reducingButton.hidden = YES;
        self.growingButton.hidden = YES;
    }else{
        [self.timer invalidate];
        self.timer = nil;
        self.reducingButton.hidden = NO;
        self.growingButton.hidden = NO;
        
        self.scacle = 1.0;
        [self onGrowButtonTaped:nil];
    }
}

static CGFloat scaleSize = 1.f;
// 心跳
-(void)heartBeat{
    if (scaleSize == 1.5) {
        self.scacle = 1.0;
        scaleSize = 1.0;
    }else{
        self.scacle = 1.5;
        scaleSize = 1.5;
    }
    
    [self onGrowButtonTaped:nil];
}

@end
