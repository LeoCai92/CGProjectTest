//
//  CGAddTitleCollectionViewCell.m
//  CGProjectTest
//
//  Created by LeoCai on 8/25/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGAddTitleCollectionViewCell.h"
#import "Masonry.h"

@interface CGAddTitleCollectionViewCell()

@end

@implementation CGAddTitleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.title];
    }
    return self;
}

#pragma mark - lazy subviews
-(UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_title];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return _title;
}

@end
