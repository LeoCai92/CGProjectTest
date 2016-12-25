//
//  CGModalViewController.m
//  CGProjectTest
//
//  Created by LeoCai on 10/10/16.
//  Copyright © 2016 LeoCai. All rights reserved.
//

#import "CGModalViewController.h"

@interface CGModalViewController ()

@end

@implementation CGModalViewController
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - dismiss
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
