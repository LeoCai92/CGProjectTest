//
//  CGCoordinatesViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/27/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGCoordinatesViewController.h"
#import "CGCurveView.h"
#import "Masonry.h"
#import "CGMarco.h"

@interface CGCoordinatesViewController ()
@property (strong, nonatomic) CGCurveView *curveView;
@end

@implementation CGCoordinatesViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.curveView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy subviews
-(CGCurveView *)curveView{
    if (!_curveView) {
        _curveView = [CGCurveView new];
        [self.view addSubview:_curveView];
        
        // style
        _curveView.backgroundColor = [UIColor lightGrayColor];
        UIColor *lineColor = [UIColor colorWithRed:0 green:210.f/255.f blue:1.f alpha:1.f];
        _curveView.lineColor = lineColor;
         _curveView.axisWidth = 1.f;
        CGFloat padding = 50.f;
        _curveView.yAxisBottomPadding = padding;
        _curveView.axisOrigin = CGPointMake(padding, 350.f);
        _curveView.axisSize = CGSizeMake(SCREEN_WIDTH - padding - 8 , 270.f);
        
       
        // layout
        [_curveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            CGFloat paddding = 400.f;
            make.height.mas_equalTo(paddding);
            make.width.mas_equalTo(paddding);
        }];
    }
    return _curveView;
}


@end
