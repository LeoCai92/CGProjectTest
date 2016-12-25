//
//  ExpandCell.m
//  MasonryExample
//
//  Created by zorro on 15/12/5.
//  Copyright © 2015年 tutuge. All rights reserved.
//

#import "ExpandCell.h"
#import "ExpandDataEntity.h"
#import "Masonry.h"

@interface ExpandCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIButton *moreButton;

@property (strong, nonatomic) MASConstraint *contentHeightConstraint;

@property (weak, nonatomic) ExpandDataEntity *entity;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation ExpandCell

#pragma mark - Init

// 调用UITableView的dequeueReusableCellWithIdentifier方法时会通过这个方法初始化Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - Public method

- (void)setEntity:(ExpandDataEntity *)entity indexPath:(NSIndexPath *)indexPath {
    _entity = entity;
    _indexPath = indexPath;
    _titleLabel.text = [NSString stringWithFormat:@"index: %ld, contentView: %p", (long) indexPath.row, (__bridge void *) self.contentView];
    _contentLabel.text = entity.content;

    //review cg改变cell高度的关键部分
    if (_entity.expanded) {
        [_contentHeightConstraint uninstall];// 从约束数组中移除
    } else {
        [_contentHeightConstraint install];// 再次添加约束
    }
}

#pragma mark - Actions

- (void)switchExpandedState:(UIButton *)button {
    [_delegate ExpandCell:self switchExpandedStateWithIndexPath:_indexPath];
}

#pragma mark - Private method

- (void)initView {
    // Title
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@21);
        make.left.and.right.and.top.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(4, 8, 4, 8));
    }];

    // More button
    _moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_moreButton setTitle:@"More" forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(switchExpandedState:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreButton];

    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@32);
        make.left.and.right.and.bottom.equalTo(self.contentView);
    }];

    // Content
    // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，
    // 因为屏幕宽度不确定，否则系统无法决定Label的宽度，导致文本内容单行显示。
    CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 16;

    // Content - 多行
    _contentLabel = [UILabel new];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.clipsToBounds = YES;
    // review cg？？？？？？
    _contentLabel.preferredMaxLayoutWidth = preferredMaxWidth; // 多行时必须设置
    [self.contentView addSubview:_contentLabel];

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(4, 8, 4, 8));
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(4);
        make.bottom.equalTo(_moreButton.mas_top).with.offset(-4);
        // 先加上高度的限制
        // 优先级只设置成High，保证一开始内容不会都被展开
        // priority(751)：直接设置数值
        _contentHeightConstraint = make.height.equalTo(@64).with.priorityHigh();
        
    }];
}

@end
