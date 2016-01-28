//
//  LikedTableViewController.m
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/28/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import "LikedTableViewController.h"
#import "HTTPClient.h"
#import "AthleteModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AthleteView.h"

@interface LikedTableViewController ()

@property (strong) NSArray *likedClients;
@property (strong) NSMutableArray *athleteArray;
@end

@implementation LikedTableViewController

- (id) init {
    if(self = [super init]) {
        self.title = @"Liked";
        [self fetchData];
        self.athleteArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)fetchData {
    [[HTTPClient sharedClient] GET:@"api/mobile/liked/66" parameters:[[HTTPClient sharedClient] paramDictForParams:nil] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        self.likedClients = [responseObject objectForKey:@"client_ids"];
        [self populateData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)populateData {
    for (int i = 0; i < [self.likedClients count]; i++) {
    
        NSNumber *clientID = [self.likedClients objectAtIndex:i];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:53] forKey:@"coach-id"];
        NSDictionary *paramDict = [[HTTPClient sharedClient] paramDictForParams:dict];
        [[HTTPClient sharedClient] GET:[NSString stringWithFormat:@"http://qa.ncsasports.org:80/api/mobile/client/%@", clientID] parameters:paramDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            AthleteModel *athlete = [[AthleteModel alloc] initWithDictionary:responseObject];
            [self.athleteArray addObject:athlete];
            [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:2];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"%@", [error localizedDescription]);
        }];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self fetchData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.likedClients count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"lolkek";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        if(!self.athleteArray || [self.athleteArray count] == 0 || indexPath.row >= [self.athleteArray count]) {
            [cell.textLabel setText:@"Loading..."];
            return cell;
        }
        AthleteModel *athlete = [self.athleteArray objectAtIndex:indexPath.row];
        [cell.imageView setImageWithURL:[NSURL URLWithString:athlete.photoURL] placeholderImage:[AthleteView getRandomImage]];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@, %@ - %@",athlete.firstName, athlete.lastName, athlete.highSchool, athlete.gradYear]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AthleteModel *athlete = [self.athleteArray objectAtIndex:indexPath.row];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = [[AthleteView alloc] initWithAthlete:athlete andOptions:nil];
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
