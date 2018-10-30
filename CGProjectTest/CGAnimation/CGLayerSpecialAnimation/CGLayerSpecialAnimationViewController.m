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
//    [self setupEmitterLayer];
    
    // Show Replicator Layer
    [self setupReplicatorLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Layer Animation
- (void)setupEmitterLayer
{
    // Using emitter layer to show "kiss emoji" animatio like wechat
    //添加背景图
    UIImage *bgImage = [UIImage imageNamed:@"franke.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
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

- (void)setupReplicatorLayer
{
    // Using replicator layer to show wave animation
    
    CGRect frame = self.view.frame; CGFloat height = 180.f;
    CGRect waveAniViewRect = CGRectMake(0, (frame.size.height - height)/2.f, frame.size.width, height);
    UIView *waveAniView = [[UIView alloc] initWithFrame:waveAniViewRect];
    [self.view addSubview:waveAniView];
    waveAniView.backgroundColor = [UIColor yellowColor];
    
    CGFloat kCicleWidth = height/3.f;
    CGRect roundLayerRect = CGRectMake((waveAniViewRect.size.width - kCicleWidth)/2.f, (waveAniViewRect.size.height - kCicleWidth)/2.f, kCicleWidth, kCicleWidth);
    CAShapeLayer *roundLayer = [CAShapeLayer layer];
    // 两个layerd的frame都要设置, 否则动画会发生偏移
    roundLayer.frame = roundLayerRect;
    roundLayer.fillColor = [UIColor redColor].CGColor;
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, kCicleWidth, kCicleWidth)];
    roundLayer.path = roundPath.CGPath;
    
    // Add scale animation
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAni.fromValue = @1.f;
    scaleAni.toValue = @2.5f;
    // Add alpa animation
    CABasicAnimation *alpaAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpaAni.fromValue = @1.f;
    alpaAni.toValue = @0.;
    
    CAAnimationGroup *groupAni = [CAAnimationGroup animation];
    groupAni.animations = @[scaleAni, alpaAni];
    groupAni.duration = 2.f;
    groupAni.repeatCount = NSIntegerMax;
    [roundLayer addAnimation:groupAni forKey:nil];
    
    CAReplicatorLayer *replicatroLayor = [CAReplicatorLayer layer];
    [replicatroLayor addSublayer:roundLayer];
    // 两个layerd的frame都要设置, 否则动画会发生偏移
    replicatroLayor.frame = roundLayerRect;
    // 设置postion，否则layer不居中
    replicatroLayor.position = CGPointMake(roundLayerRect.size.width/2.f, roundLayerRect.size.height/2.f);
    replicatroLayor.instanceCount = 3;
    replicatroLayor.instanceDelay = 0.5f;
    [waveAniView.layer addSublayer:replicatroLayor];
    
    // A cover rect
    kCicleWidth += 20.f;
    roundLayerRect = CGRectMake((waveAniViewRect.size.width - kCicleWidth)/2.f, (waveAniViewRect.size.height - kCicleWidth)/2.f, kCicleWidth, kCicleWidth);;
    CAShapeLayer *coverRoundLayer = [CAShapeLayer layer];
    coverRoundLayer.frame = roundLayerRect;
    coverRoundLayer.fillColor = [UIColor redColor].CGColor;
    roundLayerRect.origin = CGPointZero;
    coverRoundLayer.path = [UIBezierPath bezierPathWithOvalInRect:roundLayerRect].CGPath;
    [waveAniView.layer addSublayer:coverRoundLayer];
}

#pragma mark - Animation Test
/** compare for implict & explicit animation'effects to layer's origin value */
- (void)compareImplicitAndExplicitAnimation
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [self.view.layer addSublayer:shapeLayer];
    shapeLayer.frame = CGRectMake(150, 150, 100, 100);
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)].CGPath;
    
    // Implicit animation will change layer origin value
    //    shapeLayer.opacity = 0.1f;
    // Explicit animation will not change layer origin value
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAni.fromValue = @1.f;
    basicAni.toValue = @0.1f;
    basicAni.duration = 3.f;
    [shapeLayer addAnimation:basicAni forKey:nil];
}

@end
