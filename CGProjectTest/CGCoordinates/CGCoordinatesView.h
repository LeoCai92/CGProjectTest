//
//  CGCoordinatesView.h
//  CGProjectTest
//
//  Created by LeoCai on 8/27/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCoordinatesView : UIView
/**
 * 设置坐标线的颜色
 */
@property (strong, nonatomic) UIColor *lineColor;
/**
 * 坐标轴线宽
 */
@property (assign, nonatomic) CGFloat axisWidth;
/**
 * 坐标轴原点
 */
@property (assign, nonatomic) CGPoint axisOrigin;
/**
 * 坐标轴长度
 */
@property (assign, nonatomic) CGSize axisSize;
/**
 * Y轴bottomPadding
 */
@property (assign, nonatomic) CGFloat yAxisBottomPadding;
/**
 * 坐标轴data
 */
@property (strong, nonatomic) NSArray *xAxisData;
@property (strong, nonatomic) NSArray *yAxisData;

@end
