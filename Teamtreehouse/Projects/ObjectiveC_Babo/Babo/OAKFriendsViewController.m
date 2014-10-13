//
//  OAKFriendsViewController.m
//  Babo
//
//  Created by Onur Akpolat on 28.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import "OAKFriendsViewController.h"
#import "OAKEditFriendsViewController.h"

@interface OAKFriendsViewController ()

@end

@implementation OAKFriendsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            
        }
        else {
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEditFriends"]) {
        OAKEditFriendsViewController *viewController = (OAKEditFriendsViewController *)segue.destinationViewController;
        viewController.friends = [NSMutableArray arrayWithArray:self.friends];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    cell.imageView.image = [UIImage imageNamed:@"icon_person"];
    
    return cell;
}

@end
