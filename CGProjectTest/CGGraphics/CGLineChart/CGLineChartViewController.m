//
//  CGLineChartViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 10/18/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGLineChartViewController.h"
#import "CGLineChartView.h"
#import "Masonry.h"

#define kLineChartWidth 300.f
@interface CGLineChartViewController ()
@property (nonatomic, strong) CGLineChartView *lineChart;
@end

@implementation CGLineChartViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLineChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - displyView
- (void)showLineChart{
    // 构造数据源
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        CGLineChartPoint *point = [CGLineChartPoint new];
        point.x = i*(kLineChartWidth/10);
        point.y = -(i%2)*20+280;
        
        [array addObject:point];
    }
    self.lineChart.dataSource = [NSArray arrayWithArray:array];
    self.lineChart.lineWidth = 1.f;
    self.lineChart.lineColor = [UIColor orangeColor];
    [self.view addSubview:self.lineChart];
}

#pragma mark - lazyView
- (CGLineChartView *)lineChart{
    if (!_lineChart) {
        _lineChart = [CGLineChartView new];
        [self.view addSubview:_lineChart];
        
        _lineChart.backgroundColor = [UIColor lightGrayColor];
        
        [_lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            
            make.width.height.mas_equalTo(kLineChartWidth);
        }];
    }
    return _lineChart;
}

@end
