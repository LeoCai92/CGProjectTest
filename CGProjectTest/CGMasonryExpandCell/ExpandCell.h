//
//  ExpandCell.h
//  MasonryExample
//
//  Created by zorro on 15/12/5.
//  Copyright © 2015年 tutuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExpandDataEntity;
@class ExpandCell;

@protocol ExpandCellDelegate <NSObject>
- (void)ExpandCell:(ExpandCell *)cell switchExpandedStateWithIndexPath:(NSIndexPath *)index;
@end

@interface ExpandCell : UITableViewCell
@property (weak, nonatomic) id <ExpandCellDelegate> delegate;

- (void)setEntity:(ExpandDataEntity *)entity indexPath:(NSIndexPath *)indexPath;
@end
