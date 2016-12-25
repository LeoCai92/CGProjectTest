//
//  CGLeftIntricRightSlideViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/24/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//
/**
 *  目的：固定最左边的一列，右边的其他列可以水平滚动
 *  思路：
 *      1、UITableView；
 *      2、UITableViewCell：UILabel+UIScrollView；
 *      3、Delegate：保证滑动其中一行时，其他行都联动向左或者右滑动；
 *      4、scrollViewDidScroll:保证上下滑动时，右边列联动显示。
 *
 */


#import "CGLeftIntricRightSlideViewController.h"


#define kRowNums 100
#define kLinkScrolling @"LinkScrolling"
@interface CGLeftIntricRightSlideViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CGPoint contentOffset;
@end

@implementation CGLeftIntricRightSlideViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init subviews
-(void)initTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return kRowNums;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGLeftIntricRightSlideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CGLeftIntricRightSlideTableViewCell class])];
    if (!cell) {
        cell = [[CGLeftIntricRightSlideTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CGLeftIntricRightSlideTableViewCell class])];
        cell.delegate = self;
    }
    CGLeftInstricRightSlideModel *model = [CGLeftInstricRightSlideModel new];
    model.title = [NSString stringWithFormat:@" row %zd",indexPath.row];
    model.content = [self longText];
    [cell configure:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[CGLeftIntricRightSlideTableViewCell class]]) {
         [self linkScrollAllVisibleCellWithContentOffset:_contentOffset];
    }
}

#pragma mark - CGLeftIntricRightSlideLinkScrollDelegate
-(void)linkScrollAllVisibleCellWithContentOffset:(CGPoint)contentOffset{
    _contentOffset = contentOffset;
    NSArray *visibleCells = [self.tableView visibleCells];
    for (CGLeftIntricRightSlideTableViewCell *cell in visibleCells) {
        [cell.scrollView setContentOffset:contentOffset];
    }
}

#pragma mark - others
-(NSString *)longText{
    return @"A long long long long long long long long long long long text!";
}

@end
