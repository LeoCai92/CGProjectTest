//
//  CGLeftIntricRightSlideTableViewCell.h
//  CGProjectTest
//
//  Created by LeoCai on 8/24/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLeftInstricRightSlideModel.h"

@protocol CGLeftIntricRightSlideLinkScrollDelegate <NSObject>

-(void)linkScrollAllVisibleCellWithContentOffset:(CGPoint)contentOffset;

@end

@interface CGLeftIntricRightSlideTableViewCell : UITableViewCell<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) id<CGLeftIntricRightSlideLinkScrollDelegate>delegate;

-(void)configure:(CGLeftInstricRightSlideModel *)model;
@end
