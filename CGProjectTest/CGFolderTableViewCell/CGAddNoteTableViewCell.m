//
//  CGAddNoteTableViewCell.m
//  CGProjectTest
//
//  Created by LeoCai on 8/25/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGAddNoteTableViewCell.h"
#import "Masonry.h"
#import "CGMarco.h"

@interface CGAddNoteTableViewCell()
@property (strong, nonatomic) UIButton    *leftButton;
@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UILabel     *leftLabel;
@property (strong, nonatomic) UIView      *middleLine;
@property (strong, nonatomic) UIButton    *rightButton;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UILabel     *rightLabel;
@end

@implementation CGAddNoteTableViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configue:nil];
    }
    return self;
}

#pragma mark - lazy subviews
-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton new];
        [self.contentView addSubview:_leftButton];
        
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.middleLine);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        
        [_leftButton addTarget:self action:@selector(addCell:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton new];
        [self.contentView addSubview:_rightButton];
        
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.middleLine);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        
        [_rightButton addTarget:self action:@selector(noteCell:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
        [self.contentView addSubview:_leftImageView];
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(13.f);
            make.height.mas_equalTo(13.f);
            make.left.mas_equalTo(75.f);
        }];
    }
    return _leftImageView;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        [self.contentView addSubview:_leftLabel];
        _leftLabel.textColor = [UIColor redColor];
        
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImageView.mas_right).offset(5.f);
            make.right.equalTo(self.middleLine);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];

    }
    return _leftLabel;
}

-(UIView *)middleLine{// 中间灰线
    if (!_middleLine) {
        _middleLine = [UIView new];
        [self.contentView addSubview:_middleLine];
        _middleLine.backgroundColor = [UIColor lightGrayColor];
        
        [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(ONE_PIXEL);
        }];
        
    }
    return _middleLine;
}

-(UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        [self.contentView addSubview:_rightImageView];
        
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.middleLine).offset(75.f);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(13.f);
            make.height.mas_equalTo(13.f);
            
        }];
    }
    return _rightImageView;
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        [self.contentView addSubview:_rightLabel];
        _rightLabel.textColor = [UIColor redColor];
        
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rightImageView.mas_right).offset(5.f);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];

    }
    return _rightLabel;
}

#pragma mark - event
-(void)addCell:(UIButton *)sender{
    NSLog(@"添加");
    
    if ([self.delegate respondsToSelector:@selector(showAddSheetView)]) {
        [self.delegate showAddSheetView];
    }
}

-(void)noteCell:(UIButton *)sender{
    NSLog(@"记录");
}

#pragma mark - configure
-(void)configue:(NSObject *)object{
    self.leftImageView.image = [UIImage imageNamed:@"asset-new-fund"];
    self.leftLabel.text = @"添加";
    
    self.rightImageView.image = [UIImage imageNamed:@"asset-new-fundtrans"];
    self.rightLabel.text = @"记录";
    
    self.leftButton.backgroundColor = [UIColor clearColor];
    self.rightButton.backgroundColor = [UIColor clearColor];
}

@end
