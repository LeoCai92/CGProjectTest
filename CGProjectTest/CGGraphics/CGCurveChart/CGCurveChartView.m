//
//  CGCurveChartView.m
//  CGProjectTest
//
//  Created by LeoCai on 10/18/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGCurveChartView.h"

@interface CGCurveChartView()
@property (nonatomic, strong) NSMutableArray *pathsArray;
@end

@implementation CGCurveChartView

#pragma mark - lifecycle
- (void)drawRect:(CGRect)rect {
    
    if([self isDataSourceEmptyOrLessOnePoint]){
        return;
    }else{
        // 开始绘制曲线
        CGLineChartPoint *startPoint;
        CGLineChartPoint *endPoint;
        CGLineChartPoint *controlPoint;
        _pathsArray = [NSMutableArray arrayWithCapacity:_dataSource.count];
        int ratio = -1;
        for (int i = 0; i < _dataSource.count - 1; i++) {
            startPoint = _dataSource[i];
            endPoint   = _dataSource[i+1];
            controlPoint = [CGLineChartPoint new];
            controlPoint.x = (startPoint.x+endPoint.x)/2;
            ratio = -1 * ratio;
            controlPoint.y = (startPoint.y+endPoint.y)/2+100*ratio;
            
            // note：iOS的View坐标系和代数中的坐标系方向不一致，所以对于Point要转化
            [self drawCurveFromStartPoint:startPoint
                               toEndPoint:endPoint
                          withcontrolPoint:controlPoint];
        }
    }
}

#pragma mark - drawCurve
// 绘制曲线
- (void)drawCurveFromStartPoint:(CGLineChartPoint *)startPoint
                     toEndPoint:(CGLineChartPoint *)endPoint
                withcontrolPoint:(CGLineChartPoint *)controlPoint{
    // 1、系统绘制曲线
//    [self systemDrawCurveFromStartPoint:startPoint
//                             toEndPoint:endPoint
//                        withcontrolPoint:controlPoint];
    
    // 2、贝塞尔曲线绘制
    [self bezierPathDrawCurveFromStartPoint:startPoint
                                 toEndPoint:endPoint
                           withcontrolPoint:controlPoint];
}

// 系统曲线绘制
- (void)systemDrawCurveFromStartPoint:(CGLineChartPoint *)startPoint
                                   toEndPoint:(CGLineChartPoint *)endPoint
                              withcontrolPoint:(CGLineChartPoint *)controlPoint{
    
    // 1、获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 3、设置绘制的圆点
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    /*
     // 2、描述路径，系统会自动给成路径,自动给添加到上下文
     //    CGMutablePathRef path = CGPathCreateMutable();
    //    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);

//    // 3-1、设置绘制的起点和终点
//    CGPathAddArcToPoint(path, NULL, controlPoint.x, controlPoint.y/2, endPoint.x, endPoint.y, 10.f);
    // 3-2\画圆弧
    // x/y 圆心
    // radius 半径
    // startAngle 开始的弧度
    // endAngle 结束的弧度
    // clockwise 画圆弧的方向 (0 顺时针, 1 逆时针)
//    CGFloat radius = (endPoint.x - startPoint.x)/2;
//    CGContextAddArc(ctx, controlPoint.x, controlPoint.y, radius, -M_PI, 0, 0);
     //    CGContextAddPath(ctx, path);
    */
    
    // 3-3、线宽
    if (!_lineWidth) {
        _lineWidth = 1.f;// 默认线宽
    }
     
    CGContextSetLineWidth(ctx, _lineWidth);
    
    // 4、开始渲染上下文
    CGContextAddQuadCurveToPoint(ctx, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);
    // 5-1、线条颜色
    [[UIColor blackColor] set];
    CGContextStrokePath(ctx);
    // 5-2、填充色
    [_lineColor set];
    CGContextFillPath(ctx);// 填充
    CGContextClosePath(ctx);
    
}

// 贝塞尔曲线绘制
- (void)bezierPathDrawCurveFromStartPoint:(CGLineChartPoint *)startPoint
                           toEndPoint:(CGLineChartPoint *)endPoint
                      withcontrolPoint:(CGLineChartPoint *)controlPoint{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [_pathsArray addObject:path];// 保存BezierPath
    [path moveToPoint:[self pointFromLineChartPoint:startPoint]];
    [path addQuadCurveToPoint:[self pointFromLineChartPoint:endPoint]
                 controlPoint:[self pointFromLineChartPoint:controlPoint]];
    [path setLineWidth:_lineWidth];
    
    [[UIColor blackColor] set];// 线条色
    [path stroke];// 线条绘制
    
    [_lineColor set];// 填充色
    [path fill];// 颜色填充
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

#pragma mark - event
// 使用touchesBegan来捕获落点
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if ([self isBezierPathsContainPoint:point]) {
        NSString *msg = [NSString stringWithFormat:@"%zd区",(int)point.x/30];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"区域" message:msg delegate:self
                                                           cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"point:%@",NSStringFromCGPoint(point));
    }
}

// pathsArray用来存放闭合路径，用于判断一个点是否在某个闭合路径中
- (BOOL)isBezierPathsContainPoint:(CGPoint)point{
    for (UIBezierPath *path in _pathsArray) {
        if ([path containsPoint:point]) {
            return YES;
        }
    }
    return NO;
}

@end
