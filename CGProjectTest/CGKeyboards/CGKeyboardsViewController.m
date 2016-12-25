//
//  CGKeyboardsViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/26/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGKeyboardsViewController.h"
#import "CGMarco.h"
#import "Masonry.h"
#import "CGKeyboardInputCollectionViewCell.h"
#import "CGKeyCollectionViewCell.h"
#import "CGAddSheetView.h"

#define kKeyCellHeight 80.f
#define kInputCellHeight 80.f
@interface CGKeyboardsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *keys;
/**
 *  显示输入
 */
@property (strong, nonatomic) CGKeyboardInputCollectionViewCell *inputCell;

@end

@implementation CGKeyboardsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark - data
-(NSArray *)keys{
    if (!_keys) {
        _keys = @[@"1",@"2",@"3",@"⬅︎",
                  @"4",@"5",@"6",@"+",
                  @"7",@"8",@"9",@"-",
                  @"$",@"0",@".",@"↵"];
    }
    return _keys;
}

#pragma mark - init views
-(void)initCollectionView{
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[CGKeyboardInputCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CGKeyboardInputCollectionViewCell class])];
    [self.collectionView registerClass:[CGKeyCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CGKeyCollectionViewCell class])];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;// 第一行固定显示输入数字
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.keys.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        _inputCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGKeyboardInputCollectionViewCell class]) forIndexPath:indexPath];
        return _inputCell;
    }else{
        CGKeyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGKeyCollectionViewCell class]) forIndexPath:indexPath];
        [cell configure:self.keys[indexPath.item]];
        
        return cell;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = SCREEN_WIDTH/4.f;
    CGFloat h = kKeyCellHeight;
    if (indexPath.section == 0) {
        w = SCREEN_WIDTH;
        h = kInputCellHeight;
    }
    return CGSizeMake(w, h);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - UIcollctionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section) {
        NSString *key = self.keys[indexPath.item];
        if ([key isEqualToString:@"⬅︎"]) {
            [_inputCell deletInput];
        }else if ([key isEqualToString:@"$"]) {
            [self showAddSheetView];
            
        }else if ([key isEqualToString:@"↵"]) {
            [_inputCell enterInput:nil];
        }else{
            [_inputCell inputText:key];
        }
    }
}

-(void)showAddSheetView{
    CGAddSheetView *sheetView = [[CGAddSheetView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
    [sheetView showInView:self.view];
}


@end
