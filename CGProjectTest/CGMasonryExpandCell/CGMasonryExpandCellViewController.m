//
//  CGMasonryExpandCellViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/30/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGMasonryExpandCellViewController.h"
#import "Common.h"
#import "ExpandCell.h"
#import "ExpandDataEntity.h"

@interface CGMasonryExpandCellViewController ()<UITableViewDelegate, UITableViewDataSource, ExpandCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ExpandCell *templateCell;

@property (nonatomic, strong) NSArray *data;
@end

@implementation CGMasonryExpandCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // 注册Cell
    [_tableView registerClass:[ExpandCell class] forCellReuseIdentifier:NSStringFromClass([ExpandCell class])];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self generateData];
    [_tableView reloadData];
}

#pragma mark - ExpandCellDelegate

- (void)ExpandCell:(ExpandCell *)cell switchExpandedStateWithIndexPath:(NSIndexPath *)index {
    // 通过_contentHeightConstraint，改变数据
    ExpandDataEntity *dataEntity = _data[(NSUInteger) index.row];
    dataEntity.expanded = !dataEntity.expanded; // 切换展开还是收回
    dataEntity.cellHeight = 0; // 重置高度缓存
    
    // 改变cell高度
    [_tableView beginUpdates];
    [_tableView endUpdates];
    
    // 先重新计算高度,然后reload,不是原来的cell实例
//        [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
    
    // 让展开/收回的Cell居中
    [_tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_templateCell) {
        _templateCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ExpandCell class])];
    }
    
    // 获取对应的数据
    ExpandDataEntity *dataEntity = _data[(NSUInteger) indexPath.row];
    
    // 判断高度是否已经计算过
    if (dataEntity.cellHeight <= 0) {// 未计算高度
        // 填充数据，以便计算实际的高度
        [_templateCell setEntity:dataEntity indexPath:[NSIndexPath indexPathForRow:-1 inSection:-1]];
        // 依据_templateCell计算Cell的实际高度，注意这个“0.5”
        dataEntity.cellHeight = [_templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;
    }
    
    return dataEntity.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ExpandCell class]) forIndexPath:indexPath];
    [cell setEntity:_data[(NSUInteger) indexPath.row] indexPath:indexPath];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Private methods
// 生成数据
- (void)generateData {
    NSMutableArray *tmpData = [NSMutableArray new];
    
    for (int i = 0; i < 20; i++) {
        ExpandDataEntity *dataEntity = [ExpandDataEntity new];
        dataEntity.content = [Common getText:@"case 8 content. " withRepeat:i * 2 + 10];
        [tmpData addObject:dataEntity];
    }
    
    _data = tmpData;
}


@end
