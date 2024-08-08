//
//  SWHRotateClockViewController.m
//  SWHKit_Example
//
//  Created by snail on 2024/8/8.
//  Copyright © 2024 reddream520. All rights reserved.
//

#import "SWHRotateClockViewController.h"
#import "SWHKit.h"

@interface SWHRotateClockViewController ()

@end

@implementation SWHRotateClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWHRotateClockView *clockView = [[SWHRotateClockView alloc]initWithTimeInterval:10000];
    [self.view addSubview:clockView];
    [clockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
