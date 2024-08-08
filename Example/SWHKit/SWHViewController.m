//
//  SWHViewController.m
//  SWHKit
//
//  Created by reddream520 on 07/29/2024.
//  Copyright (c) 2024 reddream520. All rights reserved.
//

#import "SWHViewController.h"
#import "SWHWegetController.h"

@interface SWHViewController ()

@end

@implementation SWHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SWHKit";
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)wegetClickAction:(UIButton *)sender {
    SWHWegetController *vc = [[SWHWegetController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
