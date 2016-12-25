//
//  CGKeyboardInputCollectionViewCell.h
//  CGProjectTest
//
//  Created by LeoCai on 8/26/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGKeyboardInputCollectionViewCell : UICollectionViewCell

-(void)configure:(NSObject *)object;


/**
 *  get input
 */
-(NSString *)getInputText;

/**
 *  input
 */
-(void)inputText:(NSString *)text;

/**
 *  delete input
 */
-(void)deletInput;

/**
 *  enter
 */
-(void)enterInput:(NSString *)key;
@end
