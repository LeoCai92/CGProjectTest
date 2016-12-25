//
//  CGLineChartView.m
//  CGProjectTest
//
//  Created by LeoCai on 10/18/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGLineChartView.h"

@implementation CGLineChartView

#pragma mark - lifecycle
- (void)drawRect:(CGRect)rect {
    if ([self isDataSourceEmptyOrLessOnePoint]) {
        return;
    }else{
        // 开始绘制折线
        CGLineChartPoint *startPoint;
        CGLineChartPoint *endPoint;
        for (int i = 0; i < _dataSource.count - 1; i++) {
            startPoint = _dataSource[i];
            endPoint   = _dataSource[i+1];
            // note：iOS的View坐标系和代数中的坐标系方向不一致，所以对于Point要转化
            [self drawLineFromStartPoint:startPoint toEndPoint:endPoint];
        }
    }
}

#pragma mark - drawline
- (void)drawLineFromStartPoint:(CGLineChartPoint *)startPoint
                    toEndPoint:(CGLineChartPoint *)endPoint{
    
    // 1、系统绘制
    [self systemDrawLineFromStartPoint:startPoint toEndPoint:endPoint];
    
    // 2、贝塞尔绘制方法
//    [self bezierPathDrawLineFromStartPoint:startPoint toEndPoint:endPoint];
}

// 系统绘制方法
- (void)systemDrawLineFromStartPoint:(CGLineChartPoint *)startPoint
                          toEndPoint:(CGLineChartPoint *)endPoint{
    // 1、获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2、描述路径，系统会自动给成路径,自动给添加到上下文
//    CGMutablePathRef path = CGPathCreateMutable();
    
    // 3、设置绘制的起点和终点
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    // 3-1、线条和填充物的颜色
    [_lineColor set];
    
    // 3-2、线宽
    if (!_lineWidth) {
        _lineWidth = 1.f;// 默认线宽
    }
    CGContextSetLineWidth(ctx, _lineWidth);
    
    // 4、开始渲染上下文
    CGContextStrokePath(ctx);
    CGContextClosePath(ctx);
}

// 贝塞尔绘制方法
- (void)bezierPathDrawLineFromStartPoint:(CGLineChartPoint *)startPoint
                          toEndPoint:(CGLineChartPoint *)endPoint{
    // 1、描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 1-1、线条的设置
    [_lineColor set];
    
    // 1-2、设置起点和终点
    CGPoint point1 = [self pointFromLineChartPoint:startPoint];
    CGPoint point2 = [self pointFromLineChartPoint:endPoint];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    
    // 2、绘制路径
    [path stroke];
    [path closePath];
}

#pragma mark - util

/**
 
 @return “YES”表示dataSource为空或者只有一个数据源
 */
- (BOOL)isDataSourceEmptyOrLessOnePoint{
    if (!_dataSource) {
        return YES;
    }else if (_dataSource.count <= 1){
        return YES;
    }
    return NO;
}

// CGLineChartPoint to point
- (CGPoint)pointFromLineChartPoint:(CGLineChartPoint *)lineChartPoint{
    CGPoint point;
    point = CGPointMake(lineChartPoint.x, lineChartPoint.y);
    return point;
}

@end
