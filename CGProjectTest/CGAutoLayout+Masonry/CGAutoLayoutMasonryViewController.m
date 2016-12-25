//
//  CGAutoLayoutMasonryViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/12/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGAutoLayoutMasonryViewController.h"
#define MAS_SHORTHAND
#import "Masonry.h"
#import "CGMarco.h"

@interface CGAutoLayoutMasonryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@property (strong, nonatomic) UILabel *label3;
@property (strong,nonatomic) NSString *storyBoard;
@property (strong,nonatomic) NSString *storyBoardID;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) UIButton *showOrhideTop;
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) MASConstraint *containerViewWidthConstraint;
@end

@implementation CGAutoLayoutMasonryViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"CGAutoLayoutMasonryViewController--------presentingViewController:%@",self.presentingViewController);
    NSLog(@"CGAutoLayoutMasonryViewController----------presentedViewController:%@",self.presentedViewController);
    
    [self initNaviBar];
    
    [self sampleViewControllerMASAdditions];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

#pragma mark - DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:12.f];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor blackColor];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
#pragma mark - Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.hidden = YES;
    
    NSString *selectorName = self.titles[indexPath.row];
    SEL selector = NSSelectorFromString(selectorName);
    if ([self respondsToSelector:selector]) {
        self.title = selectorName;
        [self performSelector:selector withObject:nil];
    }
}

#pragma mark - init subviews
-(void)initNaviBar{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(changeItem)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)initTableView{
    CGFloat width = 200.f;
    CGFloat height = 300.f;
    CGFloat y = 64.f;
    CGFloat x = SCREEN_WIDTH - width - 8;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.layer.borderWidth = 1.f;
    self.tableView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

-(void)initSubviews{
    CGFloat padding = 10;
    
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        /*
         * label1.top = 1.0*self.view.top+64;
         * 添加 top 约束
         * NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64];
         
         * [self.view addConstraint:topConstraint];
         */
        
        /* 1、make.top 创建MASViewConstraint类型对象：firstViewAttribute（MASViewAttribute）
         *
         * 2-1如果是数值，设置的是offset属性，最终赋值给layoutConstant属性
         * 2-2创建：secondViewAttribute
         * 2-3如果secondViewAttribute==nil，在调用[MASViewConstraint install]时，设置相对于父试图的约束
         * 3-1约束生效：closestCommonSuperview
         * 3-2约束生效：[self.installedView addConstraint:layoutConstraint];
         */
        /* mas_equalTo               ==
         * mas_greaterThanOrEqualTo  >=
         * mas_lessThanOrEqualTo     <=
         */
        make.top.mas_equalTo(64);//类似的每一句最终返回的是MASViewConstraint类型对象
        /* 1、mas_equalTo：宏定义
         * 2、调用equalTo返回block
         * 3、mas_equalTo()执行block
         */
        
        make.left.mas_equalTo(padding);//.multipliedBy(2)
        make.height.mas_equalTo(115);
        make.width.equalTo(_label2);
        make.right.equalTo(_label2.mas_left).offset(-10);
//        make.edges
//        make.size
        
        /*
         * 1、make.width.height...：返回MASCompositeConstraint类型对象
         *
         */
//        make.width.height.mas_equalTo(50.f);
        
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.height.mas_equalTo(115);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.equalTo(_label1);
        
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_label1.mas_bottom).offset(padding);
        make.left.mas_equalTo(padding);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
    }];
    
}
#pragma mark - lazy subviews
-(UILabel *)label1{
    if (!_label1) {
        self.label1 = [UILabel new];
        self.label1.text = @"label1";
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.label1.backgroundColor = [UIColor orangeColor];
    }
    return _label1;
}

-(UILabel *)label2{
    if (!_label2) {
        self.label2 = [UILabel new];
        self.label2.text = @"label2";
        self.label2.textAlignment = NSTextAlignmentCenter;
        self.label2.backgroundColor = [UIColor brownColor];
    }
    return _label2;
}

