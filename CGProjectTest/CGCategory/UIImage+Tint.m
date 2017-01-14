//
//  UIImage+Tint.m
//  CGProjectTest
//
//  Created by LeoCai on 13/1/2017.
//  Copyright © 2017 LeoCai. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}


- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    // 开启image上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    // 渲染设置
    [tintColor setFill];
    
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    // 设置blendMode绘制
    [self drawInRect:bounds blendMode:blendMode alpha:1.f];
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.f];
    }
    
    // 获取新的Image
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
@end
