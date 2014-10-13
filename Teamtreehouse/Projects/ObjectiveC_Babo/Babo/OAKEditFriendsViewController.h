//
//  OAKEditFriendsViewController.h
//  Babo
//
//  Created by Onur Akpolat on 28.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface OAKEditFriendsViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *allUsers;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSMutableArray *friends;

- (BOOL) isFriend:(PFUser *)user;

@end
