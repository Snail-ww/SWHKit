//
//  SWHWegetController.m
//  SWHKit_Example
//
//  Created by snail on 2024/8/8.
//  Copyright © 2024 reddream520. All rights reserved.
//

#import "SWHWegetController.h"

@interface SWHWegetController ()

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation SWHWegetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Weget";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"WegetCellIdentifier"];
    _dataArray = @[
        @{
            @"title":@"SWHStarView",
            @"class":@"SWHStarViewController",
        },@{
            @"title":@"SWHRotateClockView",
            @"class":@"SWHRotateClockViewController",
        }
    ];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WegetCellIdentifier" forIndexPath:indexPath];
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"title"];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *class = dic[@"class"];
    UIViewController *vc = [NSClassFromString(class) new];
    vc.title = dic[@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
