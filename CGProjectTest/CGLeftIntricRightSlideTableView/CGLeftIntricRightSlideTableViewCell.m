//
//  CGLeftIntricRightSlideTableViewCell.m
//  CGProjectTest
//
//  Created by LeoCai on 8/24/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGLeftIntricRightSlideTableViewCell.h"
#import "Masonry.h"

//获取设备的物理高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kLeftLableHeight 50
#define kLeftLableWidth 100
#define kLinkScrolling @"LinkScrolling"
@interface CGLeftIntricRightSlideTableViewCell()

@property (strong, nonatomic) UILabel *leftLabel;
@property (strong, nonatomic) UILabel *content;
@end

@implementation CGLeftIntricRightSlideTableViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure:nil];
    }
    return self;
}

#pragma mark - lazy subviews
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kLeftLableWidth, kLeftLableHeight)];
        
        [self.contentView addSubview:_leftLabel];
    }
    return _leftLabel;
}

-(UILabel *)content{
    if (!_content) {
        _content = [UILabel new];
        [self.scrollView addSubview:_content];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView.mas_left);
            make.right.equalTo(self.scrollView.mas_right);
            make.height.equalTo(self.scrollView.mas_height);
        }];
    
    }
    return _content;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self.contentView addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftLabel.mas_right);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(self.leftLabel.mas_height);
        }];
    }
    return _scrollView;
}

#pragma mark - configure
-(void)configure:(CGLeftInstricRightSlideModel *)model{
    self.leftLabel.text = model.title;
    self.content.text   = model.content;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self.delegate respondsToSelector:@selector(linkScrollAllVisibleCellWithContentOffset:)]){
        [self.delegate linkScrollAllVisibleCellWithContentOffset:scrollView.contentOffset];
    }
}

@end
