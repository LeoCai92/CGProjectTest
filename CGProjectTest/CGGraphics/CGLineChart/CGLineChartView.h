//
//  CGLineChartView.h
//  CGProjectTest
//
//  Created by LeoCai on 10/18/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLineChartPoint.h"

@interface CGLineChartView : UIView

/**
 *  坐标点集合
 */
@property (nonatomic, strong) NSArray<CGLineChartPoint *> *dataSource;

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 *  线宽
 */
@property (nonatomic, assign) CGFloat lineWidth;

@end
