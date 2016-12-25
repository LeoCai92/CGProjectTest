//
//  CGAddNoteTableViewCell.h
//  CGProjectTest
//
//  Created by LeoCai on 8/25/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGAddNoteTableViewCellDelegate <NSObject>

-(void)showAddSheetView;

@end

@interface CGAddNoteTableViewCell : UITableViewCell

@property (weak, nonatomic) id<CGAddNoteTableViewCellDelegate> delegate;

-(void)configue:(NSObject *)object;
@end
