//
//  CGGraphicsViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 10/18/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGGraphicsViewController.h"

@interface CGGraphicsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *storyBoardID;
@end

@implementation CGGraphicsViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg0"]];
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
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
#pragma mark - Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *Graphics = [UIStoryboard storyboardWithName:@"CGGraphics" bundle:nil];
    UIViewController *vc = [Graphics instantiateViewControllerWithIdentifier:self.storyBoardID[indexPath.row]];
    if (vc) {
        vc.title = _titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - init
-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"CGLineChart",
                    @"CGCurveChart",
                    @"CGBarChart",
                    @"CGPieChart"];
    }
    return _titles;
}

-(NSArray *)storyBoardID{
    if (!_storyBoardID) {
        _storyBoardID = @[@"CGLineChartViewController",
                          @"CGCurveChartViewController",
                          @"CGBarChartViewController",
                          @"CGPieChartViewController"];
    }
    return _storyBoardID;
}

@end
