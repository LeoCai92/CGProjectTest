//
//  CGModalTransitionController.m
//  CGProjectTest
//
//  Created by LeoCai on 10/10/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGModalTransitionController.h"

@interface CGModalTransitionController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titles;
@end

@implementation CGModalTransitionController
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *Animation = [UIStoryboard storyboardWithName:@"Animation" bundle:nil];
    UIViewController *vc = [Animation instantiateViewControllerWithIdentifier:@"CGModalViewController"];
    
    UIModalTransitionStyle style;
    switch (indexPath.row) {
        case 0:
            style = UIModalTransitionStyleCoverVertical;
            break;
        case 1:
            style = UIModalTransitionStyleFlipHorizontal;
            break;
        case 2:
            style = UIModalTransitionStyleCrossDissolve;
            break;
        default:
            style = UIModalTransitionStylePartialCurl;
            break;
    }
    vc.modalTransitionStyle = style;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - init
/*
 *  UIModalTransitionStyleCoverVertical = 0,默认
 *  UIModalTransitionStyleFlipHorizontal,翻书
 *  UIModalTransitionStyleCrossDissolve,隐现
 *  UIModalTransitionStylePartialCurl 翻卷
 */
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"UIModalTransitionStyleCoverVertical",
                    @"UIModalTransitionStyleFlipHorizontal",
                    @"UIModalTransitionStyleCrossDissolve",
                    @"UIModalTransitionStylePartialCurl"];
    }
    return _titles;
}

#pragma mark - dismiss
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
