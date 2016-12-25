//
//  CGCoordinatesView.m
//  CGProjectTest
//
//  Created by LeoCai on 8/27/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGCoordinatesView.h"
@interface CGCoordinatesView()


@end

@implementation CGCoordinatesView
/*
- (void)drawRect:(CGRect)rect {
    UIColor *backGroundColor = self.backgroundColor;
    
    CGRect  bounds = self.bounds; //长和宽都为200.
    
    CGContextRef context =UIGraphicsGetCurrentContext(); //获取当前的上下文，也就是Context
    CGContextSaveGState(context); //保存当前的context
    CGContextSetFillColorWithColor(context, backGroundColor.CGColor);//设置背景颜色。偏黑色。
    CGContextFillRect(context, rect);// 填充矩形区域。
    CGContextRestoreGState(context); //恢复context
    
    float startX = bounds.origin.x;//开始点横坐标
    float startY = bounds.origin.y + bounds.size.height/2;//从中间位置开始画。
    

    float pointInterval = bounds.size.width /10;//一共画10个点。
    
    
    CGContextSaveGState(context);//保存当前的context
    CGContextSetAllowsAntialiasing(context,true);//Antialiasing 设置为true，防止在拐点处出现模糊。
    CGContextSetLineWidth(context,0.8f);//线的宽度。
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);//画笔的颜色设置。
    
    float startX_temp = startX;
    float startY_temp = startY;
    for(int i = 0; i < 9; i++) {
        CGContextMoveToPoint(context, startX_temp, startY_temp);
        if(i %2 == 0) {//i 为偶数的时候，Y坐标在中间位置。
            startY_temp = startY + 0;
        }else {//i 为奇数的时候，Y坐标在StartY－10处。
            startY_temp = startY - 10;
        }
        startX_temp = startX + (i+1) * pointInterval;
        CGContextAddLineToPoint(context, startX_temp, startY_temp);//连接点。
    }
 
    CGContextStrokePath(context);//开始绘制
    CGContextRestoreGState(context);//恢复context
    
}
*/

- (void)drawRect:(CGRect)rect{
    
    // 绘制X轴
    [self createXAxis:rect];
    
    // 绘制Y轴
    [self createYAxis:rect];
    
    // 绘制虚线
    [self setLineDash:rect];
}

#pragma mark - create
/*
 * 绘制X轴
 */
-(void)createXAxis:(CGRect)rect{
    /*******画出坐标轴********/
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //1、style
    CGContextSetLineWidth(context, _axisWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
//    CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
    
    //2、绘制X轴
    CGContextMoveToPoint(context, _axisOrigin.x, _axisOrigin.y);
    CGContextAddLineToPoint(context, _axisOrigin.x+_axisSize.width,_axisOrigin.y);
    
    CGContextStrokePath(context);
}

/*
 * 绘制Y轴
 */
-(void)createYAxis:(CGRect)rect{
    /*******画出坐标轴********/
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //1、style
    CGContextSetLineWidth(context, _axisWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
//    CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
    
    //2、绘制Y轴
    CGContextMoveToPoint(context, _axisOrigin.x, rect.size.height-_axisSize.height - _yAxisBottomPadding);
    CGContextAddLineToPoint(context, _axisOrigin.x, rect.size.height - _yAxisBottomPadding);
    
    CGContextStrokePath(context);
}

/*
 * 绘制虚线
 */
-(void)setLineDash:(CGRect)rect{
    
}

#pragma mark - setter
-(void)configureLineColor:(UIColor *)lineColor{
    self.lineColor = lineColor;
}


@end
