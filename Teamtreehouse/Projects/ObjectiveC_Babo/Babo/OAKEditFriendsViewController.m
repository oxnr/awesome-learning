//
//  OAKEditFriendsViewController.m
//  Babo
//
//  Created by Onur Akpolat on 28.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import "OAKEditFriendsViewController.h"
#import "MSCellAccessory.h"

@interface OAKEditFriendsViewController ()

@end

@implementation OAKEditFriendsViewController

UIColor *disclosureColour;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Parse.com Query to show users
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error){
            
        }
        else {
            self.allUsers = [NSMutableArray arrayWithArray:objects];
            [self removeCurrentUserFromAllUsers];
            [self.tableView reloadData];
        }
    }];
    
    // Set
    disclosureColour = [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1]; /*#3498db*/
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
    return self.allUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    if ([self isFriend:user]) {
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:disclosureColour];
    }
    else {
        cell.accessoryView = nil;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation *friendsRelation = [self.currentUser relationforKey:@"friendsRelation"];
    
    if ([self isFriend:user]) {
        
        //Uncheck Cell
        cell.accessoryView = nil;
        
        //Remove Friend from friends Array
        for (PFUser *friend in self.friends) {
            if ([friend.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject:friend];
                break;
            }
        }
        
        // Remove Friend relation at Parse.com
        [friendsRelation removeObject:user];
    }
    else {
        //Check Cell
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:disclosureColour];
        
        //Add Friend to friends Array
        [self.friends addObject:user];
        
        // Add Frien relation at Parse.com
        [friendsRelation addObject:user];
    }
    
    // Update CurrentUser Object at Parse.com
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
        }
    }];
    
    //NSLog(@" %@", self.friends);
    //NSLog(@" %lu",(unsigned long)self.friends.count);
}

#pragma mark - Helper methods

- (BOOL) isFriend:(PFUser *)user {
    for (PFUser *friend in self.friends) {
        if ([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }
    
    return NO;
}

- (void) removeCurrentUserFromAllUsers {
    
    // Get Current User
    self.currentUser = [PFUser currentUser];
    
    // Remove Current User from allUsers
    
    for (PFUser *current in self.allUsers) {
        if ([current.objectId isEqualToString:self.currentUser.objectId]) {
            [self.allUsers removeObject:current];
            break;
        }
    }
    
}

@end
