//
//  CGFolderTableViewCellViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 8/24/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//
/**
 *  目的：可以进行行折叠，并可展开查看
 *  思路：
 *      1、UITableView；
 *      2、Section；
 *      3、Delegate：点击时改变每一个section显示的cell数。
 *
 */

#import "CGFolderTableViewCellViewController.h"
#import "CGAddSheetView.h"
#import "CGMarco.h"

#define kRowNums 10
#define kSectionNums 5

@interface CGFolderTableViewCellViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISwitch *isFolderSwitch;
@property (assign, nonatomic) BOOL isFolder;
@property (strong, nonatomic) NSMutableArray *sectionsStateArray;

@end

@implementation CGFolderTableViewCellViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNaviBar];
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data
-(NSMutableArray *)sectionsStateArray{
    if (!_sectionsStateArray) {
        _sectionsStateArray = [NSMutableArray arrayWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO)]];
    }
    return _sectionsStateArray;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isFolder) {
        return 1+kSectionNums;
    }
    return 1+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!section) {
        return 1;
    }
    
    if (_isFolder) {
        BOOL state = [self.sectionsStateArray[section] boolValue];
        if (state) {
            return 1+kRowNums/kSectionNums;
        }
        return 1;
    }
    return kRowNums+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CGAddNoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CGAddNoteTableViewCell class])];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configue:nil];
        return cell;
    }
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_isFolder) {
        cell.imageView.image = [UIImage imageNamed:@"asset-fold-expand"];
        cell.textLabel.text = [NSString stringWithFormat:@"tree section  %zd",indexPath.section];
        BOOL state = [self.sectionsStateArray[indexPath.section] boolValue];
        if (state) {
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"asset-fold-collapse"];
            }else{
                cell.imageView.image = [UIImage imageNamed:@"green_tree_environment"];
                cell.textLabel.text = [NSString stringWithFormat:@"tree row  %zd",indexPath.row];
            }
        }
    }else{
        cell.imageView.image = [UIImage imageNamed:@"green_tree_environment"];
        cell.textLabel.text = [NSString stringWithFormat:@"tree row  %zd",indexPath.row];
    }
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        if (_isFolder) {
            if (indexPath.row == 0) {
                BOOL state = [self.sectionsStateArray[indexPath.section] boolValue];
                self.sectionsStateArray[indexPath.section] = @(!state);
                NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
                [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
}

#pragma mark - CGAddNoteTableViewCellDelegate
-(void)showAddSheetView{
    CGAddSheetView *sheetView = [[CGAddSheetView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
    [sheetView showInView:self.view];
}

#pragma mark - init views
-(UISwitch *)isFolderSwitch{
    if (!_isFolderSwitch) {
        _isFolderSwitch = [UISwitch new];
        [_isFolderSwitch addTarget:self action:@selector(isFolderCell:) forControlEvents:UIControlEventValueChanged];
    }
    return _isFolderSwitch;
}

-(void)initNaviBar{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.isFolderSwitch];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)initTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[CGAddNoteTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CGAddNoteTableViewCell class])];
}

#pragma mark - events
-(void)isFolderCell:(UISwitch *)sender{
    _isFolder = sender.isOn;
    [self.tableView reloadData];
    if (sender.on) {
        //todo 收起
        NSLog(@"收起");
    }else{
        //todo 展开
        NSLog(@"展开");
    }
}

@end