-(UILabel *)label3{
    if (!_label3) {
        self.label3 = [UILabel new];
        self.label3.text = @"label3";
        self.label3.textAlignment = NSTextAlignmentCenter;
        self.label3.backgroundColor = [UIColor purpleColor];
    }
    return _label3;
}

-(UIButton *)showOrhideTop{
    if (!_showOrhideTop) {
        _showOrhideTop = [UIButton new];
        [self.view addSubview:_showOrhideTop];
        
        _showOrhideTop.backgroundColor = [UIColor purpleColor];
        [_showOrhideTop setTitle:@"showOrhideTop" forState:UIControlStateNormal];
        [_showOrhideTop addTarget:self action:@selector(showOrHideTopBar:) forControlEvents:UIControlEventTouchUpInside];
        
        [_showOrhideTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200.f);
            make.height.mas_equalTo(50.f);
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).offset(-150.f);
        }];
    }
    return _showOrhideTop;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:_topView];
        
//        self.view.mas_key = @"view";
//        _topView.mas_key = @"_topView";
        MASAttachKeys(self.view,_topView);// Debug
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.left.and.right.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuide);
            //make.top.mas_equalTo(self.topLayoutGuide.length);
        }];
    }
    return _topView;
}

/*
-(UIButton *)showOrhideBottom{
    if (!_showOrhideBottom) {
        _showOrhideBottom = [UIButton new];
        _showOrhideBottom.backgroundColor = [UIColor orangeColor];
        [_showOrhideBottom setTitle:@"showOrhideBottom" forState:UIControlStateNormal];
        [self.view addSubview:_showOrhideBottom];
        
        [_showOrhideBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200.f);
            make.height.mas_equalTo(50.f);
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).offset(150.f);
        }];
    }
    return _showOrhideBottom;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.left.and.right.equalTo(self.view);
            //make.bottom.equalTo(self.mas_bottomLayoutGuide);
        }];

    }
    return _bottomView;
}
*/

#pragma mark - sampleShortLong

-(void)sampleShortLong{
    //1、自身内容尺寸约束与抗压抗拉
    [self sampleCodeWithY:50 andString:[self aShortAddress]];
    [self sampleCodeWithY:150 andString:[self aLongAddress]];
}
- (NSString *)aLongAddress{
    return @"A long long long long long long long long address";
}
- (NSString *)aShortAddress{
    return @"A short address";
}
- (void)sampleCodeWithY:(CGFloat)y andString:(NSString *)string{
    UIView *layoutView = [UIView new];
    layoutView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, 100);
    layoutView.backgroundColor = [[UIColor alloc] initWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [self.view addSubview:layoutView];
    
    UILabel *address = [[UILabel alloc] init];
    [layoutView addSubview:address];
    address.text = @"地址:";
    address.backgroundColor = [UIColor blueColor];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(layoutView);
        make.left.equalTo(layoutView).offset(10);
    }];
    //解决办法，设置水平抗压缩
    [address setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UITextField *addressTextField = [[UITextField alloc] init];
    [layoutView addSubview:addressTextField];
    addressTextField.returnKeyType = UIReturnKeyDone;
    addressTextField.font = [UIFont systemFontOfSize:15];
    addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    addressTextField.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    addressTextField.layer.borderColor =  [[[UIColor alloc] initWithRed:1 green:1 blue:0 alpha:1] CGColor];
    addressTextField.layer.cornerRadius = 3;
    addressTextField.text = string;
    [addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(address);
//        make.width.mas_equalTo(100);
        make.centerY.equalTo(address);
        make.right.equalTo(layoutView.mas_right).offset(-10);
        make.left.equalTo(address.mas_right).offset(10);
    }];
}

