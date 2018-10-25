//
//  CGLayerSpecialAnimationViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 25/10/2018.
//  Copyright © 2018 LeoCai. All rights reserved.
//

#import "CGLayerSpecialAnimationViewController.h"

@interface CGLayerSpecialAnimationViewController ()

@end

@implementation CGLayerSpecialAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Show Emitter Layer
    [self setupEmitterLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Layer Animation
- (void)setupEmitterLayer
{
    //添加背景图
    UIImage *bgImage = [UIImage imageNamed:@"franke.jpg"];
    self.view.backgroundColor = [UIColor     colorWithPatternImage:bgImage];
    
    //粒子图层
    CAEmitterLayer *snowLayer = [CAEmitterLayer layer];
    snowLayer.backgroundColor = [UIColor redColor].CGColor;
    //发射位置
    snowLayer.emitterPosition = CGPointMake(0, -5.f);
    //发射源的尺寸
    snowLayer.emitterSize = CGSizeMake(640, 1);
    //发射源的形状
    snowLayer.emitterMode = kCAEmitterLayerVolume;
    //发射模式
    snowLayer.emitterShape = kCAEmitterLayerCuboid;
    
    //存放粒子种类的数组
    NSMutableArray *snow_array = @[].mutableCopy;
    
    for (NSInteger i=1; i<5; i++) {
        //snow
        CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
        snowCell.name = @"emoji";
        //产生频率
        snowCell.birthRate = 1.0f;
        //生命周期
        snowCell.lifetime = 35.0f;
        //运动速度
        snowCell.velocity = 2.5f;
        //运动速度的浮动值
        snowCell.velocityRange = 15;
        //y方向的加速度
        snowCell.yAcceleration = 3;
        //抛洒角度的浮动值
        snowCell.emissionRange = 0.5*M_PI;
        //自旋转角度范围
        snowCell.spinRange = 0.25*M_PI;
        //粒子透明度在生命周期内的改变速度
        snowCell.alphaSpeed = 2.0f;
        //cell的内容，一般是图片
        NSString *emoji_str = [NSString stringWithFormat:@"kiss"];
        snowCell.contents = (id)[UIImage imageNamed:emoji_str].CGImage;
        
        [snow_array addObject:snowCell];
    }
    
    //添加到当前的layer上
    snowLayer.shadowColor = [[UIColor redColor]CGColor];
    snowLayer.cornerRadius = 1.0f;
    snowLayer.shadowOffset = CGSizeMake(1, 1);
    snowLayer.emitterCells = [NSArray arrayWithArray:snow_array];
    [self.view.layer insertSublayer:snowLayer atIndex:0];
}

@end
