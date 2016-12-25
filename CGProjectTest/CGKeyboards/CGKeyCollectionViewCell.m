//
//  CGKeyCollectionViewCell.m
//  CGProjectTest
//
//  Created by LeoCai on 8/26/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGKeyCollectionViewCell.h"
#import "Masonry.h"
#import "CGMarco.h"

@interface CGKeyCollectionViewCell()
@property (strong, nonatomic) UILabel *key;

@end

@implementation CGKeyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        
        [self configure:nil];
    }
    return self;
}

#pragma mark - lazy subviews
-(UILabel *)key{
    if (!_key) {
        _key = [UILabel new];
        _key.textAlignment = NSTextAlignmentCenter;
        _key.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_key];
        
        [_key mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-ONE_PIXEL);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-ONE_PIXEL);
        }];
    }
    return _key;
}

#pragma mark - configure
-(void)configure:(NSString *)text{
    self.key.text = text;
}

@end