#pragma mark - edges | size | center
- (void)sampleEdgesSizeCenter{
    
    // edges | size | center
    UIView *v1 = [UIView new];
    [self.view addSubview:v1];
    v1.backgroundColor = [UIColor orangeColor];
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        /*
         * 1、make.size：分别创建width|height的MASViewConstraint
         * 2、make.size：返回MASCompositeConstraint类型对象
         */
        
    }];
    
    UIView *v2 = [UIView new];
    v2.backgroundColor = [UIColor brownColor];
    [self.view addSubview:v2];
    [v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v1.mas_bottom).offset(10);
        make.left.mas_equalTo(100);
        make.size.equalTo(v1);
    }];
}

#pragma mark - multipliedBy
-(void)sampleMultipliedBy{
    
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(8.f);
        make.top.equalTo(self.view).offset(64+8.f);
        
        _containerViewWidthConstraint = make.width.mas_equalTo(SCREEN_WIDTH - 16.f);
        make.height.mas_equalTo(150.f);
    }];
    
    UIView *subView = [UIView new];
    subView.backgroundColor = [UIColor orangeColor];
    [containerView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(containerView.mas_left);
        make.top.equalTo(containerView.mas_top);
        make.bottom.equalTo(containerView.mas_bottom);
        
        //宽度为父view的宽度的一半
        make.width.equalTo(containerView.mas_width).multipliedBy(0.5);
    }];
    
    UISlider *slider = [UISlider new];
    [self.view addSubview:slider];
    
    slider.value = 1.f;
    slider.minimumValue = 0;
    slider.maximumValue = 1.f;
    
    [slider addTarget:self action:@selector(modifyContainerViewWidth:) forControlEvents:UIControlEventValueChanged];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(8.f);
        make.top.equalTo(containerView.mas_bottom).offset(20.f);
        
        make.width.mas_equalTo(SCREEN_WIDTH - 16.f);
        make.height.mas_equalTo(10.f);
        
    }];
    
}

#pragma mark - priorityLow | priorityMedium | priorityHigh
- (UILabel *)labelWithSuperView:(UIView *)superView topView:(UIView *)topView text:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = text;
    [superView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(50.f);
        make.top.equalTo(topView.mas_top).offset(100.f);
    }];
    
    return label;
}

- (void)constraintWidthWithLabel:(UILabel *)label priority:(UILayoutPriority)priority width:(CGFloat)width{

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width).priority(priority);
    }];
}

-(void)samplePriority{
    // Priority ：priorityLow | priorityMedium | priorityHigh
    
    // label1不约束宽度 instrincSize
    UILabel *label1 = [self labelWithSuperView:self.view topView:self.view text:@"label1 hello"];
    
    // label2约束宽度为200，约束的优先级为751，大于Content Hugging Priority(250)
    UILabel *label2 = [self labelWithSuperView:self.view topView:label1 text:@"label2 hello"];
    [self constraintWidthWithLabel:label2 priority:751 width:200];
    
    // label3约束宽度为200，约束的优先级为200，小于Content Hugging Priority(250)
    UILabel *label3 = [self labelWithSuperView:self.view topView:label2 text:@"label3 hello"];
    [self constraintWidthWithLabel:label3 priority:200 width:200];
    
    // label4约束宽度为60，  约束的优先级为751，大于Content Compression Resistance Priority(750)
    UILabel *label4 = [self labelWithSuperView:self.view topView:label3 text:@"label4 hello"];
    [self constraintWidthWithLabel:label4 priority:751 width:60];//当内容实际所需大小>60(给定的)会被压缩
    
    // label5约束宽度为60，  约束的优先级为749，小于Content Compression Resistance Priority(750)
    UILabel *label5 = [self labelWithSuperView:self.view topView:label4 text:@"label5 hello"];
    [self constraintWidthWithLabel:label5 priority:749 width:60];
}

