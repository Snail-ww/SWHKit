//
//  SWHStarViewController.m
//  SWHKit_Example
//
//  Created by snail on 2024/8/8.
//  Copyright © 2024 reddream520. All rights reserved.
//

#import "SWHStarViewController.h"
#import "SWHStarView.h"

@interface SWHStarViewController ()

@end

@implementation SWHStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWHStarView *starView = [[SWHStarView alloc]initWithStarSize:CGSizeMake(30, 30) starCount:6 style:SWHStarTypeFloat];
    [self.view addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
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
