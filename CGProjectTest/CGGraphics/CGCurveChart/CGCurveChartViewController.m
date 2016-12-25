//
//  CGCurveChartViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 10/18/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGCurveChartViewController.h"
#import "Masonry.h"
#import "CGCurveChartView.h"
#import "CGLineChartPoint.h"

#define kCurveChartWidth 300.f
@interface CGCurveChartViewController ()
@property (nonatomic, strong) CGCurveChartView *curveChart;
@end

@implementation CGCurveChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCurveChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - displayView
- (void)showCurveChart{
    // 构造数据源
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        CGLineChartPoint *point = [CGLineChartPoint new];
        point.x = i*(kCurveChartWidth/10);
        point.y = 200;
        
        [array addObject:point];
    }
    self.curveChart.dataSource = [NSArray arrayWithArray:array];
    self.curveChart.lineWidth = 1.f;
    self.curveChart.lineColor = [UIColor orangeColor];
    [self.view addSubview:self.curveChart];
}

#pragma mark - lazyView
- (CGCurveChartView *)curveChart{
    if (!_curveChart) {
        _curveChart = [CGCurveChartView new];
        [self.view addSubview:_curveChart];
        
        _curveChart.backgroundColor = [UIColor clearColor];
        
        [_curveChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            
            make.width.height.mas_equalTo(kCurveChartWidth);
        }];
    }
    return _curveChart;
}


@end