#pragma mark - Array+MASAdditions
-(void)sampleArrayMASAdditions{
    //2个或2个以上的控件等间隔排列
    //keyboard
    static NSUInteger nums = 16;
    static NSUInteger raws = 4;
    CGFloat padding = 5.f;
    CGFloat width = (SCREEN_WIDTH - (raws+1)*padding)/raws;
    CGFloat height = 40.f;
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:nums];
    
    for (int i = 0; i < nums/raws; i++) {
        for (int j = 0; j < raws; j++) {
            UIButton *button = [UIButton new];
            [self.view addSubview:button];
            
            // 第一种：通过计算坐标值，设置frame
//            button.frame = CGRectMake(j*width, 64+i*height, width, height);
            button.backgroundColor = [UIColor orangeColor];
            [button setTitle:[NSString stringWithFormat:@"%zd",buttons.count] forState:UIControlStateNormal];
            
            // 第二种方法：常规方法实现
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(width);
//                make.height.mas_equalTo(height);
//                make.top.equalTo(self.view).offset(i*height+64.f+(i+1)*padding);
//                make.left.equalTo(self.view).offset(j*width+(j+1)*padding);
//            }];
            
            [buttons addObject:button];
        }
        
        NSArray *array = array = [buttons subarrayWithRange:NSMakeRange(i*raws, raws)];
        
        // 第三种方法：定高度，添加top、left、right约束（宽度可变）
        /*1、改动方向：MASAxisTypeHorizontal | MASAxisTypeVertical
         *2、leadSpacing：左边距
         *3、tailSpacing：右边距
         *4、fixedSpacing：中间空格
         [array mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(i*height+64.f+(i+1)*padding);// 这句很重要
         make.height.mas_equalTo(height);
         }];
         [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
         */
        
        
        // 第四种方法：定宽度，添加top、left、right约束（高度固定，水平间距改变）
        [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:width leadSpacing:padding tailSpacing:padding];
        [array mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(i*height+64.f+(i+1)*padding);// 这句很重要
        }];
        
    }
    
}

#pragma mark - ViewControllerMASAdditions
-(void)sampleViewControllerMASAdditions{
    
    [self.view addSubview:self.showOrhideTop];
    [self.view addSubview:self.topView];
    
}

#pragma mark - data
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"initSubviews",
                    @"sampleShortLong",
                    @"sampleEdgesSizeCenter",
                    @"sampleMultipliedBy",
                    @"samplePriority",
                    @"sampleArrayMASAdditions"];
    }
    return _titles;
}

#pragma mark - events
-(void)changeItem{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:UIView.class]) {
            [obj removeFromSuperview];
        }
    }];
    self.title = @"AutoLayout+Masonry";
    [self initTableView];
    
    self.tableView.hidden = !(self.tableView.hidden);
}

- (void)showOrHideTopBar:(id)sender {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:NO];
    // 隐藏、显示了NavigationBar以后，要手动触发updateViewConstraints，更新约束
    [self updateTopViewConstraints];
}

-(void)updateTopViewConstraints{

    // 根据新的length值更新约束
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        // 直接利用其length属性，避免iOS、SDK版本升级后topLayoutGuide不再是UIView
        make.top.equalTo(self.topLayoutGuide).with.offset(self.topLayoutGuide.length);
    }];

}

- (void)modifyContainerViewWidth:(UISlider *)sender {
    if (sender.value) {
        //改变containerView的宽度
        _containerViewWidthConstraint.mas_equalTo(sender.value * (SCREEN_WIDTH - 16.f));
    }
}

#pragma mark - common
-(void)showAlertTitle:(NSString *)title withMessage:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        
        if (!_storyBoard && !_storyBoardID) {
            return;
        }
        
        // 点击确定
        UIStoryboard *Animation = [UIStoryboard storyboardWithName:_storyBoard bundle:nil];
        UIViewController *vc = [Animation instantiateViewControllerWithIdentifier:_storyBoardID];
        if (vc) {
            vc.title = [_storyBoardID stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

@end
