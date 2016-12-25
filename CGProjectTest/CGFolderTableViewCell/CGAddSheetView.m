//
//  CGSheetView.m
//  CGProjectTest
//
//  Created by LeoCai on 8/25/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGAddSheetView.h"
#import "Masonry.h"
#import "CGMarco.h"
#import "CGAddTitleCollectionViewCell.h"

#define kTitleHeight 40.f

@interface CGAddSheetView()
@property (strong, nonatomic) UIView *maskView;
// banner view
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) UIView  *indicatorLine;
// content view
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITableView  *tableView;
@end

@implementation CGAddSheetView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
        [self addSubview:self.indicatorLine];
        [self addSubview:self.scrollView];
        [self initContentView];
    }
    return self;
}

#pragma mark - data
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"大",@"家",@"好"];
    }
    return _titles;
}

#pragma mark - lazy sibviews
-(UIView *)maskView{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0.5;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTitleHeight) collectionViewLayout:flowLayout];
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[CGAddTitleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CGAddTitleCollectionViewCell class])];
    }
    return _collectionView;
}

-(UIView *)indicatorLine{
    if(!_indicatorLine) {
        CGFloat x = 20.f;
        CGFloat width = SCREEN_WIDTH/self.titles.count - x*2.0;
        CGFloat height = 2.f;
        CGFloat y = kTitleHeight - height;
        _indicatorLine = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _indicatorLine.backgroundColor = [UIColor greenColor];
    }
    return _indicatorLine;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        [self addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self.collectionView.mas_bottom);
            make.bottom.equalTo(self);
        }];
    }
    return _scrollView;
}

-(void)initContentView{
    CGSize size = self.frame.size;
    CGFloat width = size.width;
    CGFloat height = size.height - kTitleHeight;
    for (int i = 0; i < self.titles.count; i++) {
        CGFloat x = i*width;
        CGFloat y = 0;
        // 注意tablView frame必须是已知的，否则无法显示
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [self.scrollView addSubview:tableView];
    }
    [self.scrollView setContentSize:CGSizeMake(width*self.titles.count, height)];
}

#pragma mark - show / hide
-(void)showInView:(UIView *)view{
    self.maskView.frame = view.frame;
    [view insertSubview:_maskView belowSubview:self];
    [view addSubview:self];
    
}

-(void)hide{
    [self.maskView removeFromSuperview];
    [self removeFromSuperview];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.titles.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGAddTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGAddTitleCollectionViewCell class]) forIndexPath:indexPath];
    cell.title.text = self.titles[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = SCREEN_WIDTH/self.titles.count;
    CGFloat h = kTitleHeight;
    return CGSizeMake(w, h);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - UIcollctionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger tag = indexPath.item;
    [self moveIndicatorLineWithTag:tag];
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*tag, 0)];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row %zd %@",indexPath.row,self.titles[tableView.tag]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.f;
}

#pragma mark - UITableViewDelegate


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        CGPoint point = scrollView.contentOffset;
        NSInteger tag = point.x / SCREEN_WIDTH;
        
        [self moveIndicatorLineWithTag:tag];
        NSLog(@"%f",point.x);
    }
}


#pragma mark - reset view
-(void)moveIndicatorLineWithTag:(NSInteger)tag{
    CGSize size = self.indicatorLine.frame.size;
    CGPoint point = self.indicatorLine.frame.origin;
    // 点击标题，移动相应的指示器
    CGFloat x = 20 + tag*(SCREEN_WIDTH/self.titles.count);
    CGFloat y = point.y;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    self.indicatorLine.frame = CGRectMake(x, y, width, height);
}

@end
