//
//  CGSheetView.h
//  CGProjectTest
//
//  Created by LeoCai on 8/25/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGAddSheetView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

/**
 *  show
 */
-(void)showInView:(UIView *)view;

/**
 *  hide
 */
-(void)hide;

@end
