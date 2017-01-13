//
//  UIImage+Tint.h
//  CGProjectTest
//
//  Created by LeoCai on 13/1/2017.
//  Copyright © 2017 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

/**
 默认的图像blend方法

 @param tintColor UIColor
 @return UIImage
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

/**
 保留灰度的blend方法

 @param tintColor UIColor
 @return UIImage
 */
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

@end
