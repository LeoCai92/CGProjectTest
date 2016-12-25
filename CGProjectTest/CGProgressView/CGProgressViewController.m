//
//  CGProgressViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/23/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGProgressViewController.h"
#import "CGProgressView.h"


@interface CGProgressViewController ()
@property (strong, nonatomic) CGProgressView *progressView;
@end

@implementation CGProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CGProgressView";
    
    [self.view addSubview:self.progressView];
    self.progressView.progress = arc4random()%100/100.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy subviews
-(CGProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[CGProgressView alloc]initWithFrame:CGRectMake(20, 200, 200, 5)];
        _progressView.progressColor = [UIColor orangeColor];
    }
    return _progressView;
}



@end
