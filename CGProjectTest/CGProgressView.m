//
//  CGProgressView.m
//  CGProgressView
//
//  Created by LeoCai on 8/23/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGProgressView.h"

#define CornerRadius 6.f

@interface CGProgressView()
@property (strong, nonatomic) CALayer *progressLayer;
@property (assign, nonatomic) CGFloat currentViewWidth;
@end

@implementation CGProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = CornerRadius;
        self.progressLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.layer addSublayer:self.progressLayer];
        //储存当前view的宽度值
        self.currentViewWidth = frame.size.width;
    }
    return self;
}

#pragma mark - lazy subviews
-(CALayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [CALayer layer];
        _progressLayer.cornerRadius = CornerRadius;
        _progressLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _progressLayer;
}

#pragma mark - 重写setter,getter方法

@synthesize progress = _progress;
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (progress <= 0) {
        self.progressLayer.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    }else if (progress <= 1) {
        self.progressLayer.frame = CGRectMake(0, 0, progress *self.currentViewWidth, self.frame.size.height);
    }else {
        self.progressLayer.frame = CGRectMake(0, 0, self.currentViewWidth, self.frame.size.height);
    }
}

- (CGFloat)progress {
    return _progress;
}

@synthesize progressColor = _progressColor;
- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.backgroundColor = progressColor.CGColor;
}

- (UIColor *)progressColor {
    return _progressColor;
}

@end
