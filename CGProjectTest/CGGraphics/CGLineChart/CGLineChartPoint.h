//
//  CGLineChartPoint.h
//  CGProjectTest
//
//  Created by LeoCai on 10/18/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CGLineChartPoint : NSObject

@property (nonatomic, assign)  CGFloat x;
@property (nonatomic, assign)  CGFloat y;

/**
    点显示的颜色
 */
@property (nonatomic, strong) UIColor *dotColor;
@end
